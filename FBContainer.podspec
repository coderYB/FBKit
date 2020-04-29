Pod::Spec.new do |spec|
  
  spec.name         = "FBContainer"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For 某些界面."
  spec.description  = <<-DESC
  FBContainer是欢迎界面
  DESC
  
  spec.homepage     = "https://github.com/StoneStoneStoneWang/FBKit.git"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author             = { "StoneStoneStoneWang" => "yuanxingfu1314@163.com" }
  spec.platform     = :ios, "10.0"
  spec.ios.deployment_target = "10.0"
  
  spec.swift_version = '5.0'
  
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  
  spec.static_framework = true
  
  spec.frameworks = 'UIKit', 'Foundation'
  
  spec.source = { :git => "https://github.com/StoneStoneStoneWang/FBKit.git", :tag => "#{spec.version}" }
  
  # 翻译
  spec.subspec 'Welcome' do |welcome|
    
    welcome.source_files = "Code/FBContainer/Welcome/*.{h,m}"
    welcome.dependency 'FBConfig'
    welcome.dependency 'FBBridge/Welcome/Bridge'
    welcome.dependency 'FBImage'
    welcome.dependency 'FBString'
    welcome.dependency 'Masonry'
  end
  
  # 协议 textview
  spec.subspec 'Protocol' do |protocol|
    
    protocol.source_files = "Code/FBContainer/Protocol/*.{h,m}"
    protocol.dependency 'FBConfig'
    protocol.dependency 'FBBridge/Protocol/Bridge'
    protocol.dependency 'Masonry'
  end
  # 协议 webview
  spec.subspec 'Privacy' do |privacy|
    
    privacy.source_files = "Code/FBContainer/Privacy/*.{h,m}"
    privacy.dependency 'FBConfig'
    privacy.dependency 'FBBridge/Protocol/Bridge'
    privacy.dependency 'Masonry'
  end
  
  # 登陆 login
  spec.subspec 'Login' do |login|
    
    login.source_files = "Code/FBContainer/Login/*.{h,m}"
    login.dependency 'FBConfig'
    login.dependency 'FBBridge/Login/Bridge'
    login.dependency 'Masonry'
    login.dependency 'FBTextField'
    login.dependency 'FBTransition'
    login.dependency 'FBImage'
    login.dependency 'FBString'
    login.dependency 'FBDraw'
  end
  
  # 注册 swiftLogin
  spec.subspec 'SwiftLogin' do |swiftLogin|
    
    swiftLogin.source_files = "Code/FBContainer/SwiftLogin/*.{h,m}"
    swiftLogin.dependency 'FBConfig'
    swiftLogin.dependency 'FBBridge/SwiftLogin/Bridge'
    swiftLogin.dependency 'Masonry'
    swiftLogin.dependency 'FBTextField'
    swiftLogin.dependency 'FBTransition'
    swiftLogin.dependency 'FBImage'
    swiftLogin.dependency 'FBString'
    swiftLogin.dependency 'FBDraw'
  end
  
  # 密码 password
  spec.subspec 'Password' do |password|
    
    password.source_files = "Code/FBContainer/Password/*.{h,m}"
    password.dependency 'FBConfig'
    password.dependency 'FBBridge/Password/Bridge'
    password.dependency 'Masonry'
    password.dependency 'FBTextField'
    password.dependency 'FBTransition'
    password.dependency 'FBImage'
    password.dependency 'FBString'
    password.dependency 'FBDraw'
  end
  
  # 轮播 carousel
  spec.subspec 'Carousel' do |carousel|
    
    carousel.source_files = "Code/FBContainer/Carousel/*.{h,m}"
    carousel.dependency 'FBConfig'
    carousel.dependency 'FBBridge/Carousel/Bridge'
    carousel.dependency 'Masonry'
    carousel.dependency 'FBCollection'
    carousel.dependency 'FBString'
  end
  
  # 轮播 banner
  spec.subspec 'Banner' do |banner|
    
    banner.source_files = "Code/FBContainer/Banner/*.{h,m}"
    banner.dependency 'FBConfig'
    banner.dependency 'FBBridge/Carousel/Bridge'
    banner.dependency 'Masonry'
    banner.dependency 'FBCollection'
    banner.dependency 'SDWebImage'
    banner.dependency 'FBString'
  end
  
  # 设置 setting
  spec.subspec 'Setting' do |setting|
    
    setting.source_files = "Code/FBContainer/Setting/*.{h,m}"
    setting.dependency 'FBConfig'
    setting.dependency 'FBBridge/Setting/Bridge'
    setting.dependency 'Masonry'
    setting.dependency 'FBTable'
    setting.dependency 'SDWebImage'
  end
  
  # 关于我们 about
  spec.subspec 'About' do |about|
    
    about.source_files = "Code/FBContainer/About/*.{h,m}"
    about.dependency 'FBConfig'
    about.dependency 'FBBridge/About/Bridge'
    about.dependency 'FBTable'
    about.dependency 'Masonry'
  end
  
  # 意见建议 feedBack
  spec.subspec 'FeedBack' do |feedBack|
    
    feedBack.source_files = "Code/FBContainer/FeedBack/*.{h,m}"
    feedBack.dependency 'FBConfig'
    feedBack.dependency 'FBBridge/FeedBack/Bridge'
    feedBack.dependency 'Masonry'
    feedBack.dependency 'FBTransition'
    feedBack.dependency 'JXTAlertManager'
    feedBack.dependency 'FBTextField'
    feedBack.dependency 'FBImage'
    feedBack.dependency 'FBString'
  end
  
  # 昵称 Name
  spec.subspec 'Name' do |name|
    
    name.source_files = "Code/FBContainer/Name/*.{h,m}"
    name.dependency 'FBConfig'
    name.dependency 'FBBridge/Name/Bridge'
    name.dependency 'Masonry'
    name.dependency 'FBTextField'
    name.dependency 'FBTransition'
    name.dependency 'FBString'
  end
  
  # 个性签名 signature
  spec.subspec 'Signature' do |signature|
    
    signature.source_files = "Code/FBContainer/Signature/*.{h,m}"
    signature.dependency 'FBConfig'
    signature.dependency 'FBBridge/Signature/Bridge'
    signature.dependency 'Masonry'
    signature.dependency 'FBTransition'
    signature.dependency 'FBString'
  end
  
  # 个人中心 userinfo
  spec.subspec 'UserInfo' do |userInfo|
    userInfo.frameworks = 'UIKit', 'Foundation','CoreServices'
    userInfo.source_files = "Code/FBContainer/UserInfo/*.{h,m}"
    userInfo.dependency 'FBConfig'
    userInfo.dependency 'FBBridge/UserInfo/Bridge'
    userInfo.dependency 'Masonry'
    userInfo.dependency 'FBTable'
    userInfo.dependency 'ZDatePicker'
    userInfo.dependency 'SDWebImage'
    userInfo.dependency 'JXTAlertManager'
    userInfo.dependency 'WLToolsKit/Image'
    userInfo.dependency 'FBString'
  end
  
  # 意见建议 feedBack
  spec.subspec 'FeedBack' do |feedBack|
    
    feedBack.source_files = "Code/FBContainer/FeedBack/*.{h,m}"
    feedBack.dependency 'FBConfig'
    feedBack.dependency 'FBBridge/FeedBack/Bridge'
    feedBack.dependency 'Masonry'
    feedBack.dependency 'FBTransition'
    feedBack.dependency 'JXTAlertManager'
    feedBack.dependency 'FBTextField'
  end
  
  #  # 黑名单 black
  #  spec.subspec 'Black' do |black|
  #
  #    black.source_files = "Code/FBContainer/Black/*.{h,m}"
  #    black.dependency 'FBConfig'
  #    black.dependency 'FBBridge/Black/Bridge'
  #    black.dependency 'Masonry'
  #    black.dependency 'FBTable'
  #    black.dependency 'SDWebImage'
  #    black.dependency 'JXTAlertManager'
  #  end
  #  # 关注 focus
  #  spec.subspec 'Focus' do |focus|
  #
  #    focus.source_files = "Code/FBContainer/Focus/*.{h,m}"
  #    focus.dependency 'FBConfig'
  #    focus.dependency 'FBBridge/Focus/Bridge'
  #    focus.dependency 'Masonry'
  #    focus.dependency 'FBTable'
  #    focus.dependency 'SDWebImage'
  #    focus.dependency 'JXTAlertManager'
  #  end
  
  # 举报 举报
  spec.subspec 'Report' do |report|
    
    report.source_files = "Code/FBContainer/Report/*.{h,m}"
    report.dependency 'FBConfig'
    report.dependency 'FBBridge/Report/Bridge'
    report.dependency 'Masonry'
    report.dependency 'FBTable'
    report.dependency 'JXTAlertManager'
  end
  
  # 地址 address
  spec.subspec 'Address' do |address|
    
    address.source_files = "Code/FBContainer/Address/*.{h,m}"
    address.dependency 'FBConfig'
    address.dependency 'FBBridge/Address/Bridge'
    address.dependency 'Masonry'
    address.dependency 'FBTable'
    address.dependency 'JXTAlertManager'
    address.dependency 'FBImage'
    address.dependency 'FBString'
  end
  # 地址 address
  spec.subspec 'Comment' do |comment|
    
    comment.source_files = "Code/FBContainer/Comment/*.{h,m}"
    comment.dependency 'FBConfig'
    comment.dependency 'FBBridge/Comment/Bridge'
    comment.dependency 'SDWebImage'
    comment.dependency 'Masonry'
    comment.dependency 'FBTable'
    comment.dependency 'JXTAlertManager'
    comment.dependency 'FBString'
  end
  # 地址 area
  spec.subspec 'Area' do |area|
    
    area.source_files = "Code/FBContainer/Area/*.{h,m}"
    area.dependency 'FBConfig'
    area.dependency 'FBBridge/Area/Bridge'
    area.dependency 'Masonry'
    area.dependency 'FBTable'
    area.dependency 'FBCollection'
    area.dependency 'JXTAlertManager'
  end
  
  # 地址 地图
  spec.subspec 'Map' do |map|
    map.source_files = "Code/FBContainer/Map/*.{h,m}"
    map.dependency 'FBTransition'
    map.dependency 'FBAMap'
    map.dependency 'FBConfig'
    map.frameworks = 'UIKit', 'Foundation' ,'CoreLocation'
  end
  
end
