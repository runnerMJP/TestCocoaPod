//
//  CacheTool.h
//  BuDeJie
//
//  Created by MJP on 16/11/29.
//  Copyright © 2016年 YSAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CacheTool : NSObject


/**
 计算一个文件夹的大小
 */
//+(NSString *)getCacheSize:(NSString*)cachePath;


/**
 删除文件夹里的所有文件
 */
+(void)removeCache:(NSString *)cachePath;

@end
