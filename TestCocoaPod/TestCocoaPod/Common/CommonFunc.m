//
//  CommonFunc.m
//  我来也
//
//  Created by MJP on 15/11/2.
//  Copyright © 2015年 MJP. All rights reserved.
//
#define COMMON_COMPRSSION_FACTOR 0.8f
#define MAX_IMAGE_SIZE (2 * 1024 * 1024)

#import "CommonFunc.h"
#import <CommonCrypto/CommonDigest.h>
@implementation CommonFunc


//屏幕的宽高
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

//md5 32位 加密 （小写）
+ (NSString *)md5:(NSString *)str {
    
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    
}
/**
 *  参数排序并且加密
 */
+(NSString *)md5HexDigest_ParametersOrdering:(NSMutableDictionary *)params{
    
    NSMutableString *string = [[NSMutableString alloc] init];
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray *result = [[params allKeys] sortedArrayUsingComparator:sort];
    for (NSString *key in result) {
         NSString *value = [params objectForKey:key];
         NSString *str = [NSString stringWithFormat:@"%@=%@",key,value];
        [string appendString:str];
    }
//    [string appendString:MD5_Token];// 加盐
//    WLYLog(@"加密前拼接：%@",string);
    return  [self md5:string];
}


+(UILabel*) createLabel:(NSString*)text FontSize:(int)size TextColor:(UIColor*)textColor Rect:(CGRect)rect Align:(NSTextAlignment)align
{
    UILabel* label = [[UILabel alloc] initWithFrame:rect];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:size];
    label.textAlignment = align;
    label.text = text;
    return label;
}


+(UILabel*)createFontNameLabel:(NSString*)text FontName:(NSString *)name Size:(int)size TextColor:(UIColor*)textColor Rect:(CGRect)rect Align:(NSTextAlignment)align
{
    UILabel* label = [[UILabel alloc] initWithFrame:rect];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = textColor;
    //    label.font = [UIFont systemFontOfSize:size];
    label.font = [UIFont fontWithName:name size:size];
    label.textAlignment = align;
    label.text = text;
    return label;
}

+(UIImageView *)creatImgeViewRect:(CGRect)rect Img:(NSString *)image alpha:(CGFloat)alpha
{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:rect];
    imgView.image = [UIImage imageNamed:image];
    imgView.alpha = alpha;
    return imgView;
}


/**
 *  弹出提示框
 *  @param viewController 提示框所在的控制器
 *  @param title          提示框内容
 */
+(UIView *)createTipViewWithViewController:(UIViewController *)viewController Title:(NSString *)title
{
    UIView *tipView = [[UIView alloc]init];
    
    tipView.backgroundColor = [UIColor blackColor];
    tipView.alpha = 0.8l;
    [viewController.view addSubview:tipView];
    tipView.layer.masksToBounds = YES;
    tipView.layer.cornerRadius = 5;
    
    CGFloat x = (ScreenW-150)/2;
    CGFloat y = (ScreenH-80-64-49)/2;
    tipView.frame = CGRectMake(x,y , 150, 80);
    
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.text = title;
    tipLabel.frame = CGRectMake(0, 0, 150, 80);
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.font = [UIFont systemFontOfSize:15];
    [tipView addSubview:tipLabel];
        double delayInSeconds = 1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [tipView removeFromSuperview];
            
        });
    
    return tipView;
    
}

/**
 *  字符串转日期
 */
+(NSString *)transformationDateWithStr: (NSString *)str ToFormate:(NSString *)formate{
    NSInteger num = [str integerValue]/1000;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:formate];
//      [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:num];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

/**
 *  获取当前日期
 */
+(NSString *)getDateNowWithFormat:(NSString *)format{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"当前日期:%@",dateString);
    return dateString;
}


/**
 * 保存图片
 */
+ (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName{
   
    NSData* imageData;
    //判断图片是不是png格式的文件
    if (UIImagePNGRepresentation(tempImage)) {
        //返回为png图像。
        imageData = UIImagePNGRepresentation(tempImage);
    }else {
        //返回为JPEG图像。
        imageData = UIImageJPEGRepresentation(tempImage, 1.0);
    }
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];

    [imageData writeToFile:fullPathToFile atomically:NO];
    return fullPathToFile;
}

/**
 * 生成GUID
 */
+ (NSString *)generateUuidString{
    
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    
    CFRelease(uuid);
    
    return uuidString;
}

+(NSData *)compressImageWithOriginalSize:(UIImage *)originalImage {
    CGFloat compression = COMMON_COMPRSSION_FACTOR;
    CGFloat maxCompression = 0.1f;
    long maxFileSize = MAX_IMAGE_SIZE;
    
    NSData *imageData = UIImageJPEGRepresentation(originalImage, compression);
    
    while ([imageData length] > maxFileSize && compression > maxCompression)
    {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(originalImage, compression);
    }
    return imageData;
}


/**
 * 返回富文本
 */
+ (NSAttributedString *)setAttibuteWithRange:(NSRange )rang Text:(NSString *)text{
    //富文本对象
    NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    //富文本样式
    [aAttributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
                              value:[UIColor redColor]
                              range:rang];
    return aAttributedString;
}



@end
