//
//  WXMapCircle.m
//  WeexDemo
//
//  Created by zhanshu1 on 2017/10/19.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "WXMapCircle.h"

@implementation WXMapCircle
+(instancetype)circleWithCircle:(WXCircle *)circle
{
    WXMapCircle *overlay=[self circleWithCenterCoordinate:CLLocationCoordinate2DMake(circle.latitude, circle.longitude) radius:circle.radius];
    overlay.circle=circle;
    return overlay;
}
@end
