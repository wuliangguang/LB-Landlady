//
//  MyMessage.h
//  LB-Landlady
//
//  Created by 刘威振 on 2/24/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    MyMessageTypeSystem = 0, // 系统消息
    MyMessageTypeOrder  = 1, // 订单消息
    MyMessageTypeCustom = 2, // 订制消息
} MyMessageType;

@interface MyMessageModel : NSObject

@property (nonatomic, copy) NSString  *message_title;     // 消息标题
@property (nonatomic, copy) NSString  *messageCreateTime; // 消息创建时间
@property (nonatomic, copy) NSString  *business_id;
@property (nonatomic      ) BOOL      is_read;            // 是否已读
@property (nonatomic      ) MyMessageType message_type;
@property (nonatomic      ) BOOL      is_flag;
@property (nonatomic, copy) NSString  *message_content;   // 消息内容（消息详情）
@property (nonatomic, copy) NSString  *message_id;        // 消息id

/** 选中/未选中 和服务器返回数据无关 */
@property (nonatomic, getter=isCheck) BOOL check;

/** 编辑/非编辑 和服务器返回数据无关 */
@property (nonatomic, getter=isEditing) BOOL editing;

/** 和服务器返回数据无关 */
@property (nonatomic, readonly) NSString *messageTypeStr;

@end
