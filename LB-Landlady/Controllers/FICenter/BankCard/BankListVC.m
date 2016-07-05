//
//  BankListVC.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/3.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "BankListVC.h"
#import "CustomImage.h"
#import "TopCell.h"
#import "BottomCell.h"
#import <UIImageView+WebCache.h>



@interface BankListVC ()

@property(nonatomic,strong)NSArray * allBankArrar;
@property(nonatomic,strong)NSArray * totalArr;
@property(nonatomic,strong)NSMutableArray * searchedBankArray;/**<查询结果数组*/
@property(nonatomic,assign)BOOL HaveResult;/**<是否为查询后的table*/
@end

@implementation BankListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchedBankArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.bankListTableView.rowHeight = 54 ;
    [self getAllBankName];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------tableViewDelegate------
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 9 ;
    }
    else
    {
        return 0.01 ;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.01 ;
    }
    else
    {
        return 33 ;
    }
}
-(UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return nil ;
    }
    else
    {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 33)];
        view.backgroundColor = [UIColor whiteColor];
        UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 3, 27)];
        imageview.image = [CustomImage imageWithColor:[UIColor redColor] size:imageview.frame.size];
        [view addSubview:imageview];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(19, 5, 200, 27)];
        label.text = @"所有银行";
        label.textAlignment = NSTextAlignmentLeft ;
        label.font = [UIFont systemFontOfSize:15];
        [view addSubview:label];
        return view ;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2 ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1 ;
    }
    else
    {
        if (self.HaveResult) {
            return self.searchedBankArray.count;
        }else
        {
            return self.allBankArrar.count;
        }
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        TopCell * cell = [tableView dequeueReusableCellWithIdentifier:@"top"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TopCell" owner:self options:nil]lastObject];
        }
        cell.searchTF.delegate = self ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange:) name:UITextFieldTextDidChangeNotification object:cell.searchTF];
        return cell ;
    }
    else
    {
        BottomCell * cell = [tableView dequeueReusableCellWithIdentifier:@"bottom"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BottomCell" owner:self options:nil]lastObject];
        }
        BankNameModel * model ;

        model = self.allBankArrar[indexPath.row];
        [cell.bankImageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];
        cell.bankLabel.text = model.name ;
        return cell ;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        [self.view endEditing:YES];
        if (self.strBlock) {
            BankNameModel * model = self.allBankArrar[indexPath.row];
            self.strBlock(model);
        }
        [self.navigationController popToViewController:self.infoVC animated:YES];
        
    }
}

#pragma mark --------TextFieldDelegate --------

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES ;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self refreshTableView:textField];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self refreshTableView:textField];
    return YES ;
}

#pragma mark --------private-----
-(void)textFieldChange:(NSNotification *)obj
{
    UITextField * textField = obj.object;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"])
    { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，刷新
        if (!position)
        {
            [self refreshTableView:textField];
        }
    }
}
-(void)refreshTableView:(UITextField *)textField
{
    [self.searchedBankArray removeAllObjects];
    NSString * conditionStr = [textField.text removeSubString:@" "];
    if (conditionStr.length != 0)
    {
        for (BankNameModel * model in self.totalArr)
        {
            if ([model.name containsString:conditionStr]) {
                [self.searchedBankArray addObject:model];
            }
        }
        self.allBankArrar = self.searchedBankArray;
        self.HaveResult = YES ;
        
    }else
    {
        self.allBankArrar = self.totalArr;
    }
    NSIndexSet * set = [[NSIndexSet alloc]initWithIndex:1];
    [self.bankListTableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}
#pragma mark ---------netRequest -----
//获取银行列表
-(void)getAllBankName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService getAllBankUrl];
        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
        [params setObject:App_User_Info.myInfo.userModel.userId forKey:@"userId"];
        [S_R LB_GetWithURLString:urlStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                FMLog(@"responseObject===%@",responseObject);
                self.totalArr = [BankNameModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"bankList"]];
                self.allBankArrar = self.totalArr;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.bankListTableView reloadData];
                });
            }
        } failure:^(NSError *error) {
            
        } WithController:self];
    });
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
