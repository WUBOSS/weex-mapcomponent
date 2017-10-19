//
//  weexMapComponent.m
//  WeexDemo
//
//  Created by zhanshu1 on 2017/10/12.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "weexMapComponent.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#define mapkey @"mapkey"
#import "UIColor+NotRGB.h"
#import <SDWebImage/SDImageCache.h>
#import "WXMapAnnotation.h"
#import "WXMapLine.h"
#import "WXMapCircle.h"
#import "WXMapPolyline.h"
#import <MJExtension/MJExtension.h>
#import <WeexPluginLoader/WeexPluginLoader.h>
@interface weexMapComponent()<MAMapViewDelegate>
@property(nonatomic,strong)MAMapView *mapview;
@end
@implementation weexMapComponent
WX_PlUGIN_EXPORT_COMPONENT   (WXMapComponent, weexMapComponent)
WX_EXPORT_METHOD(@selector(isAbroad:))
WX_EXPORT_METHOD(@selector(metersPerPointForCurrentZoom:))
WX_EXPORT_METHOD(@selector(logoSize:))
WX_EXPORT_METHOD(@selector(scaleSize:))
WX_EXPORT_METHOD(@selector(compassSize:))
WX_EXPORT_METHOD(@selector(setRegion: animated:))
WX_EXPORT_METHOD(@selector(setVisibleMapRect: animated:))
- (void)setRegion:(id)region animated:(BOOL)animated{
    MACoordinateRegion aregion;
    if([region isKindOfClass:[NSDictionary class]])
    {
        CLLocationDegrees latitude=[[region objectForKey:@"latitude"] doubleValue];
        CLLocationDegrees longitude=[[region objectForKey:@"longitude"] doubleValue];
        CLLocationDegrees latitudeDelta=[[region objectForKey:@"latitudeDelta"] doubleValue];
        CLLocationDegrees longitudeDelta=[[region objectForKey:@"longitudeDelta"] doubleValue];
        aregion=MACoordinateRegionMake(CLLocationCoordinate2DMake(latitude, longitude), MACoordinateSpanMake(latitudeDelta, longitudeDelta));
        
        
    }
    else
    {
        aregion = MACoordinateRegionMake(CLLocationCoordinate2DMake(0, 0), MACoordinateSpanMake(0, 0));;
    }
    
    [self.mapview setRegion:aregion animated:animated];
    
    
}

- (void)setVisibleMapRect:(id)mapRect animated:(BOOL)animated
{
    MAMapRect aregion;
    if([mapRect isKindOfClass:[NSDictionary class]])
    {
        CLLocationDegrees x=[[mapRect objectForKey:@"x"] doubleValue];
        CLLocationDegrees y=[[mapRect objectForKey:@"y"] doubleValue];
        CLLocationDegrees width=[[mapRect objectForKey:@"width"] doubleValue];
        CLLocationDegrees height=[[mapRect objectForKey:@"height"] doubleValue];
        aregion=MAMapRectMake(x, y, width, height);
        
        
    }
    else
    {
        aregion = MAMapRectMake(0, 0, 0, 0);
    }
    
    [self.mapview setVisibleMapRect:aregion animated:animated];
}


///**
// * @brief 设置可见地图矩形区域
// * @param insets 边缘插入
// * @param mapRect 要显示的地图矩形区域
// * @param animated 是否动画效果
// */
WX_EXPORT_METHOD(@selector(setVisibleMapRect: edgePadding: animated:))
- (void)setVisibleMapRect:(id)mapRect edgePadding:(id)insets animated:(BOOL)animated{
    
    MAMapRect aregion;
    UIEdgeInsets ainsets;
    if([mapRect isKindOfClass:[NSDictionary class]])
    {
        CLLocationDegrees x=[[mapRect objectForKey:@"x"] doubleValue];
        CLLocationDegrees y=[[mapRect objectForKey:@"y"] doubleValue];
        CLLocationDegrees width=[[mapRect objectForKey:@"width"] doubleValue];
        CLLocationDegrees height=[[mapRect objectForKey:@"height"] doubleValue];
        aregion=MAMapRectMake(x, y, width, height);
        
        
    }
    else
    {
        aregion = MAMapRectMake(0, 0, 0, 0);
    }
    
    if([insets isKindOfClass:[NSDictionary class]])
    {
        CGFloat top=[[mapRect objectForKey:@"top"] floatValue];
        CGFloat left=[[mapRect objectForKey:@"left"] floatValue];
        CGFloat bottom=[[mapRect objectForKey:@"bottom"] floatValue];
        CGFloat right=[[mapRect objectForKey:@"right"] floatValue];
        ainsets= UIEdgeInsetsMake(top, left, bottom, right);
        
        
    }
    else
    {
        ainsets= UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    [self.mapview setVisibleMapRect:aregion edgePadding:ainsets animated:animated];
}
//
///**
// * @brief 设置当前地图的中心点，改变该值时，地图的比例尺级别不会发生变化
// * @param coordinate 要设置的中心点
// * @param animated 是否动画设置
// */

WX_EXPORT_METHOD(@selector(setCenterCoordinate: animated:))
- (void)setCenterCoordinate:(id)coordinate animated:(BOOL)animated
{
    CLLocationCoordinate2D acoordinate;
    if([coordinate isKindOfClass:[NSDictionary class]])
    {
        double latitude=[[coordinate objectForKey:@"latitude"] doubleValue];
        double longitude=[[coordinate objectForKey:@"longitude"] doubleValue];
        
        acoordinate=CLLocationCoordinate2DMake(latitude, longitude);
        
        
    }
    else
    {
        acoordinate = CLLocationCoordinate2DMake(0, 0);
    }
    
    [self.mapview setCenterCoordinate:acoordinate animated:animated];
}
//
///**
// * @brief 设置缩放级别（默认3-19，有室内地图时为3-20）
// * @param zoomLevel 要设置的缩放级别
// * @param animated 是否动画设置
// */
WX_EXPORT_METHOD(@selector(setZoomLevel: animated:))
- (void)setZoomLevel:(NSString *)zoomLevel animated:(BOOL)animated
{
   
    
    [self.mapview setZoomLevel:zoomLevel.floatValue animated:animated];
}
//
///**
// * @brief 根据指定的枢纽点来缩放地图
// * @param zoomLevel 缩放级别
// * @param pivot 枢纽点(基于地图view的坐标系)
// * @param animated 是否动画
// */
WX_EXPORT_METHOD(@selector(setZoomLevel: atPivot: animated:))
- (void)setZoomLevel:(NSString *)zoomLevel atPivot:(id)pivot animated:(BOOL)animated
{
    CGPoint acoordinate;
    if([pivot isKindOfClass:[NSDictionary class]])
    {
        double x=[[pivot objectForKey:@"x"] doubleValue];
        double y=[[pivot objectForKey:@"y"] doubleValue];
        
        acoordinate=CGPointMake(x, y);
        
        
    }
    else
    {
        acoordinate = CGPointMake(0, 0);
    }
    
    [self.mapview setZoomLevel:zoomLevel.floatValue atPivot:acoordinate animated:animated];
}

///**
// * @brief 设置地图旋转角度(逆时针为正向)
// * @param rotationDegree 旋转角度
// * @param animated 动画
// * @param duration 动画时间
// */
WX_EXPORT_METHOD(@selector(setRotationDegree: animated: duration:))
- (void)setRotationDegree:(NSString*)rotationDegree animated:(BOOL)animated duration:(NSString*)duration
{
    [self.mapview setRotationDegree:rotationDegree.floatValue animated:animated duration:duration.doubleValue];
}

///**
// * @brief 设置地图相机角度(范围为[0.f, 60.f]，但高于40度的角度需要在16级以上才能生效)
// * @param cameraDegree 要设置的相机角度
// * @param animated 是否动画
// * @param duration 动画时间
// */
WX_EXPORT_METHOD(@selector(setCameraDegree: animated: duration:))
- (void)setCameraDegree:(NSString *)cameraDegree animated:(BOOL)animated duration:(NSString *)duration
{
    [self.mapview setCameraDegree:cameraDegree.floatValue animated:animated duration:duration.doubleValue];
}
//
///**
// * @brief 获取地图状态
// * @return 地图状态
// */
WX_EXPORT_METHOD(@selector(getMapStatus:))
- (void )getMapStatus:(WXModuleCallback)callBack {
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
     MAMapStatus *status =[self.mapview getMapStatus];
    
    dic[@"latitude"]=@(status.centerCoordinate.latitude);
    dic[@"longitude"]=@(status.centerCoordinate.longitude);
    dic[@"zoomLevel"]=@(status.zoomLevel);
    dic[@"rotationDegree"]=@(status.rotationDegree);
    dic[@"cameraDegree"]=@(status.cameraDegree);
    dic[@"screenAnchorx"]=@(status.screenAnchor.x);
    dic[@"screenAnchory"]=@(status.screenAnchor.y);
    callBack(dic);
}
//
//
///**
// * @brief 设置地图状态
// * @param status 要设置的地图状态
// * @param animated 是否动画
// */
WX_EXPORT_METHOD(@selector(setMapStatus: animated:))
- (void)setMapStatus:(id )status animated:(BOOL)animated
{
    [self setMapStatus:status animated:animated duration:@"0.25"];
    
    
}
//
///**
// * @brief 设置地图状态
// * @param status 要设置的地图状态
// * @param animated 是否动画
// * @param duration 动画时间，默认动画时间为0.35s
// */
WX_EXPORT_METHOD(@selector(setMapStatus: animated: duration:))
- (void)setMapStatus:(id )status
            animated:(BOOL)animated
            duration:(NSString *)duration{
    MAMapStatus * mapstatus=nil;
    if([status isKindOfClass:[NSDictionary class]])
    {
        
        double latitude=[[status objectForKey:@"latitude"] doubleValue];
        double longitude=[[status objectForKey:@"longitude"] doubleValue];
        CGFloat zoomLevel=[[status objectForKey:@"zoomLevel"] floatValue];
        CGFloat rotationDegree=[[status objectForKey:@"rotationDegree"] floatValue];
        CGFloat cameraDegree=[[status objectForKey:@"cameraDegree"] floatValue];
        CGFloat screenAnchorx=[[status objectForKey:@"screenAnchorx"] floatValue];
        CGFloat screenAnchory=[[status objectForKey:@"screenAnchory"] floatValue];
        
        mapstatus=[MAMapStatus statusWithCenterCoordinate:CLLocationCoordinate2DMake(latitude, longitude) zoomLevel:zoomLevel rotationDegree:rotationDegree cameraDegree:cameraDegree screenAnchor:CGPointMake(screenAnchorx, screenAnchory)];
        
        
        
    }
    else
    {
        
    }
    
    [self.mapview setMapStatus:mapstatus animated:animated duration:duration.doubleValue];
    
    
}
//
///**
// * @brief 设置指南针的图片
// * @param image 新的指南针图片
// */
WX_EXPORT_METHOD(@selector(setCompassImage:))
- (void)setCompassImage:(NSString *)image
{
    [self.mapview setCompassImage:[UIImage imageNamed:image]];
}
//
///**
// * @brief 在指定区域内截图(默认会包含该区域内的annotationView)
// * @param rect 指定的区域
// * @return 截图image
// */
WX_EXPORT_METHOD(@selector(takeSnapshotInRect: callBack:))

- (void )takeSnapshotInRect:(id)rect callBack:(WXModuleCallback) callBack
{
    
    
    if([rect isKindOfClass:[NSDictionary class]])
    {
        
       
        CGFloat x=[[rect objectForKey:@"x"] floatValue];
        CGFloat y=[[rect objectForKey:@"y"] floatValue];
        CGFloat width=[[rect objectForKey:@"width"] floatValue];
        CGFloat height=[[rect objectForKey:@"height"] floatValue];
        
        
        [self.mapview takeSnapshotInRect:CGRectMake(x, y, width, height) withCompletionBlock:^(UIImage *resultImage, NSInteger state) {
            
            CFUUIDRef uuidRef =CFUUIDCreate(NULL);
            
            CFStringRef uuidStringRef =CFUUIDCreateString(NULL, uuidRef);
            
            CFRelease(uuidRef);
            
            NSString *uniqueId = (__bridge NSString *)(uuidStringRef);
            [[SDImageCache sharedImageCache] storeImage:resultImage forKey:[NSString stringWithFormat:@"%@:%@",@"store",uniqueId]];
            
            callBack(@{@"url":[NSString stringWithFormat:@"%@:%@",@"store",uniqueId],@"status":@(state)
                        });
        }];
        
        
        
        
    }
    else
    {
        
    }
    
   
    
    
}

///**
// * @brief 在指定的缩放级别下, 基于地图中心点, 1 screen point 对应的距离(单位是米).
// * @param zoomLevel 指定的缩放级别, 在[minZoomLevel, maxZoomLevel]范围内.
// * @return 对应的距离(单位是米)
// */
WX_EXPORT_METHOD(@selector(metersPerPointForZoomLevel: callBack:))
- (void)metersPerPointForZoomLevel:(NSString *)zoomLevel callBack:(WXModuleCallback)callBack{
    
    callBack(@([self.mapview metersPerPointForZoomLevel:[zoomLevel floatValue]]));
}

//
///**
// * @brief 将经纬度转换为指定view坐标系的坐标
// * @param coordinate 经纬度
// * @param view 指定的view
// * @return 基于指定view坐标系的坐标
// */


WX_EXPORT_METHOD(@selector(convertCoordinate: toPointToView: callBack:))
- (void)convertCoordinate:(id)coordinate toPointToView:(NSString *)ref callBack:(WXModuleCallback)callBack{
    
    if([coordinate isKindOfClass:[NSDictionary class]])
    {
        WXComponent *compent=[[WXSDKManager   bridgeMgr].topInstance componentForRef:ref];
        double latitude=[[coordinate objectForKey:@"latitude"] doubleValue];
        double longitude=[[coordinate objectForKey:@"longitude"] doubleValue];
        UIView *view=compent.view;
        if(compent==nil)
        {
            callBack(@"ref error");
            return;
        }
       CGPoint point= [self.mapview convertCoordinate:CLLocationCoordinate2DMake(latitude, longitude) toPointToView:view];
        
        callBack(@{@"x":@(point.x),@"y":@(point.y)});
        
    }
    else
    {
        callBack(@"coordinate error");
    }
    
   
    
    
    
    
}
//
///**
// * @brief 将指定view坐标系的坐标转换为经纬度
// * @param point 指定view坐标系的坐标
// * @param view 指定的view
// * @return 经纬度
// */

WX_EXPORT_METHOD(@selector(convertPoint: toCoordinateFromView: callBack:))
- (void)convertPoint:(id)point toCoordinateFromView:(NSString *)ref callBack:(WXModuleCallback) callBack
{
    if([point isKindOfClass:[NSDictionary class]])
    {
        WXComponent *compent=[[WXSDKManager   bridgeMgr].topInstance componentForRef:ref];
        double x=[[point objectForKey:@"x"] doubleValue];
        double y=[[point objectForKey:@"y"] doubleValue];
        UIView *view=compent.view;
        if(compent==nil)
        {
            callBack(@"ref error");
            return;
        }
        CLLocationCoordinate2D Coordinate= [self.mapview convertPoint:CGPointMake(x, y) toCoordinateFromView:view];
        
        callBack(@{@"latitude":@(Coordinate.latitude),@"longitude":@(Coordinate.longitude)});
        
    }
    else
    {
        callBack(@"coordinate error");
    }
}
//
///**
// * @brief 将经纬度region转换为指定view坐标系的rect
// * @param region 经纬度region
// * @param view 指定的view
// * @return 指定view坐标系的rect
// */
//- (CGRect)convertRegion:(MACoordinateRegion)region toRectToView:(UIView *)view;
//
///**
// * @brief 将指定view坐标系的rect转换为经纬度region
// * @param rect 指定view坐标系的rect
// * @param view 指定的view
// * @return 经纬度region
// */
//- (MACoordinateRegion)convertRect:(CGRect)rect toRegionFromView:(UIView *)view;
//
///**
// * @brief 重新加载地图
// *
// * 将离线地图解压到 Documents/3dvmap/ 目录下后，调用此函数使离线数据生效,
// * 对应的回调分别是 offlineDataWillReload:(MAMapView *)mapView, offlineDataDidReload:(MAMapView *)mapView.
// */
WX_EXPORT_METHOD(@selector(reloadMap))
- (void)reloadMap{
    [self.mapview reloadMap];
}
//
///**
// * @brief 清除所有磁盘上缓存的地图数据(不包括离线地图)
// */
WX_EXPORT_METHOD(@selector(clearDisk))
- (void)clearDisk{
    [self.mapview clearDisk];
}
//
///**
// * @brief 重新加载内部纹理，在纹理被错误释放时可以执行此方法。（since 5.4.0）
// */
WX_EXPORT_METHOD(@selector(reloadInternalTexture))
- (void)reloadInternalTexture
{
    [self.mapview reloadInternalTexture];
}
//
///**
// * @brief 获取地图审图号。如果启用了“自定义样式”功能(customMapStyleEnabled 为 YES)，则返回nil。（since 5.4.0）
// * @return 地图审图号
// */
WX_EXPORT_METHOD(@selector(mapContentApprovalNumber:))
- (void )mapContentApprovalNumber:(WXModuleCallback)callBack
{
    callBack([self.mapview mapContentApprovalNumber]);
    
    
}
//
///**
// * @brief 获取卫星图片审图号。（since 5.4.0）
// * @return 卫星图片审图号
// */
WX_EXPORT_METHOD(@selector(satelliteImageApprovalNumber:))
- (void )satelliteImageApprovalNumber:(WXModuleCallback)callBack
{
    callBack([self.mapview satelliteImageApprovalNumber]);
    
    
}
//加大头针s
WX_EXPORT_METHOD(@selector(addAnnotations:))
- (void )addAnnotations:(NSArray *)annotation
{
    if([annotation isEqualToArray:[NSArray array]])
    {
        for (id temp in annotation) {
            [self addAnnotation:temp];
        }
    }
    
}
//加大头针
WX_EXPORT_METHOD(@selector(addAnnotation:))
- (void )addAnnotation:(id)annotation
{
    if([annotation isKindOfClass:[NSDictionary class]])
    {
        
        WXMapAnnotation *anno=[[WXMapAnnotation alloc]init];
        double latitude=[[annotation objectForKey:@"latitude"] doubleValue];
        double longitude=[[annotation objectForKey:@"longitude"] doubleValue];
        NSString * subtitle=[annotation objectForKey:@"subtitle"] ;
        NSString * title=[annotation objectForKey:@"title"] ;
        NSString * ID=[NSString stringWithFormat:@"%@",[annotation objectForKey:@"ID"] ];
        NSString * image=[annotation objectForKey:@"image"] ;
         NSString * callOutImage=[annotation objectForKey:@"callOutImage"] ;
        
        anno.coordinate=CLLocationCoordinate2DMake(latitude, longitude);
        anno.subtitle=subtitle;
        anno.title=title;
        anno.callOutImage=callOutImage;
        
        anno.ID=ID;
        anno.image=image;
        [self.mapview addAnnotation:anno];
    }
    
}
WX_EXPORT_METHOD(@selector(removeAnnotations:))
- (void )removeAnnotations:(NSArray*)annotation
{
    if([annotation isEqualToArray:[NSArray array]])
    {
        for (id temp in annotation) {
            [self removeAnnotation:temp];
        }
    }
}
WX_EXPORT_METHOD(@selector(selectedAnnotations:))
-(void)selectedAnnotations:(WXModuleCallback)callBack
{
    NSArray *arr=[self.mapview selectedAnnotations];
    NSMutableArray *result=[NSMutableArray array];
    for (id<MAAnnotation> temp in arr) {
        if([temp isKindOfClass:[WXMapAnnotation class]])
        {
            WXMapAnnotation *wxanno=(WXMapAnnotation *)temp;
           
            if(wxanno.ID.length)
            [result addObject:wxanno.ID];
            
        }
    }
    callBack(result);
    
}

WX_EXPORT_METHOD(@selector(removeAnnotation:))
- (void )removeAnnotation:(NSString *)annotation
{
   NSString *ID= [NSString stringWithFormat:@"%@",annotation ];
    for (id<MAAnnotation> temp in self.mapview.annotations) {
        if([temp isKindOfClass:[WXMapAnnotation class]])
        {
            WXMapAnnotation *wxanno=(WXMapAnnotation *)temp;
            if([wxanno.ID isEqualToString:ID])
            {
                [self.mapview removeAnnotation:temp];
            }
        }
    }
    
}
/**
 * @brief 选中标注数据对应的view
 * @param annotation 标注数据
 * @param animated 是否有动画效果
 */
WX_EXPORT_METHOD(@selector(selectAnnotation:animated:))
- (void)selectAnnotation:(NSString*)annotation animated:(BOOL)animated{
    NSString *ID= [NSString stringWithFormat:@"%@",annotation ];
    for (id<MAAnnotation> temp in self.mapview.annotations) {
        if([temp isKindOfClass:[WXMapAnnotation class]])
        {
            WXMapAnnotation *wxanno=(WXMapAnnotation *)temp;
            if([wxanno.ID isEqualToString:ID])
            {
                [self.mapview selectAnnotation:temp animated:animated];
            }
        }
    }
}

/**
 * @brief 取消选中标注数据对应的view
 * @param annotation 标注数据
 * @param animated 是否有动画效果
 */
WX_EXPORT_METHOD(@selector(deselectAnnotation:animated:))
- (void)deselectAnnotation:(NSString*)annotation animated:(BOOL)animated{
    
    NSString *ID= [NSString stringWithFormat:@"%@",annotation ];
    for (id<MAAnnotation> temp in self.mapview.annotations) {
        if([temp isKindOfClass:[WXMapAnnotation class]])
        {
            WXMapAnnotation *wxanno=(WXMapAnnotation *)temp;
            if([wxanno.ID isEqualToString:ID])
            {
                [self.mapview deselectAnnotation:temp animated:animated];
            }
        }
    }
}

WX_EXPORT_METHOD(@selector(userLocation:))
- (void)userLocation:(WXModuleCallback)callBack{
    
    callBack(@{@"latitude":@(self.mapview.userLocation.coordinate.latitude),@"longitude":@(self.mapview.userLocation.coordinate.longitude)});
    
}
WX_EXPORT_METHOD(@selector(setUserTrackingMode:animated:))
- (void)setUserTrackingMode:(NSString *)UserTrackingMode animated:(BOOL)animated{
    
    [self.mapview setUserTrackingMode:[UserTrackingMode intValue] animated:animated];
    
}
WX_EXPORT_METHOD(@selector(addLineOverlay:callBack:))
- (void)addLineOverlay:(NSDictionary*)overlay callBack:(WXModuleCallback)callBack{
    
    if([overlay isKindOfClass:[NSDictionary class]])
    {
     
        WXMapLine *line=[WXMapLine mj_objectWithKeyValues:overlay];
        if(line.points.count)
        {
            [self.mapview addOverlay: [WXMapPolyline polylineWithLine:line]];
        }
        
        else
            
        {
            
            callBack(@"未传经纬度");
        }
        
    }
    
    
    
}

WX_EXPORT_METHOD(@selector(removeLineOverlay:))
- (void)removeLineOverlay:(NSString*)ID{
    
    
    NSArray *arr=self.mapview.overlays;
    
    for (id<MAOverlay> temp in arr) {
        if([temp isKindOfClass:[WXMapPolyline class]])
        {
            if([((WXMapPolyline*)temp).line.ID isEqualToString:[NSString stringWithFormat:@"%@",ID]])
                
            {
                [self.mapview removeOverlay:temp];
            }
        }
    }
    
    
    
}
WX_EXPORT_METHOD(@selector(addCircleOverlay:))
- (void)addCircleOverlay:(NSDictionary*)overlay {
    
    if([overlay isKindOfClass:[NSDictionary class]])
    {
        
        WXCircle *circle=[WXCircle mj_objectWithKeyValues:overlay];
        [self.mapview addOverlay: [WXMapCircle circleWithCircle:circle]];
        
        
        
        
    }
    
    
    
}

WX_EXPORT_METHOD(@selector(removeCircleOverlay:))
- (void)removeCircleOverlay:(NSString*)ID{
    
    
    NSArray *arr=self.mapview.overlays;
    
    for (id<MAOverlay> temp in arr) {
        if([temp isKindOfClass:[WXMapCircle class]])
        {
            if([((WXMapCircle*)temp).circle.ID isEqualToString:[NSString stringWithFormat:@"%@",ID]])
                
            {
                [self.mapview removeOverlay:temp];
            }
        }
    }
    
    
    
}


#pragma mark method export
-(void)isAbroad:(WXModuleCallback)callBack
{
    
    callBack(@(self.mapview.isAbroad));
}
-(void)metersPerPointForCurrentZoom:(WXModuleCallback)callBack
{
    callBack(@(self.mapview.metersPerPointForCurrentZoom));
}
-(void)logoSize:(WXModuleCallback)callBack
{
    
    callBack(@{@"width":@(self.mapview.logoSize.width),@"height":@(self.mapview.logoSize.height)});
}
-(void)compassSize:(WXModuleCallback)callBack
{
    
    
     callBack(@{@"width":@(self.mapview.compassSize.width),@"height":@(self.mapview.compassSize.height)});
    
}
-(void)scaleSize:(WXModuleCallback)callBack
{
    
    callBack(@{@"width":@(self.mapview.scaleSize.width),@"height":@(self.mapview.scaleSize.height)});
}
-(instancetype)initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance
{
    if (self = [super initWithRef:ref type:type styles:styles attributes:attributes events:events weexInstance:weexInstance]) {
        
       
        [self parseAttributes:attributes];
        
    }
    return self;
}
-(void)parseAttributes:(NSDictionary *)attributes
{
    NSArray *alleys=attributes.allKeys;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // UI更新代码
        if([alleys containsObject:mapkey])
        {
            [AMapServices sharedServices].apiKey=[attributes objectForKey:mapkey];
            
        }
        if ([alleys containsObject:@"mapType"])
        {
            self.mapview.mapType=[[attributes objectForKey:@"mapType"] intValue];
        }
        if ([alleys containsObject:@"centerCoordinate"]&&[[attributes objectForKey:@"centerCoordinate"] isKindOfClass:[NSDictionary class]])
        {
            self.mapview.centerCoordinate=CLLocationCoordinate2DMake([[[attributes objectForKey:@"centerCoordinate"] objectForKey:@"latitude"] doubleValue], [[[attributes objectForKey:@"centerCoordinate"] objectForKey:@"longitude"] doubleValue])  ;
        }
        if ([alleys containsObject:@"zoomLevel"])
        {
            self.mapview.zoomLevel=[[attributes objectForKey:@"zoomLevel"] intValue];
            
        }
        if ([alleys containsObject:@"runLoopMode"])
        {
            self.mapview.runLoopMode=[attributes objectForKey:@"runLoopMode"] ;
            
        }
        if ([alleys containsObject:@"screenAnchor"]&&[[attributes objectForKey:@"screenAnchor"] isKindOfClass:[NSDictionary class]])
        {
            self.mapview.screenAnchor=CGPointMake([[[attributes objectForKey:@"screenAnchor"] objectForKey:@"x"] doubleValue], [[[attributes objectForKey:@"screenAnchor"] objectForKey:@"y"] doubleValue]) ;
            
            
        }
        if ([alleys containsObject:@"openGLESDisabled"])
        {
            self.mapview.openGLESDisabled=[[attributes objectForKey:@"openGLESDisabled"] boolValue
                                           ] ;
            
        }
        if ([alleys containsObject:@"isAllowDecreaseFrame"])
        {
            self.mapview.isAllowDecreaseFrame=[[attributes objectForKey:@"isAllowDecreaseFrame"] boolValue
                                           ] ;
            
        }
        if ([alleys containsObject:@"maxRenderFrame"])
        {
            self.mapview.maxRenderFrame=[[attributes objectForKey:@"maxRenderFrame"] intValue
                                               ] ;
            
        }
        if ([alleys containsObject:@"showsScale"])
        {
            self.mapview.showsScale=[[attributes objectForKey:@"showsScale"] boolValue
                                           ] ;
            
        }
        if ([alleys containsObject:@"showsCompass"])
        {
            self.mapview.showsCompass=[[attributes objectForKey:@"showsCompass"] boolValue
                                     ] ;
            
        }
        
        if ([alleys containsObject:@"showTraffic"])
        {
            self.mapview.showTraffic=[[attributes objectForKey:@"showTraffic"] boolValue
                                       ] ;
            
        }
        if ([alleys containsObject:@"touchPOIEnabled"])
        {
            self.mapview.touchPOIEnabled=[[attributes objectForKey:@"touchPOIEnabled"] boolValue
                                      ] ;
            
        }
        if ([alleys containsObject:@"trafficRatio"])
        {
            
            self.mapview.trafficRatio=[[attributes objectForKey:@"trafficRatio"] floatValue
                                          ] ;
            
        }
        if ([alleys containsObject:@"trafficStatus"]&&[[attributes objectForKey:@"trafficStatus"] isKindOfClass:[NSDictionary class]])
        {
            NSDictionary * traffic=[attributes objectForKey:@"trafficStatus"];
            NSMutableDictionary *colors=[NSMutableDictionary dictionary];
            if([traffic.allKeys containsObject:@"1"])
            {
                colors[@(1)]=[UIColor colorWithHexString:[traffic objectForKey:@"1"]];
            }
            if([traffic.allKeys containsObject:@"2"])
            {
                colors[@(2)]=[UIColor colorWithHexString:[traffic objectForKey:@"2"]];
            }
            if([traffic.allKeys containsObject:@"3"])
            {
                colors[@(3)]=[UIColor colorWithHexString:[traffic objectForKey:@"3"]];
            }
            if([traffic.allKeys containsObject:@"4"])
            {
                colors[@(4)]=[UIColor colorWithHexString:[traffic objectForKey:@"4"]];
            }
            self.mapview.trafficStatus=colors;
        }
        if ([alleys containsObject:@"rotateCameraEnabled"])
        {
            
            self.mapview.rotateCameraEnabled=[[attributes objectForKey:@"rotateCameraEnabled"] boolValue
                                       ] ;
            
        }
        if ([alleys containsObject:@"skyModelEnable"])
        {
            
            self.mapview.skyModelEnable=[[attributes objectForKey:@"skyModelEnable"] boolValue
                                       ] ;
            
        }
        if ([alleys containsObject:@"showsBuildings"])
        {
            
            self.mapview.showsBuildings=[[attributes objectForKey:@"showsBuildings"] boolValue
                                       ] ;
            
        }
        if ([alleys containsObject:@"showsLabels"])
        {
            
            self.mapview.showsLabels=[[attributes objectForKey:@"showsLabels"] boolValue
                                       ] ;
            
        }
        if ([alleys containsObject:@"zoomEnabled"])
        {
            
            self.mapview.zoomEnabled=[[attributes objectForKey:@"zoomEnabled"] boolValue
                                         ] ;
            
        }
        if ([alleys containsObject:@"scrollEnabled"])
        {
            
            self.mapview.scrollEnabled=[[attributes objectForKey:@"scrollEnabled"] boolValue
                                         ] ;
            
        }
        if ([alleys containsObject:@"rotateEnabled"])
        {
            
            self.mapview.rotateEnabled=[[attributes objectForKey:@"rotateEnabled"] boolValue
                                      ] ;
            
        }
        
        
        if ([alleys containsObject:@"minZoomLevel"])
        {
            self.mapview.minZoomLevel=[[attributes objectForKey:@"minZoomLevel"] floatValue
                                       ] ;
            
            
        }
        if ([alleys containsObject:@"maxZoomLevel"])
        {
            
            self.mapview.maxZoomLevel=[[attributes objectForKey:@"maxZoomLevel"] floatValue
                                         ] ;
            
        }
        if ([alleys containsObject:@"rotationDegree"])
        {
            
            self.mapview.rotationDegree=[[attributes objectForKey:@"rotationDegree"] floatValue
                                       ] ;
            
        }
        if ([alleys containsObject:@"cameraDegree"])
        {
            
            self.mapview.cameraDegree=[[attributes objectForKey:@"cameraDegree"] floatValue
                                                           ] ;
        }
        if ([alleys containsObject:@"zoomingInPivotsAroundAnchorPoint"])
        {
            
            self.mapview.zoomingInPivotsAroundAnchorPoint=[[attributes objectForKey:@"zoomingInPivotsAroundAnchorPoint"] boolValue
                                                           ] ;
            
        }
        if ([self.attributes objectForKey:@"showsUserLocation"])
        {
            
            self.mapview.showsUserLocation=[[self.attributes objectForKey:@"showsUserLocation"] boolValue
                                            ] ;
            
        }
        if ([self.attributes objectForKey:@"customizeUserLocationAccuracyCircleRepresentation"])
        {
            
            self.mapview.customizeUserLocationAccuracyCircleRepresentation=[[self.attributes objectForKey:@"customizeUserLocationAccuracyCircleRepresentation"] boolValue
                                            ] ;
            
        }
        if ([self.attributes objectForKey:@"userTrackingMode"])
        {
            
            self.mapview.userTrackingMode=[[self.attributes objectForKey:@"userTrackingMode"] intValue
                                                                            ] ;
            
        }
        if ([self.attributes objectForKey:@"distanceFilter"])
        {
            
            self.mapview.distanceFilter=[[self.attributes objectForKey:@"distanceFilter"] floatValue
                                           ] ;
            
        }
        if ([self.attributes objectForKey:@"desiredAccuracy"])
        {
            
            
            if([[self.attributes objectForKey:@"distanceFilter"] isEqualToString:@"kCLLocationAccuracyBest"])
            {
                self.mapview.desiredAccuracy=kCLLocationAccuracyBest ;
            }
            else if([[self.attributes objectForKey:@"distanceFilter"] isEqualToString:@"kCLLocationAccuracyBestForNavigation"])
            {
                self.mapview.desiredAccuracy=kCLLocationAccuracyBestForNavigation ;
            }
            else if([[self.attributes objectForKey:@"distanceFilter"] isEqualToString:@"kCLLocationAccuracyNearestTenMeters"])
            {
                self.mapview.desiredAccuracy=kCLLocationAccuracyNearestTenMeters ;
            }
            else if([[self.attributes objectForKey:@"distanceFilter"] isEqualToString:@"kCLLocationAccuracyHundredMeters"])
            {
                self.mapview.desiredAccuracy=kCLLocationAccuracyHundredMeters ;
            }
            else if([[self.attributes objectForKey:@"distanceFilter"] isEqualToString:@"kCLLocationAccuracyKilometer"])
            {
                self.mapview.desiredAccuracy=kCLLocationAccuracyKilometer ;
            }
            else if([[self.attributes objectForKey:@"distanceFilter"] isEqualToString:@"kCLLocationAccuracyThreeKilometers"])
            {
                self.mapview.desiredAccuracy=kCLLocationAccuracyThreeKilometers ;
            }
            else
            {
                self.mapview.desiredAccuracy=[[self.attributes objectForKey:@"distanceFilter"] doubleValue] ;
            }
            
            
        }
        if ([self.attributes objectForKey:@"headingFilter"])
        {
            if([[self.attributes objectForKey:@"headingFilter"] isEqualToString:@"kCLHeadingFilterNone"])
            {
                self.mapview.desiredAccuracy=kCLHeadingFilterNone ;
            }
            else
            self.mapview.headingFilter=[[self.attributes objectForKey:@"headingFilter"] doubleValue
                                         ] ;
            
        }
        
        if ([self.attributes objectForKey:@"pausesLocationUpdatesAutomatically"])
        {
            
            self.mapview.pausesLocationUpdatesAutomatically=[[self.attributes objectForKey:@"pausesLocationUpdatesAutomatically"] boolValue
                                                                            ] ;
            
        }
        
       
        
        ///是否允许后台定位。默认为NO。只在iOS 9.0之后起作用。\n 设置为YES的时候必须保证 Background Modes 中的 Location updates处于选中状态，否则会抛出异常。\n 注意：定位必须在停止的状态下设置（showsUserLocation = NO），否则无效
        
        if ([self.attributes objectForKey:@"allowsBackgroundLocationUpdates"])
        {
            
            self.mapview.allowsBackgroundLocationUpdates=[[self.attributes objectForKey:@"allowsBackgroundLocationUpdates"] boolValue
                                                             ] ;
        }
        
        
        
        

    });
    
    
}
-(void)viewDidLoad
{
    [super viewDidLoad];
//    if ([[self.attributes objectForKey:@"region"] isKindOfClass:[NSDictionary class]])
//    {
//
//          NSLog(@"%f,%f,%f,%f",self.mapview.region.center.latitude,self.mapview.region.center.longitude,self.mapview.region.span.latitudeDelta,self.mapview.region.span.longitudeDelta);
//        NSLog(@"%f",[self.mapview regionThatFits:MACoordinateRegionMake(CLLocationCoordinate2DMake([[[self.attributes objectForKey:@"region"] objectForKey:@"latitude"] doubleValue], [[[self.attributes objectForKey:@"region"] objectForKey:@"longitude"] doubleValue]), MACoordinateSpanMake(0.1,0.1)) ].span.latitudeDelta);
//        MACoordinateRegion region ={{31.139111, 121.71656},{0.1, 0.1}};
//
//        self.mapview.region=region; // [self.mapview regionThatFits:MACoordinateRegionMake(CLLocationCoordinate2DMake([[[self.attributes objectForKey:@"region"] objectForKey:@"latitude"] doubleValue], [[[self.attributes objectForKey:@"region"] objectForKey:@"longitude"] doubleValue]), MACoordinateSpanMake(0.1,0.1)) ]  ;
//
//        NSLog(@"%f,%f,%f,%f",[[[self.attributes objectForKey:@"region"] objectForKey:@"latitude"] doubleValue],[[[self.attributes objectForKey:@"region"] objectForKey:@"longitude"] doubleValue],[[[self.attributes objectForKey:@"region"] objectForKey:@"latitudeDelta"] doubleValue],[[[self.attributes objectForKey:@"region"] objectForKey:@"longitudeDelta"] doubleValue]);
//         NSLog(@"%f,%f,%f,%f",self.mapview.region.center.latitude,self.mapview.region.center.longitude,self.mapview.region.span.latitudeDelta,self.mapview.region.span.longitudeDelta);
//
//    }
    
    
}


-(void)layoutDidFinish
{
    [super layoutDidFinish];
    if ([[ self.attributes objectForKey:@"logoCenter"] isKindOfClass:[NSDictionary class]])
    {
        self.mapview.logoCenter=CGPointMake([[[self.attributes objectForKey:@"logoCenter"] objectForKey:@"x"] doubleValue], [[[self.attributes objectForKey:@"logoCenter"] objectForKey:@"y"] doubleValue]) ;
        
        
        
    }
    if ([[self.attributes objectForKey:@"scaleOrigin"] isKindOfClass:[NSDictionary class]])
    {
        self.mapview.scaleOrigin=CGPointMake([[[self.attributes objectForKey:@"scaleOrigin"] objectForKey:@"x"] doubleValue], [[[self.attributes objectForKey:@"scaleOrigin"] objectForKey:@"y"] doubleValue]) ;
        
        
    }
    if ([[self.attributes objectForKey:@"compassOrigin"] isKindOfClass:[NSDictionary class]])
    {
        self.mapview.compassOrigin=CGPointMake([[[self.attributes objectForKey:@"compassOrigin"] objectForKey:@"x"] doubleValue], [[[self.attributes objectForKey:@"compassOrigin"] objectForKey:@"y"] doubleValue]) ;
        
        
    }
    
    
}
-(UIView *)loadView
{
    
    return self.mapview;
}

-(void)updateStyles:(NSDictionary *)styles
{
    [super updateStyles:styles];
    
}
-(void)updateAttributes:(NSDictionary *)attributes

{
    
    [super updateAttributes:attributes];
    [self parseAttributes:attributes];
    if ([[ self.attributes objectForKey:@"logoCenter"] isKindOfClass:[NSDictionary class]])
    {
        self.mapview.logoCenter=CGPointMake([[[self.attributes objectForKey:@"logoCenter"] objectForKey:@"x"] doubleValue], [[[self.attributes objectForKey:@"logoCenter"] objectForKey:@"y"] doubleValue]) ;
        
        
        
    }
    if ([[self.attributes objectForKey:@"scaleOrigin"] isKindOfClass:[NSDictionary class]])
    {
        self.mapview.scaleOrigin=CGPointMake([[[self.attributes objectForKey:@"scaleOrigin"] objectForKey:@"x"] doubleValue], [[[self.attributes objectForKey:@"scaleOrigin"] objectForKey:@"y"] doubleValue]) ;
        
        
    }
    if ([[self.attributes objectForKey:@"compassOrigin"] isKindOfClass:[NSDictionary class]])
    {
        self.mapview.compassOrigin=CGPointMake([[[self.attributes objectForKey:@"compassOrigin"] objectForKey:@"x"] doubleValue], [[[self.attributes objectForKey:@"compassOrigin"] objectForKey:@"y"] doubleValue]) ;
        
        
    }

}

-(MAMapView *)mapview
{
    if(!_mapview)
    {
        _mapview = [[MAMapView alloc] init];
        _mapview.showsUserLocation = YES;
        _mapview.zoomLevel=14;
        _mapview.delegate=self;
        
        _mapview.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    }
    
    return _mapview;
}
-(void)insertSubview:(WXComponent *)subcomponent atIndex:(NSInteger)index
{
    [self.view addSubview:subcomponent.view];
}
-(void)willRemoveSubview:(WXComponent *)component
{
    [self.view willRemoveSubview:component.view];
}
#pragma mark mapview delegate
-(void)mapView:(MAMapView *)mapView didChangeOpenGLESDisabled:(BOOL)openGLESDisabled
{
    NSLog(@"%s",__func__);
}
-(void)mapView:(MAMapView *)mapView didTouchPois:(NSArray *)pois
{
    
}
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    
    if([annotation isKindOfClass:[WXMapAnnotation class]])
    {
        WXMapAnnotation* anno=(WXMapAnnotation *)annotation;
        MAAnnotationView *view=[[MAAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:NSStringFromClass([WXMapAnnotation class])];
        view.image=[UIImage imageNamed:anno.image];
        view.canShowCallout=YES;
        view.annotation=annotation;
        view.leftCalloutAccessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:anno.callOutImage]];
        return view;
    }
    return nil;
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    /* 自定义定位精度对应的MACircleView. */
    if (overlay == mapView.userLocationAccuracyCircle)
    {
        MACircleRenderer *accuracyCircleRenderer = [[MACircleRenderer alloc] initWithCircle:(MACircle*)overlay];
        
        accuracyCircleRenderer.lineWidth    = 2.f;
        accuracyCircleRenderer.strokeColor  = [UIColor lightGrayColor];
        accuracyCircleRenderer.fillColor    = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
        
        return accuracyCircleRenderer;
    }
    if([overlay isKindOfClass:[WXMapPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:(MAPolyline*)overlay];
        WXMapPolyline *mapline=(WXMapPolyline*)overlay;
        if(mapline.line.strokeColor)
        polylineRenderer.strokeColor = [UIColor colorWithHexString:mapline.line.strokeColor];
        if(mapline.line.fillColor)
        polylineRenderer.fillColor=[UIColor colorWithHexString:mapline.line.fillColor];
        polylineRenderer.lineWidth   = mapline.line.lineWidth;
         polylineRenderer.lineJoinType   = mapline.line.lineJoinType;
         polylineRenderer.lineCapType   = mapline.line.lineCapType;
         polylineRenderer.miterLimit   = mapline.line.miterLimit;
         polylineRenderer.lineDash   = mapline.line.lineDash;
        
        
        return polylineRenderer;
        
    }
    if ([overlay isKindOfClass:[WXMapCircle class]])
    {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:(WXMapCircle *)overlay];
        WXMapCircle *mapCircle=(WXMapCircle *)overlay;
        
        circleRenderer.lineWidth   = mapCircle.circle.lineWidth;
        circleRenderer.strokeColor = [UIColor colorWithHexString:mapCircle.circle.strokeColor];
        circleRenderer.fillColor   = [[UIColor colorWithHexString:mapCircle.circle.fillColor] colorWithAlphaComponent:mapCircle.circle.alpha];
        
        
        
        return circleRenderer;
    }

    return nil;
}



- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
//    MAAnnotationView *userLocationView = [mapView viewForAnnotation:mapView.userLocation];
//    if (!updatingLocation && userLocationView)
//    {
//        [UIView animateWithDuration:0.1 animations:^{
//            
//            double degree = userLocation.heading.trueHeading - self.mapview.rotationDegree;
//            userLocationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );
//            
//        }];
//    }
    if(updatingLocation)
    {
        [self fireEvent:@"didUpdateUserLocation" params:@{@"latitude":@(userLocation.location.coordinate.latitude),@"longitude":@(userLocation.location.coordinate.longitude)}];
    }
}

@end
