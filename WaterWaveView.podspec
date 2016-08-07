Pod::Spec.new do |spec|
  spec.name         = "WaterWaveView"      #名称
  spec.version      = "1.0.0"              #版本号
  spec.summary      = "可控进度的波浪动画视图"
  spec.homepage     = "http://findertiwk.github.io"
  spec.license      = 'MIT'
  spec.author       = { "_Finder丶Tiwk" => "136652711@qq.com" }
  spec.source       = { :git => "https://github.com/FinderTiwk/WaterWaveView.git", :tag => "v1.0.0" }
  spec.platform     = :ios, '7.0'    #支持的系统
  spec.requires_arc = true           #是否需要arc
  spec.source_files = 'WaterWaveView/Src/WaterWaveView.{h,m}'
  spec.public_header_files = 'WaterWaveView/Src/WaterWaveView.h'

end
