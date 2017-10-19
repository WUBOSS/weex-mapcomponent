# weex-mapcomponent
weex-mapcomponent是一个weex插件，可以通过weexpack快速集成，可以丰富weex功能

支持的weexpack版本： >= 0.2.0
支持的WeexSDK版本： >= 0.10.0

# 功能

# 快速使用
- 通过weexpack初始化一个测试工程 weextest
   ```
   weexpack create weextest
   ```
- 添加ios平台
  ```
  weexpack platform add ios
  ```
- 添加android平台
  ```
  weexpack platform add android
  ```
- 添加插件
  ```
  weexpack plugin add weex-mapcomponent
  ```
# 项目地址
[github](https://github.com/WUBOSS/weex-mapcomponent.git)

# 已有工程集成
## iOS集成插件WeexMapcomponent
- 命令行集成
  ```
  weexpack plugin add weex-mapcomponent
  ```
- 手动集成
  在podfile 中添加
  ```
  pod 'WeexMapcomponent'
  ```

## IPA
- WXMapComponent
```htlm
 <WXMapComponent ref='WXMapComponent' class="map"  mapkey="85dce3c69f70a9615e56519b8e7ecb0b" mapType="0" zoomLevel="15" >

 </WXMapComponent>

```
- WXMapComponent支持属性
   ```$xslt
    mapkey:申请的高德key
   
    mapType:     MAMapTypeStandard = 0,  ///< 普通地图
                  MAMapTypeSatellite= 1,     ///< 卫星地图
                  MAMapTypeStandardNight= 2, ///< 夜间视图
                  MAMapTypeNavi= 3,          ///< 导航视图
                  MAMapTypeBus= 4            ///< 公交视图
                  传对应数字
    centerCoordinate：{latitude:131.12211,longitude:42.12332} ///当前地图的中心点，改变该值时，地图的比例尺级别不会发生变化
    
    zoomLevel: 15  ///缩放级别（默认3-19，有室内地图时为3-20）
    
    runLoopMode:
    ///地图渲染的runloop mode，默认为NSRunLoopCommonModes。如果是和UIScrollView一起使用且不希望地图在scrollView拖动时渲染，请设置此值为NSDefaultRunLoopMode。（since 5.1.0）
    
    screenAnchor: {x:131.12211,y:42.12332}
    ///地图的视图锚点。坐标系归一化，(0, 0)为MAMapView左上角，(1, 1)为右下角。默认为(0.5, 0.5)，即当前地图的视图中心 （since 5.0.0）
    
    openGLESDisabled: BOOL
    ///停止/开启 OpenGLES绘制, 默认NO. 对应回调是 - (void)mapView:(MAMapView *) didChangeOpenGLESDisabled:(BOOL)
    
    isAllowDecreaseFrame:BOOL
    ///是否允许降帧，默认为YES
    
    maxRenderFrame:number
    ///最大帧数，有效的帧数为：60、30、20、10等能被60整除的数。默认为60
    
    logoCenter josn {x:20,y:20}
    ///logo位置, 必须在mapView.bounds之内，否则会被忽略
    
    showsScale  BOOL
    ///是否显示比例尺, 默认YES
    
    scaleOrigin  josn {x:100,y:100}
    ///比例尺原点位置
    
    showsCompass ///是否显示指南针, 默认YES
 
    compassOrigin josn {x:100,y:100} ///指南针原点位置
   
    showTraffic ///是否显示交通, 默认为NO
   
    trafficStatus ///josn 设置实时交通颜色,key为 MATrafficStatus {1:#ffffff} 只支持六位 @"#FFFFFF" ,@"OXFFFFFF" ,@"FFFFFF"
    @property (nonatomic, copy) NSDictionary <NSNumber *, UIColor *> * MATrafficStatus;
    typedef NS_ENUM(NSInteger, MATrafficStatus)
    {
        MATrafficStatusSmooth = 1,                  ///< 1 通畅
        MATrafficStatusSlow,                        ///< 2 缓行
        MATrafficStatusJam,                         ///< 3 阻塞
        MATrafficStatusSeriousJam,                  ///< 4 严重阻塞
    };
    
    trafficRatio float ///设置实时交通线宽系数，默认线宽系数为0.8，范围为[0 - 1] (since 5.3.0)
    @property (nonatomic, assign) CGFloat trafficRatio;
    
    touchPOIEnabled ///是否支持单击地图获取POI信息(默认为YES), 对应的回调是 -(void)mapView:(MAMapView *) didTouchPois:(NSArray *)
    @property (nonatomic, assign) BOOL touchPOIEnabled;
    
    
    rotateCameraEnabled ///是否支持camera旋转, 默认YES
    @property (nonatomic, getter = isRotateCameraEnabled) BOOL rotateCameraEnabled;
    
    skyModelEnable ///是否支持天空模式，默认为YES. 开启后，进入天空模式后，annotation重用可视范围会缩减
    @property (nonatomic, getter = isSkyModelEnabled) BOOL skyModelEnable;
    
    showsBuildings ///是否显示楼块，默认为YES
    @property (nonatomic, getter = isShowsBuildings) BOOL showsBuildings;
    
    showsLabels ///是否显示底图标注, 默认为YES
    @property (nonatomic, assign, getter = isShowsLabels) BOOL showsLabels;
    
    
    zoomEnabled ///是否支持缩放, 默认YES
    @property (nonatomic, getter = isZoomEnabled) BOOL zoomEnabled;
    
    scrollEnabled ///是否支持平移, 默认YES
    @property (nonatomic, getter = isScrollEnabled) BOOL scrollEnabled;
    
    rotateEnabled ///是否支持旋转, 默认YES
    @property (nonatomic, getter = isRotateEnabled) BOOL rotateEnabled;
    
    minZoomLevel ///最小缩放级别
    @property (nonatomic) CGFloat minZoomLevel;
    
    maxZoomLevel ///最大缩放级别（有室内地图时最大为20，否则为19）
    @property (nonatomic) CGFloat maxZoomLevel;
    
    rotationDegree ///设置地图旋转角度(逆时针为正向)
    @property (nonatomic) CGFloat rotationDegree;
    
    cameraDegree ///设置地图相机角度(范围为[0.f, 60.f]，但高于40度的角度需要在16级以上才能生效)
    @property (nonatomic) CGFloat cameraDegree;
    
    zoomingInPivotsAroundAnchorPoint ///是否以screenAnchor点作为锚点进行缩放，默认为YES。如果为NO，则以手势中心点作为锚点
    @property (nonatomic, assign) BOOL zoomingInPivotsAroundAnchorPoint;
    
    ```
- WXMapComponent方法

```$xslt
 isAbroad(callback)
    * callback  function(isAbroad) isAbroad bool类型
```    
```javascript
    this.$refs.WXMapComponent.isAbroad(function (result) {
                                var modal = weex.requireModule('modal')
                                modal.toast({
                                    message: result,
                                    duration: 0.7
                                })
                            });    
```
```$xslt  
 metersPerPointForCurrentZoom(callback)
    * callback  function(res) res number类型
```   
```javascript
 this.$refs.WXMapComponent.metersPerPointForCurrentZoom(function (result) {
                            var modal = weex.requireModule('modal')
                            modal.toast({
                                message: result,
                                duration: 0.7
                            })
                        });    
``` 
   
        
```$xslt  
 logoSize(callback)
      * callback  function(res) res josn {width:50 height:20}    
```   
```javascript
 this.$refs.WXMapComponent.logoSize(function (result) {
                         var modal = weex.requireModule('modal')
                         modal.toast({
                             message: JSON.stringify(result),
                             duration: 0.7
                         })
                     });
```
```$xslt  
 scaleSize(callback) ///比例尺的最大宽高
 * callback  function(res) res josn {width:50 height:20}    
```   
```javascript
 this.$refs.WXMapComponent.scaleSize(function (result) {
                         var modal = weex.requireModule('modal')
                         modal.toast({
                             message: JSON.stringify(result),
                             duration: 0.7
                         })
                     });
```
```$xslt  
 compassSize(callback) ///指南针的宽高
 * callback  function(res) res josn {width:50 height:20}    
```   
```javascript
 this.$refs.WXMapComponent.compassSize(function (result) {
                         var modal = weex.requireModule('modal')
                         modal.toast({
                             message: JSON.stringify(result),
                             duration: 0.7
                         })
                     });
```
///
