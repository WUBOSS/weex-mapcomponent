//
//  WXMapCircle.h
//  WeexDemo
//
//  Created by zhanshu1 on 2017/10/19.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "WXCircle.h"
@interface WXMapCircle : MACircle
@property(nonatomic,strong)WXCircle *circle;
+(instancetype)circleWithCircle:(WXCircle*)circle;
@end
