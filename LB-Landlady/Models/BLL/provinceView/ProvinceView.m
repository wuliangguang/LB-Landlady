//
//  ProvinceView.m
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/29.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "ProvinceView.h"
#import "ProvinceCell.h"
#import "ProinceModel.h"
#import "ProinceListModel.h"
@interface ProvinceView ()
@property(nonatomic)NSMutableArray *dataArr;
@end
@implementation ProvinceView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        self.bounces = NO;
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([ProvinceCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ProvinceCell class])];
        self.separatorStyle = NO;
        [self updateDownMdoel];
    }
    return self;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, 43,kScreenWidth, 1)];
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(kScreenWidth - 5 - 50, 0, 50, 43);
    [sureButton setTitle:@"完成" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(buttonBlcok:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:sureButton];
    UILabel *proLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, kScreenWidth-5-5-5-50, 43)];
    proLabel.text = @"请选择所属省市:";
    proLabel.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:proLabel];
    line.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:line];
    return headerView;
}
- (void)buttonBlcok:(UIButton *)button{
    if (self.addTouchBlcok) {
        self.addTouchBlcok();
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProvinceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProvinceCell class])];
    ProinceModel *model = self.dataArr[indexPath.row];
    [cell updateModel:model];
    return cell;
}
- (void)updateDownMdoel{
    NSDate *date = [[NSDate alloc]init];
    
    NSString *serNum = [NSString toUUIDString];
    NSString *source = @"app";
    NSString *reqTime;
    reqTime = [date toString];
    NSArray *rurur = @[
                       @{@"name":@"source",@"detailStr":source},
                       @{@"name":@"serNum",@"detailStr":serNum},
                       @{@"name":@"reqTime",@"detailStr":reqTime},
                       ];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dict in rurur) {
        SendRequestModel *model = [[SendRequestModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [dataArray addObject:model];
    }
    NSString *sign = [SendRequestModel backStrFromeArr:dataArray];
    
    NSDictionary *parms = @{@"source":source,@"serNum":serNum,@"reqTime":reqTime,@"sign":sign};
    [S_R LB_PostWithURLString:[URLService getProinveListUrl] WithParams:parms WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"----------------获取省市列表%@",responseObject);
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[ProinceListModel class]];
        if (commonModel.code == SUCCESS_CODE) {
            ProinceListModel *model = (ProinceListModel*)commonModel.data;
            for (NSDictionary *dict in model.modelList) {
                ProinceModel *model = [[ProinceModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataArr addObject:model];
            }
            [self reloadData];
        }
    } failure:^(NSError *error) {
        
    } WithController:[self viewController]];

}
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;  
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProinceModel * model = self.dataArr[indexPath.row];
    if (self.proinvceBlcok) {
        self.proinvceBlcok(model.provinceId,model.province);
    }
}
-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
