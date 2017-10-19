//
//  UIColor+NotRGB.h
//  WeexDemo
//
//  Created by zhanshu1 on 2017/10/16.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (NotRGB)


/**
 *  16进制转uicolor
 *
 *  @param color @"#FFFFFF" ,@"OXFFFFFF" ,@"FFFFFF"
 *
 *  @return uicolor
 */
+ (UIColor *)colorWithHexString:(NSString *)color;  
@end
