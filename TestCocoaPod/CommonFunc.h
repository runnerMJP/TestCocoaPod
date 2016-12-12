//
//  CommonFunc.h
//  我来也
//
//  Created by MJP on 15/11/2.
//  Copyright © 2015年 MJP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonFunc : NSObject

//+(UILabel*) createLabel:(NSString*)text FontSize:(int)size TextColor:(UIColor*)textColor Rect:(CGRect)rect Align:(NSTextAlignment)align;
//+(UILabel*)createFontNameLabel:(NSString*)text FontName:(NSString *)name Size:(int)size TextColor:(UIColor*)textColor Rect:(CGRect)rect Align:(NSTextAlignment)align;
//+(UIImageView *)creatImgeViewRect:(CGRect)rect  Img:(NSString *)image alpha:(CGFloat)alpha;


/**
 *  提示框
 */
+(UIView *)createTipViewWithViewController:(UIViewController *)viewController Title:(NSString *)title;


/**
 *  将字符串转化为日期
 */
+ (NSString *)transformationDateWithStr: (NSString *)str ToFormate:(NSString *)formate;

/**
 *  获取当前日期
 */
+(NSString *)getDateNowWithFormat:(NSString *)format;

/**
 *  保存图片
 */
+ (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;

/**
 * 生成GUID
 */
+ (NSString *)generateUuidString;

+ (NSData *)compressImageWithOriginalSize:(UIImage *)originalImage;

/**
 *  MD5加密
 */
+ (NSString *)md5:(NSString *)str;

/**
 *  1.将字典中的所有元素取出并按键的大小排序
 *  2. 调用加密方法加密
 */
+(NSString *)md5HexDigest_ParametersOrdering:(NSMutableDictionary *)params;


/**
 * 返回富文本
 */
+ (NSAttributedString *)setAttibuteWithRange:(NSRange )rang Text:(NSString *)text;


@end
