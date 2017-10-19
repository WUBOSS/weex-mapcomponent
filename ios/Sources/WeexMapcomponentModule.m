//
//  WeexMapcomponentModule.m
//  WeexPluginTemp
//
//  Created by  on 17/3/14.
//  Copyright © 2017年 . All rights reserved.
//

#import "WeexMapcomponentModule.h"
#import <WeexPluginLoader/WeexPluginLoader.h>

@implementation WeexMapcomponentModule

WX_PlUGIN_EXPORT_MODULE(weexMapcomponent, WeexMapcomponentModule)
WX_EXPORT_METHOD(@selector(show))

/**
 create actionsheet
 
 @param options items
 @param callback
 */
-(void)show
{
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"title" message:@"module weexMapcomponent is created sucessfully" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
    [alertview show];
    
}

@end
