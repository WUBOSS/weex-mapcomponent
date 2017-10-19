# coding: utf-8

Pod::Spec.new do |s|
  s.name         = "WeexMapcomponent"
  s.version      = "0.0.1"
  s.summary      = "Weex高德地图"

  s.description  = <<-DESC
                   weex高德地图

  s.homepage     = "https://github.com/WUBOSS/weex-mapcomponent"
  s.license = {
    :type => 'MIT',
    :text => <<-LICENSE
            copyright
    LICENSE
  }
  s.authors      = {
                     "WUBOSS" =>"1054258896@qq.com"
                   }
  s.platform     = :ios
  s.ios.deployment_target = "7.0"

  s.source       = { :git => 'https://github.com/WUBOSS/weex-mapcomponent.git', :tag => '0.0.1' }
  s.source_files  = "ios/Sources","ios/Sources/*.{h,m,mm}"
  
  s.requires_arc = true
  s.dependency "WeexPluginLoader"
  s.dependency "WeexSDK"
  s.dependency "MOBFoundation"
  s.dependency "AMap3DMap"
  s.dependency "AMapSearch"
  s.dependency "AMapNavi"
  s.dependency "MJExtension"
  s.dependency 'SDWebImage', '3.7.5'
end
