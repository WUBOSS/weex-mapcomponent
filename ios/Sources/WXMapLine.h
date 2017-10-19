//
//  WXMapLine.h
//  WeexDemo
//
//  Created by zhanshu1 on 2017/10/18.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <MJExtension/MJExtension.h>
#import "WXMapCoordinate.h"
@interface WXMapLine : NSObject
///填充颜色,默认是kMAOverlayRendererDefaultFillColor
@property (copy ,nonatomic) NSString *fillColor;
@property (copy ,nonatomic) NSString *ID;
//坐标点
@property (strong ,nonatomic) NSMutableArray *points;

///笔触颜色,默认是kMAOverlayRendererDefaultStrokeColor
@property (copy ,nonatomic) NSString *strokeColor;

///笔触宽度,默认是0
@property CGFloat lineWidth;

///LineJoin,默认是kMALineJoinBevel
@property int lineJoinType;

///LineCap,默认是kMALineCapButt
@property int lineCapType;

///MiterLimit,默认是10.f
@property CGFloat miterLimit;

///是否绘制成虚线, 默认是NO
@property BOOL lineDash;

@end
