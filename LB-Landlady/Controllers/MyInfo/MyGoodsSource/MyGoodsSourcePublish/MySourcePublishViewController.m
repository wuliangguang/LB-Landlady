//
//  MySourcePublishViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/18/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MySourcePublishViewController.h"
#import "ZZAddImageView.h"
#import "MySourcePublicCategoryView.h"
#import "MySourcePublicTimeView.h"
#import "MySourcePublicTimeChooseView.h"
#import "MySourcePublicNameView.h"
#import "MySourcePublicDetailView.h"
#import "MySourcePublicInputView.h"
#import "MyMerchantCategoryViewController.h"
#import "ZZDatePickerView.h"
#import "MySourcePublicTimeOptionView.h"
#import "ZZActionButton.h"
#import <LianBiLib/Base64.h>
#import "MBProgressHUD+ZZConvenience.h"
#import "UIImage+Base64.h"
#import "NSDate+Helper.h"
#import "NSDate+Escort.h"

@interface MySourcePublishViewController ()

/* UIs */
@property (nonatomic) UIScrollView               *scrollView;

/**
 *  图片上传
 */
@property (nonatomic,strong)ZZAddImageView *addView;

/**
*  货源类别
*/
@property (nonatomic) MySourcePublicCategoryView *categoryView;

/**
 *  有效时间
 */
@property (nonatomic) MySourcePublicTimeView     *timeView;

/**
 *  超始时间 | 结束时间
 */
@property (nonatomic) MySourcePublicTimeChooseView *timeChooseView;

/**
 *  货源名称
 */
@property (nonatomic,strong)MySourcePublicNameView *nameView;

/**
 *  详情
 */
@property (nonatomic) MySourcePublicDetailView   *detailView;

/**
 *  数量 价格
 */
@property (nonatomic) NSMutableArray *inputViewArray;
@property(nonatomic,strong)UIImage * imageBuffer;
@end

@implementation MySourcePublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.title = @"货源发布";
    
    // scroll view
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight-120)];
    self.view.backgroundColor = self.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.scrollView];

    // 图片上传
    _addView = [self getView:[ZZAddImageView class]];
    _addView.frame = CGRectMake(0, 0, self.view.frame.size.width, _addView.frame.size.height);
    
    [self.scrollView addSubview:_addView];
    
    // 货源类别
    CGFloat padding    = 10.0f;
    self.categoryView  = [self getView:[MySourcePublicCategoryView class]];
    self.categoryView.frame = CGRectMake(0, CGRectGetMaxY(_addView.frame)+padding, self.view.frame.size.width, 44);
    __weak __typeof(self) weakself = self;
    self.categoryView.callbackHandler = ^() {
        MyMerchantCategoryViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantCategoryViewController class]) bundle:nil] instantiateInitialViewController];
        controller.callbackHandler = ^(IndustryModel *model) {
           // NSLog(@"%@", model.maj_name);
            weakself.categoryView.model = model;
        };
        [weakself.navigationController pushViewController:controller animated:YES];
    };
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
    [self.scrollView addSubview:self.categoryView];
    
    // 有效时间
    self.timeView = [self getView:[MySourcePublicTimeView class]];
    self.timeView.model = [[MySourcePublicTimeModel alloc] initWithType:MySourcePublicTimeOptionTypeWeek info:@"7日内"];
    // timeView.translatesAutoresizingMaskIntoConstraints = NO;
    self.timeView.callbackHandler = ^() {
        [weakself showTimeOptionView];
    };
    self.timeView.frame = CGRectMake(0, CGRectGetMaxY(self.categoryView.frame), self.view.frame.size.width, 44);
    [self.scrollView addSubview:self.timeView];
    
    // 起始时间/结束时间
    self.timeChooseView = [self getView:[MySourcePublicTimeChooseView class]];
    __weak typeof(MySourcePublicTimeChooseView *) weakTimeChooseView = self.timeChooseView;
    self.timeChooseView.startTimeCallback = ^(NSDate *date) {
        [ZZDatePickerView showWithTitle:@"起始时间" date:date completionHandler:^(NSDate *date) {
            NSLog(@"%@", date.toString);
            weakTimeChooseView.startDate = date;
        }];
    };
    self.timeChooseView.endTimeCallback = ^(NSDate *date) {
        [ZZDatePickerView showWithTitle:@"起始时间" date:date completionHandler:^(NSDate *date) {
            NSLog(@"%@", date.toString);
            weakTimeChooseView.endDate = date;
        }];
    };
    self.timeChooseView.frame = CGRectMake(0, CGRectGetMaxY(self.timeView.frame), self.view.frame.size.width, 88.0);
    [self.scrollView addSubview:self.timeChooseView];
    
    // 请输入货源名称
    _nameView = [self getView:[MySourcePublicNameView class]];
    _nameView.frame = CGRectMake(0, CGRectGetMaxY(self.timeChooseView.frame)+padding, self.view.frame.size.width, 44);
    [self.scrollView addSubview:_nameView];
    
    // 请输入货源详情
    self.detailView = [self getView:[MySourcePublicDetailView class]];
    self.detailView.frame = CGRectMake(0, CGRectGetMaxY(_nameView.frame), self.view.frame.size.width, 150);
    self.detailView.textView.placeholder = @"请输入货源详情";
    [self.scrollView addSubview:self.detailView];
    // detailView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    // 输入数量/价格
    self.inputViewArray = [NSMutableArray array];
    [self addObserver:self forKeyPath:@"inputViewArray" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];     // KVO监听数组变化
    [self addInputView];
    
    // 发布
    UIButton *button       = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame           = CGRectMake(20, CGRectGetMaxY(self.view.frame)-120, self.view.frame.size.width-40, 40);
    button.backgroundColor = [UIColor redColor];
    [button.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [button setTitle:@"发  布" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(publish:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [self hiddenTimeView];
}

- (id)getView:(Class)cls {
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(cls) owner:nil options:nil] firstObject];
    return view;
}

- (void)removeInputView:(MySourcePublicInputView *)inputView {
    [inputView removeFromSuperview];
    [[self mutableArrayValueForKeyPath:@"inputViewArray"] removeObject:inputView];
}

- (void)addInputView {
    MySourcePublicInputView *inputView = [self getView:[MySourcePublicInputView class]];
    if (self.inputViewArray.count > 0) {
        inputView.unitField.text = [self.inputViewArray.lastObject unitField].text;
    }
    __weak __typeof(self) weakself = self;
    inputView.textDidChangeCallback = ^(id obj) {
        NSString *input = (NSString *)obj;
        for (MySourcePublicInputView *view in self.inputViewArray) {
            if (view != inputView) {
                view.unitField.text = input;
            }
        }
    };
    [[self mutableArrayValueForKey:@"inputViewArray"] addObject:inputView];
    
    // 点击＋或－
    inputView.callbackHandler = ^(MySourcePublicInputView *inputView) {
        switch (inputView.mode) {
            case MySourcePublicInputViewModeAdd:
                [weakself addInputView];
                break;
            case MySourcePublicInputViewModeSubtract:
                [weakself removeInputView:inputView];
            default:
                break;
        }
    };
}

#pragma mark - KVO for inputViewArray
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (![keyPath isEqualToString:@"inputViewArray"]) {
        return;
    }
    
    NSMutableArray *newArray = change[@"new"];
    NSMutableArray *oldArray = change[@"old"];
    if (newArray.count > oldArray.count) { // +
        MySourcePublicInputView *inputView = [self.inputViewArray lastObject];
        [self.scrollView addSubview:inputView];
        [self refreshInputViews];
    } else { // -
        [self refreshInputViews];
    }
}

/**
 * 需求：最后一个是加号，如果到达了5个，则全是减号
 */
- (void)refreshInputViews {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = CGRectMake(0, CGRectGetMaxY(self.detailView.frame)+10, self.view.frame.size.width, 50);
        for (NSInteger i = 0; i < self.inputViewArray.count; i++) {
            MySourcePublicInputView *inputView = self.inputViewArray[i];
            inputView.mode = MySourcePublicInputViewModeSubtract;
            if (i != 0) {
                frame = [[self.inputViewArray objectAtIndex:i-1] frame];
                inputView.frame = frame;
                frame.origin.y = CGRectGetMaxY(frame);
            }
            
            inputView.frame = frame;
            
            if (i >= self.inputViewArray.count - 1 && self.inputViewArray.count < 5) {
                inputView.mode = MySourcePublicInputViewModeAdd;
            }
        }
    } completion:^(BOOL finished) {
        [self refreshContentSize];
    }];
}

- (void)refreshContentSize {
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, CGRectGetMaxY([[self.inputViewArray lastObject] frame]));
}

- (void)publish:(id)sender {
    /**
     * @param industryId          string   行业
     * @param unit                string   单位
     * @param price               string   金额
     */
    NSDictionary *params = [self verifyInputData];
    if (params) {
        [S_R LB_PostWithURLString:[URLService getAddProductSourceUrl] WithParams:params WithSuccess:^(id responseObject, id responseString) {
            NSLog(@"%@", responseString);
            if ([[responseObject objectForKey:@"code"] integerValue] == SUCCESS_CODE) {
                [MBProgressHUD showSuccessToast:@"发布成功" inView:self.view completionHandler:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } else {
                [MBProgressHUD showFailToast:@"发布失败" inView:self.view completionHandler:nil];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
        } WithController:self];
    }
}

/**
 *  验证用户输入
 */
- (NSDictionary *)verifyInputData {
    // 图片上传
    if (self.addView.imageBuffer == nil) {
        [MBProgressHUD showFailToast:@"上传图片不可为空" inView:self.view completionHandler:nil];
        return nil;
    }
    // NSString *image = [Base64 stringByEncodingData:UIImageJPEGRepresentation(self.addView.imageView.image, 1.0)];
    NSString *image = self.addView.imageView.image.base64Str;
    
    // 货源类别
    NSString *industryId = self.categoryView.model.industryId;
    if (industryId.length <= 0) {
        [MBProgressHUD showFailToast:@"请选择货源类别" inView:self.view completionHandler:nil];
        return nil;
    }
   
    // 有效时间
    NSString *validStartDate = nil;
    NSString *validEndDate   = nil;
    NSDate *date = [NSDate date];
    switch (self.timeView.model.type) {
        case MySourcePublicTimeOptionTypeWeek: {
            validStartDate = [date toString];
            validEndDate   = [[date dateByAddingDays:7] toString];
            break;
        }
        case MySourcePublicTimeOptionTypeMonth: {
            validStartDate = [date toString];
            validEndDate   = [[date dateByAddingMonths:1] toString];
            break;
        }
        case MySourcePublicTimeOptionTypeYear: {
            validStartDate = [date toString];
            validEndDate   = [[date dateByAddingYears:1] toString];
            break;
        }
        case MySourcePublicTimeOptionTypeLongTime: {
            validStartDate = [date toString];
            validEndDate   = @"";
            break;
        }
        case MySourcePublicTimeOptionTypeCustom: {
            NSDate *startDate = self.timeChooseView.startDate;
            NSDate *endDate   = self.timeChooseView.endDate;
            if ([startDate compare:endDate] != NSOrderedAscending) {
                [MBProgressHUD showFailToast:@"起始时间要小于结束时间" inView:self.view completionHandler:nil];
                return nil;
            }
            validStartDate = [startDate toString];
            validEndDate   = [endDate toString];
            break;
        }
        default:
            break;
    }
    if (validStartDate.length <= 0) {
        [MBProgressHUD showFailToast:@"时间输入不合法" inView:self.view completionHandler:nil];
        return nil;
    }

    
    // 货源名称
    NSString *productSourceTitle = self.nameView.textField.text;
    if ([productSourceTitle removeWhiteSpacesFromString].length <= 0) {
        [MBProgressHUD showFailToast:@"请输入货源名称" inView:self.view completionHandler:nil];
        return nil;
    }
    
    // 货源详情
    NSString *detail = self.detailView.textView.text;
    if ([detail removeWhiteSpacesFromString].length <= 0) {
        [MBProgressHUD showFailToast:@"请输入货源详情" inView:self.view completionHandler:nil];
        return nil;
    }
    
    // 数量-单位   价格-元
    /**
     * [param setobject:@"50-元,100-元" forkey:@"price"];
     [param setobject:@"100-份，500-份" forkey:@"unit"];
     */
    NSArray *input = [self getInputInfo];
    if (input == nil) {
        return nil;
    }
    
    NSDictionary *dict = @{
                           @"image" : image,
                           @"industryId" : industryId,
                           @"vailidStartDate" : validStartDate,
                           @"validEndDate" : validEndDate,
                           @"productSourceTitle" : productSourceTitle,
                           @"detail" : detail,
                           @"unit" : input[0],
                           @"price" : input[1],
                           @"businessId" : App_User_Info.myInfo.userModel.defaultBusiness
                           };
    
    return dict;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"inputViewArray"];
}

// ----------------------------------------------------------------------------------
/* 选择时间，当周有效｜当月有效｜当年有效｜长期有效｜自定义时间 */
/* TODO:// 因时间关系，此处暂写如此(作简单封装)，有时间再封装 2016-1-19 */
- (void)showTimeOptionView {
    MySourcePublicTimeOptionView *timeOptionView = [[MySourcePublicTimeOptionView alloc] initWithFrame:CGRectZero];
    [timeOptionView showWithType:self.timeView.model.type completionHandler:^(MySourcePublicTimeOptionType type, NSString *str) {
        self.timeView.model = [[MySourcePublicTimeModel alloc] initWithType:type info:str];
        if (type == MySourcePublicTimeOptionTypeCustom) {
            [self showTimeView];
        } else {
            [self hiddenTimeView];
        }
    }];
}

- (void)showTimeView {
    if (self.timeChooseView.hidden == NO) {
        return;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.timeChooseView.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.timeChooseView.hidden = NO;
    }];
    
    for (UIView *view in self.scrollView.subviews) {
        if ([self.scrollView.subviews indexOfObject:view] > [self.scrollView.subviews indexOfObject:self.timeView]) {
            CGRect frame = view.frame;
            frame.origin.y += 88.0;
            view.frame = frame;
        }
    }
    
    [self refreshContentSize];
}

- (void)hiddenTimeView {
    if (self.timeChooseView.hidden == YES) {
        return;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.timeChooseView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.timeChooseView.hidden = YES;
    }];

    for (UIView *view in self.scrollView.subviews) {
        if ([self.scrollView.subviews indexOfObject:view] > [self.scrollView.subviews indexOfObject:self.timeView]) {
            CGRect frame = view.frame;
            frame.origin.y -= 88.0;
            view.frame = frame;
        }
    }
    
    [self refreshContentSize];
}

/**
 *  单位，价格
 */
- (NSArray *)getInputInfo {
    if (self.inputViewArray.count <= 0) {
        return nil;
    }
    // 单位   价格
    NSMutableString *unitStr  = [NSMutableString string];
    NSMutableString *priceStr = [NSMutableString string];
    for (NSInteger i = 0; i < self.inputViewArray.count; i++) {
        MySourcePublicInputView *inputView = self.inputViewArray[i];
        MySourcePublicInputInfoModel *inputModel = [inputView info];
        NSString *errorMsg = [inputModel verifyInputData];
        if (errorMsg != nil) {
            [MBProgressHUD showFailToast:errorMsg inView:self.view completionHandler:nil];
            return nil;
        }
        NSString *format = i != self.inputViewArray.count-1 ? @"%@," : @"%@";
        [unitStr appendFormat:format, inputModel.numString];
        [priceStr appendFormat:format, inputModel.priceString];
    }
    return @[unitStr, priceStr];
}

@end


