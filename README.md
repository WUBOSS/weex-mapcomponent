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
   
    mapType:        MAMapTypeStandard = 0,  ///< 普通地图
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
    ///停止/开启 OpenGLES绘制, 默认NO. 
    
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
   
    showTraffic bool ///是否显示交通, 默认为NO
   
    trafficStatus ///josn 设置实时交通颜色,key为 MATrafficStatus {1:"#ffffff",2:"#ffffff",3:"#ffffff",4:"#ffffff"} 只支持六位 @"#FFFFFF" ,@"OXFFFFFF" ,@"FFFFFF"
    typedef NS_ENUM(NSInteger, MATrafficStatus)
    {
        MATrafficStatusSmooth = 1,                  ///< 1 通畅
        MATrafficStatusSlow,                        ///< 2 缓行
        MATrafficStatusJam,                         ///< 3 阻塞
        MATrafficStatusSeriousJam,                  ///< 4 严重阻塞
    };
    
    trafficRatio float ///设置实时交通线宽系数，默认线宽系数为0.8，范围为[0 - 1] (since 5.3.0)
    
    touchPOIEnabled ///是否支持单击地图获取POI信息(默认为YES) 
    
    rotateCameraEnabled ///是否支持camera旋转, 默认YES
   
    
    skyModelEnable ///是否支持天空模式，默认为YES. 开启后，进入天空模式后，annotation重用可视范围会缩减
   
    
    showsBuildings ///是否显示楼块，默认为YES
   
    
    showsLabels ///是否显示底图标注, 默认为YES
    
    
    
    zoomEnabled ///是否支持缩放, 默认YES
   
    
    scrollEnabled ///是否支持平移, 默认YES
    
    
    rotateEnabled ///是否支持旋转, 默认YES
    
    
    minZoomLevel ///最小缩放级别
    
    
    maxZoomLevel ///最大缩放级别（有室内地图时最大为20，否则为19）
   
    
    rotationDegree ///设置地图旋转角度(逆时针为正向)
   
    
    cameraDegree ///设置地图相机角度(范围为[0.f, 60.f]，但高于40度的角度需要在16级以上才能生效)
   
    
    zoomingInPivotsAroundAnchorPoint ///是否以screenAnchor点作为锚点进行缩放，默认为YES。如果为NO，则以手势中心点作为锚点
   
   showsUserLocation  bool//显示用户位置
    
   userTrackingMode: 0-2 {
                          MAUserTrackingModeNone              = 0,    ///< 不追踪用户的location更新
                          MAUserTrackingModeFollow            = 1,    ///< 追踪用户的location更新
                          MAUserTrackingModeFollowWithHeading = 2     ///< 追踪用户的location与heading更新
                      };
    
    ```
- WXMapComponent方法

```$xslt
 isAbroad(callback) 地图是否在国外
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
```$xslt  
 setRegion(region,animate) ///设定当前地图的经纬度范围，该范围可能会被调整为适合地图窗口显示的范围
 
 region :{latitude:31.139111,longitude:121.71656,latitudeDelta:1,longitudeDelta:1}
 animate:bool 是否动画
```   
```javascript
 this.$refs.WXMapComponent.setRegion({latitude:31.139111,longitude:121.71656,latitudeDelta:1,longitudeDelta:1},1);

```

```$xslt  
 setVisibleMapRect(rect,animate) 
 /**
  * @brief 设置可见区域
  * @param mapRect 要设定的可见区域
  * @param animated 是否动画设置
  */

 rect :{x:0,y:0,width:50,height:50}
 animate:bool 是否动画
```   
```javascript
 this.$refs.WXMapComponent.setVisibleMapRect({x:0,y:0,width:50,height:50},1);

```
```$xslt  
 setCenterCoordinate(coordinate,animate) 
 ///**
 // * @brief 设置当前地图的中心点，改变该值时，地图的比例尺级别不会发生变化
 // * @param coordinate 要设置的中心点
 // * @param animated 是否动画设置
 // */
 
 coordinate :{latitude:31.139111,longitude:121.71656}
 animate:bool 是否动画
```   
```javascript
 this.$refs.WXMapComponent.setCenterCoordinate({latitude:31.139111,longitude:121.71656},1);

```

```$xslt  
 setZoomLevel(zoomLevel,animated)
 ///**
 // * @brief 设置缩放级别（默认3-19，有室内地图时为3-20）
 // * @param zoomLevel 要设置的缩放级别
 // * @param animated 是否动画设置
 // */
```   
```javascript
 this.$refs.WXMapComponent.setZoomLevel(13,1);
```

```$xslt  
 setRotationDegree(rotationDegree,animated,duration)
 ///**
 // * @brief 设置地图旋转角度(逆时针为正向)
 // * @param rotationDegree 旋转角度
 // * @param animated 动画
 // * @param duration 动画时间
 // */
```   
```javascript
 this.$refs.WXMapComponent.setRotationDegree(5,1,0.25);
```
```$xslt  
 setCameraDegree(cameraDegree,animated,duration)
 
 //**
 // * @brief 设置地图相机角度(范围为[0.f, 60.f]，但高于40度的角度需要在16级以上才能生效)
 // * @param cameraDegree 要设置的相机角度
 // * @param animated 是否动画
 // * @param duration 动画时间
 // */
```   
```javascript
 this.$refs.WXMapComponent.setCameraDegree(10,1,0.25);
```

```$xslt  
 getMapStatus(callBack)
 ///**
 // * @brief 获取地图状态
 // * @return 地图状态{latitude:,
                      longitude:,
                      zoomLevel:,
                      rotationDegree:,
                      cameraDegree:,
                      screenAnchorx:,
                      screenAnchory:
                      
 }
 // */
 
```   
```javascript
 this.$refs.WXMapComponent.getMapStatus(function(rect) {
   
 });
```

```$xslt  
setCompassImage(imageName)
//**
// * @brief 设置指南针的图片
// * @param image 新的指南针图片
// */
```   
```javascript
  this.$refs.WXMapComponent.setCompassImage("imageName");
```
```$xslt  
takeSnapshotInRect(rect,callBack)
///**
// * @brief 在指定区域内截图(默认会包含该区域内的annotationView)
// * @param rect 指定的区域
// * @return 截图image
// */
```   
```javascript
  this.$refs.WXMapComponent.takeSnapshotInRect({x:0,y:0,width:100,height:100},function(imageName) {
    
  });
```
```$xslt  
clearDisk()
///**
// * @brief 清除所有磁盘上缓存的地图数据(不包括离线地图)
// */
```   
```javascript
  this.$refs.WXMapComponent.clearDisk();
```
```$xslt  
reloadMap()
///**
// * @brief 重新加载地图
// *
```   
```javascript
  this.$refs.WXMapComponent.reloadMap();
```

```$xslt  
addAnnotation()
///**
// * @brief 加大头针
// *
```   
```javascript
  this.$refs.WXMapComponent.addAnnotation({latitude:31.139111,longitude:121.71656,subtitle:"松江店",title:"肯德基",image:"imagename",ID:0,callOutImage:"imagename"});

```

```$xslt  
removeAnnotation(ID)
///**
// * @brief 删除加大头针
// *
```   
```javascript
  this.$refs.WXMapComponent.removeAnnotation(0);

```

```$xslt  
selectAnnotation(ID)
///**
// * @brief 选中加大头针
// *
```   
```javascript
  this.$refs.WXMapComponent.selectAnnotation(0);

```
```$xslt  
userLocation(callBack)
///**
// * @brief 选中加大头针
{latitude:31.139111,longitude:121.71656}
// *
```   
```javascript
  this.$refs.WXMapComponent.userLocation(function(ret) {
    
  });

```
```$xslt  
setUserTrackingMode(mode,animated)
/**
 * @brief 设置定位用户位置的模式
 * @param mode 要设置的模式 0到2
 
                     {
                         MAUserTrackingModeNone              = 0,    ///< 不追踪用户的location更新
                         MAUserTrackingModeFollow            = 1,    ///< 追踪用户的location更新
                         MAUserTrackingModeFollowWithHeading = 2     ///< 追踪用户的location与heading更新
                     };
 * @param animated 是否动画设置
 */
```   
```javascript
  this.$refs.WXMapComponent.setUserTrackingMode(1,1);

```
```$xslt  
addLineOverlay(overlay,callBack)
/**
画线//    {    points:[{latitude:39.938698,longitude:116.275177},{latitude:39.966069,longitude:116.289253},{latitude:39.944226,longitude:116.306076},{latitude:39.966069,longitude:116.322899},{latitude:39.938698,longitude:116.336975}],
  //        fillColor:"#B0E0E6", 填充颜色
  //        strokeColor:"#DC143C", 边框颜色
  //        lineWidth:20, 线宽
  //        lineJoinType:0到2,{
                               kMALineJoinBevel, 0  ///< 斜面连接点
                               kMALineJoinMiter,  1 ///< 斜接连接点
                               kMALineJoinRound  2  ///< 圆角连接点
                           };
  //        lineCapType:0到3,{
                              kMALineCapButt,   0  ///< 普通头
                              kMALineCapSquare,  1 ///< 扩展头
                              kMALineCapArrow,   2 ///< 箭头
                              kMALineCapRound    3 ///< 圆形头
                          }
  //        miterLimit:10, 
  //        lineDash:1, 是否虚线
  //        ID:0, id 标记
  //    }
 */
```   
```javascript
  this.$refs.WXMapComponent.addLineOverlay( {points:[{latitude:39.938698,longitude:116.275177},{latitude:39.966069,longitude:116.289253},{latitude:39.944226,longitude:116.306076},{latitude:39.966069,longitude:116.322899},{latitude:39.938698,longitude:116.336975}],
                                                     fillColor:"#B0E0E6",
                                                     strokeColor:"#DC143C",
                                                     lineWidth:20,
                                                     lineJoinType:1,
                                                     lineCapType:2,
                                                     miterLimit:10,
                                                     lineDash:1,
                                                     ID:0,
                                                 },function() {
    
  });

```


```$xslt  
removeLineOverlay(id)
///**
// * @brief 删除路线

// *
```   
```javascript
  this.$refs.WXMapComponent.removeLineOverlay(0);

```
```$xslt  
addCircleOverlay(Overlay)
///**
// * @brief 画圆
{

            latitude:31.139111,维度
            longitude:121.71656,经度
            fillColor:"#191970",填充颜色
            strokeColor:"#B0E0E6",边框颜色
            lineWidth:4,线宽
            radius:1000,半径 /米
            ID:0,id
            alpha:0.3透明度 
      }
// *
```   
```javascript
  this.$refs.WXMapComponent.addCircleOverlay({
                                                         latitude:31.139111,
                                                         longitude:121.71656,
                                                         fillColor:"#191970",
                                                         strokeColor:"#B0E0E6",
                                                         lineWidth:4,
                                                         radius:1000,
                                                         ID:0,
                                                         alpha:0.3
                                                   });

```
```$xslt  
removeCircleOverlay(id)
///**
// * @brief 删除圆

// *
```   
```javascript
  this.$refs.WXMapComponent.removeCircleOverlay(0);

```
 
- WXMapComponent绑定事件
```
 didUpdateUserLocation
 
 <WXMapComponent ref='WXMapComponent' class="map" @didUpdateUserLocation="createAction"  mapkey="85dce3c69f70a9615e56519b8e7ecb0b" zoomLevel="15" mapType="0" showsUserLocation="1">
 
``` 