//
//  FileUtility.h
//  InfoCollection
//
//  Created by dne on 13-12-27.
//  Copyright (c) 2013年 Visionet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtil : NSObject

//转换B KB MB GB
+ (NSString *)transformedValue:(double)value;
//获取文件大小
+ (NSString *) getFileSize:(NSString *)filePath;

//获取Document路径
+ (NSString *) documentsDirectory;
//获取cache路径
+ (NSString *)cacheDirectory;
//获取tmp路径
+ (NSString *)tmpDirectory;

//文件是否存在
+ (BOOL)fileExistsAtPath:(NSString *)path;
//删除文件
+ (BOOL)deleteFileAtPath:(NSString *)path;
//删除目录
+ (BOOL)deleteDirectoryAtPath:(NSString *)path;
//创建目录
+ (BOOL)createDirectoryAtPath:(NSString *)path;
//保存文件
+ (BOOL)saveFileAtPath:(NSString *)path contents:(NSData *)data;
//载入文件
+ (NSData *)loadFileAtPath:(NSString *)path;




/**每个月有几天*/
+(int)howManyDaysInThisYear:(NSInteger)year month:(NSInteger)imonth;
@end
