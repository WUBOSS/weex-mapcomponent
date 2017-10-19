//
//  WXMapPolyline.m
//  WeexDemo
//
//  Created by zhanshu1 on 2017/10/18.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "WXMapPolyline.h"
#import "WXMapCoordinate.h"
@implementation WXMapPolyline
+(instancetype)polylineWithLine:(WXMapLine *)line
{
    NSInteger count=line.points.count;
    
    CLLocationCoordinate2D line2Points[count];
    
    for (int i=0; i<count; i++)
    {
        WXMapCoordinate *cor = line.points[i];
    
        line2Points[i].latitude = cor.latitude;
        line2Points[i].longitude = cor.longitude;
    
    
    }
    
    WXMapPolyline *line2 = [self polylineWithCoordinates:line2Points count:count];
    line2.line=line;
    
    return line2;
    
    
}
@end
