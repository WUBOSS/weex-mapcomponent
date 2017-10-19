//
//  WXMapPolyline.h
//  WeexDemo
//
//  Created by zhanshu1 on 2017/10/18.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "WXMapLine.h"
@interface WXMapPolyline : MAPolyline
@property(nonatomic,strong)WXMapLine *line;
+(instancetype)polylineWithLine:(WXMapLine *)line;
@end
