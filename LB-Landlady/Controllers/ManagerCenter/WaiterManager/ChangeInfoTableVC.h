//
//  CallWaiterTableVC.h
//  MeZoneB_Bate
//
//  Created by ios on 15/11/13.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaiterListModel.h"

@interface ChangeInfoTableVC : UITableViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)WaiterListModel * model;
@property (strong, nonatomic) IBOutlet UIImageView *headerIMGView;
@property (strong, nonatomic) IBOutlet UITextField *numTF;
@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UITextField *positionTF;

@property (strong, nonatomic) IBOutlet UILabel *photoLab;
@property (strong, nonatomic) IBOutlet UITableViewCell *section1Cell;
@property (strong, nonatomic) IBOutlet UILabel *waiterNumLab;

@property (strong,nonatomic )UIImagePickerController *imagePicker;

@property (nonatomic, copy) void (^callbackHandler)(WaiterListModel *model);
@end
