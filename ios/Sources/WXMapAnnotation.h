//
//  WXMapAnnotation.h
//  WeexDemo
//
//  Created by zhanshu1 on 2017/10/17.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
@interface WXMapAnnotation : NSObject<MAAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

///annotation标题
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *ID;
///annotation副标题
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *callOutImage;

@end
