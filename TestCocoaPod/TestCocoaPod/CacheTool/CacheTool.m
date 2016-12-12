//
//  CacheTool.m
//  BuDeJie
//
//  Created by MJP on 16/11/29.
//  Copyright © 2016年 YSAN. All rights reserved.
//

#import "CacheTool.h"

@implementation CacheTool


/**
 返回处理好的缓存大小字符串
 */
+(NSString *)getCacheSize:(NSString*)cachePath{

    // 获取Cache文件夹的路径
    NSString *sizeStr = @"";
    unsigned long long size = [self getFileSize:cachePath];
    // 手机内存1MB = 1000KB
    if (size > 1000 * 1000) {//MB
        CGFloat sizeF = size / 1000.0 /1000.0;
        sizeStr = [NSString stringWithFormat:@"清除缓存(%.1fMB)",sizeF];
    }else if (size>1000){//KB
        CGFloat sizeF = size / 1000.0 ;
        sizeStr = [NSString stringWithFormat:@"清除缓存(%.1fKB)",sizeF];
        
    }else{//B
        sizeStr = [NSString stringWithFormat:@"清除缓存(%ldB)",(long)size];
        
    }
    return sizeStr;

}

#pragma mark - 计算文件的大小
+(unsigned long long)getFileSize:(NSString *)directoryPath{
    
    // 文件管理者
    NSFileManager *manger = [NSFileManager defaultManager];
    // 判断是否是文件夹
    BOOL isDirectory;
    BOOL isExist = [manger fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isDirectory || !isExist){
    
        NSException *cept = [NSException exceptionWithName:@"pathError" reason:@"需要传入的是文件夹，且路径要存在" userInfo:nil];
        // 抛出异常
        [cept raise];
    }

    // 遍历default里所有的文件
    NSArray *subPaths = [manger subpathsAtPath:directoryPath];
    unsigned long long totalSize = 0;
    for (NSString *subPath in subPaths) {
        //每个文件的全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        // 不计算隐藏文件
        if([filePath containsString:@".DS"])continue;
        
        // 判断是否是文件夹
        BOOL isDirectory;
        BOOL isExist = [manger fileExistsAtPath:filePath isDirectory:&isDirectory];
        if (isDirectory || !isExist) continue;
        
        // 获取文件属性
        NSDictionary *dict = [manger attributesOfItemAtPath:filePath error:nil];
        
        
        
        
        
        
        
        
        unsigned long long fileSize = [dict fileSize];
        totalSize +=fileSize;
    }
 
    return totalSize;
    
}
#pragma mark - 清除缓存
+(void)removeCache:(NSString *)cachePath{
    // 文件管理者
    NSFileManager *manger = [NSFileManager defaultManager];
    // 判断是否是文件夹
    BOOL isDirectory;
    BOOL isExist = [manger fileExistsAtPath:cachePath isDirectory:&isDirectory];
    if (!isDirectory || !isExist){
        // 创建异常
        NSException *cept = [NSException exceptionWithName:@"pathError" reason:@"需要传入的是文件夹，且路径要存在" userInfo:nil];
        // 抛出异常
        [cept raise];
    }

    // 获取cache文件下的所有文件
    NSArray *subPaths = [manger contentsOfDirectoryAtPath:cachePath error:nil];
    
    for (NSString *subPath in subPaths) {
        //拿到每个文件的子路径
        NSString *filePath = [cachePath stringByAppendingPathComponent:subPath];
        // 删除文件（清除缓存）
        [manger removeItemAtPath:filePath error:nil];
    }
    
}

@end
