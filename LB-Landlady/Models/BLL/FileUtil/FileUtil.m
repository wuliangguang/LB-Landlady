//
//  FileUtility.m
//  InfoCollection
//
//  Created by dne on 13-12-27.
//  Copyright (c) 2013年 Visionet. All rights reserved.
//

#import "FileUtil.h"

@implementation FileUtil

//转换B KB MB GB
+ (NSString *)transformedValue:(double)value{
    
    double convertedValue = value;
    int multiplyFactor = 0;
    
    NSArray *tokens = [NSArray arrayWithObjects:@"B",@"KB",@"MB",@"GB",@"TB",nil];
    
    while (convertedValue > 1024) {
        convertedValue /= 1024;
        multiplyFactor++;
    }
    
    return [NSString stringWithFormat:@"%4.2f %@", convertedValue, [tokens objectAtIndex:multiplyFactor]];
}

//获取文件大小
+ (NSString *) getFileSize:(NSString *)filePath{
	NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
	
	NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:filePath error:&error];
	if(fileAttributes != nil){
		NSString *fileSize = [fileAttributes objectForKey:NSFileSize];
		
        return fileSize;
	}
    
    return nil;
}

//获取Document路径
+ (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [paths objectAtIndex:0];
}

//获取cache路径
+ (NSString *)cacheDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    return [paths objectAtIndex:0];
}

//获取tmp路径
+ (NSString *)tmpDirectory{
    return  NSTemporaryDirectory();
}

//文件是否存在
+ (BOOL)fileExistsAtPath:(NSString *)path{
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return NO;
    }
    
    return YES;
}

//删除文件
+ (BOOL)deleteFileAtPath:(NSString *)path{
    NSError *error;
	if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
		if (![[NSFileManager defaultManager] removeItemAtPath:path error:&error]) {
			//NSLog(@"Delete file error: %@", error);
            return NO;
		}
	}
    
    return YES;
}

//删除目录
+ (BOOL)deleteDirectoryAtPath:(NSString *)path{
	NSError *error;
	if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
		if (![[NSFileManager defaultManager] removeItemAtPath:path error:&error]) {
			//NSLog(@"Delete directory error: %@", error);
            return NO;
		}
	}
    
    return YES;
}

//创建目录
+ (BOOL)createDirectoryAtPath:(NSString *)path{
	if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
		if (![[NSFileManager defaultManager] createDirectoryAtPath:path
									   withIntermediateDirectories:NO
														attributes:nil
															 error:nil]){
			//NSLog(@"Create directory error!");
            return NO;
		}
	}
    
    return YES;
}

//保存文件
+ (BOOL)saveFileAtPath:(NSString *)path contents:(NSData *)data{
    if (![[NSFileManager defaultManager] createFileAtPath:path
                                                 contents:data
                                               attributes:nil ]) {
       // NSLog(@"Save file error!");
        return NO;
    }
    
    return YES;
}

//载入文件
+ (NSData *)loadFileAtPath:(NSString *)path{
    if ([FileUtil fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        return data;
    } else {
       // NSLog(@"File does not exist!");
    }
    
    return nil;
}

/**每个月有几天*/
+(int)howManyDaysInThisYear:(NSInteger)year month:(NSInteger)imonth {
    if((imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12))
        return 31;
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11))
        return 30;
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3))
    {
        return 28;
    }
    if(year%400 == 0)
        return 29;
    if(year%100 == 0)
        return 28;
    return 29;
}
@end
