//
//  WXCircle.h
//  WeexDemo
//
//  Created by zhanshu1 on 2017/10/19.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface WXCircle : NSObject
@property (assign ,nonatomic) double latitude;
@property (assign ,nonatomic) double longitude;
@property (assign ,nonatomic) double radius;
@property CGFloat lineWidth;
@property (copy ,nonatomic) NSString *fillColor;
@property (copy ,nonatomic) NSString *strokeColor;
@property (copy ,nonatomic) NSString *ID;
@property CGFloat alpha;

@end
