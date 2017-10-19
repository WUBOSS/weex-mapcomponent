//
//  WXMapLine.m
//  WeexDemo
//
//  Created by zhanshu1 on 2017/10/18.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "WXMapLine.h"

@implementation WXMapLine
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"points":[WXMapCoordinate class]};
}
@end
