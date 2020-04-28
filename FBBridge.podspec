Pod::Spec.new do |spec|
  
  spec.name         = "FBBridge"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For bridge."
  spec.description  = <<-DESC
  FBBridge是oc swift 转换的封装呢
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
  
  spec.subspec 'Base' do |base|
    base.source_files = "Code/FBBridge/Base/*.{swift}"
    base.dependency 'RxSwift'
  end
  
  #欢迎界面
  spec.subspec 'Welcome' do |welcome|
    
    welcome.subspec 'VM' do |vm|
      vm.source_files = "Code/FBBridge/Welcome/VM/*.{swift}"
      vm.dependency 'WLToolsKit/Common'
      vm.dependency 'FBViewModel'
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
    end
    
    welcome.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Welcome/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Welcome/VM'
      bridge.dependency 'FBCollection'
      bridge.dependency 'FBCocoa/SM'
      bridge.dependency 'FBCocoa/Button'
      bridge.dependency 'FBBridge/Base'
    end
  end
  
  # 协议
  spec.subspec 'Protocol' do |protocol|
    
    protocol.subspec 'VM' do |vm|
      vm.source_files = "Code/FBBridge/Protocol/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBSign'
    end
    
    protocol.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Protocol/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Protocol/VM'
      bridge.dependency 'FBTextInner'
      bridge.dependency 'FBBridge/Base'
    end
  end
  # 协议
  spec.subspec 'Privacy' do |privacy|
    
    privacy.subspec 'VM' do |vm|
      vm.source_files = "Code/FBBridge/Privacy/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBSign'
    end
    
    privacy.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Privacy/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Privacy/VM'
      bridge.dependency 'FBInner'
      bridge.dependency 'FBBridge/Base'
      
    end
  end
  
  
  
  # 登陆
  spec.subspec 'Login' do |login|
    
    login.subspec 'VM' do |vm|
      vm.source_files = "Code/FBBridge/Login/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBCheck'
      vm.dependency 'FBRReq'
      vm.dependency 'FBApi'
      vm.dependency 'FBObservableMapper'
      vm.dependency 'FBError'
    end
    
    login.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Login/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Login/VM'
      bridge.dependency 'FBHud'
      bridge.dependency 'FBBase'
      bridge.dependency 'FBBridge/Base'
    end
  end
  
  # 注册/登陆
  spec.subspec 'Reg' do |reg|
    
    reg.subspec 'VM' do |vm|
      vm.source_files = "Code/FBBridge/Reg/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBCheck'
      vm.dependency 'FBRReq'
      vm.dependency 'FBApi'
      vm.dependency 'FBObservableMapper'
      vm.dependency 'FBError'
    end
    
    reg.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Reg/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Reg/VM'
      bridge.dependency 'FBCocoa/Button'
      bridge.dependency 'FBHud'
      bridge.dependency 'FBBase'
      bridge.dependency 'FBBridge/Base'
    end
  end
  
  # 密码
  spec.subspec 'Password' do |password|
    
    password.subspec 'VM' do |vm|
      vm.source_files = "Code/FBBridge/Password/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBCheck'
      vm.dependency 'FBRReq'
      vm.dependency 'FBApi'
      vm.dependency 'FBObservableMapper'
      vm.dependency 'FBError'
    end
    
    password.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Password/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Password/VM'
      bridge.dependency 'FBCocoa/Button'
      bridge.dependency 'FBHud'
      bridge.dependency 'FBBase'
      bridge.dependency 'FBBridge/Base'
    end
  end
  
  # 设置
  spec.subspec 'Setting' do |setting|
    
    setting.subspec 'VM' do |vm|
      vm.source_files = "Code/FBBridge/Setting/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBCache/Account'
      vm.dependency 'FBSign'
    end
    
    setting.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Setting/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Setting/VM'
      bridge.dependency 'FBTable'
      bridge.dependency 'FBCocoa/SM'
      bridge.dependency 'RxDataSources'
      bridge.dependency 'FBBridge/Base'
    end
  end
  
  # 关于我们
  spec.subspec 'About' do |about|
    
    about.subspec 'VM' do |vm|
      vm.source_files = "Code/FBBridge/About/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBViewModel'
      vm.dependency 'WLToolsKit/String'
    end
    
    about.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/About/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/About/VM'
      bridge.dependency 'FBTable'
      bridge.dependency 'FBCocoa/SM'
      bridge.dependency 'FBBridge/Base'
    end
  end
  
  # 昵称
  spec.subspec 'Name' do |name|
    
    name.subspec 'VM' do |vm|
      
      vm.source_files = "Code/FBBridge/Name/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBCache/User'
      vm.dependency 'FBRReq'
      vm.dependency 'FBApi'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBResult'
      vm.dependency 'FBObservableMapper'
      vm.dependency 'FBError'
    end
    
    name.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Name/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Name/VM'
      bridge.dependency 'FBHud'
      bridge.dependency 'FBBase'
      bridge.dependency 'FBBridge/Base'
    end
  end
  # 个性签名
  spec.subspec 'Signature' do |signature|
    
    signature.subspec 'VM' do |vm|
      vm.source_files = "Code/FBBridge/Signature/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBCache/User'
      vm.dependency 'FBRReq'
      vm.dependency 'FBApi'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBResult'
      vm.dependency 'FBObservableMapper'
      vm.dependency 'FBError'
    end
    
    signature.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Signature/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Signature/VM'
      bridge.dependency 'FBHud'
      bridge.dependency 'FBBase'
      bridge.dependency 'FBBridge/Base'
    end
  end
  
  # 我的资料
  spec.subspec 'UserInfo' do |userinfo|
    
    userinfo.subspec 'VM' do |vm|
      vm.source_files = "Code/FBBridge/UserInfo/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBResult'
      vm.dependency 'FBCache/User'
      vm.dependency 'FBApi'
      vm.dependency 'FBRReq'
      vm.dependency 'FBObservableMapper'
      vm.dependency 'FBError'
    end
    
    userinfo.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/UserInfo/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/UserInfo/VM'
      bridge.dependency 'FBTable'
      bridge.dependency 'FBCocoa/SM'
      bridge.dependency 'RxDataSources'
      bridge.dependency 'FBHud'
      bridge.dependency 'FBBridge/Base'
    end
  end
  
  # 轮播
  spec.subspec 'Carousel' do |welcome|
    
    welcome.subspec 'VM' do |vm|
      vm.source_files = "Code/FBBridge/Carousel/VM/*.{swift}"
      vm.dependency 'WLToolsKit/Common'
      vm.dependency 'FBViewModel'
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
      vm.dependency 'ObjectMapper'
    end
    
    welcome.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Carousel/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Carousel/VM'
      bridge.dependency 'FBCollection'
      bridge.dependency 'FBCocoa/SM'
      bridge.dependency 'FBBridge/Base'
      bridge.dependency 'RxDataSources'
    end
  end
  
  # 举报
  spec.subspec 'Report' do |report|
    
    report.subspec 'VM' do |vm|
      
      vm.source_files = "Code/FBBridge/Report/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'ObjectMapper'
      vm.dependency 'RxDataSources'
      vm.dependency 'FBApi'
      vm.dependency 'FBRReq'
      vm.dependency 'FBResult'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBError'
    end
    
    report.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Report/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Report/VM'
      bridge.dependency 'FBTable'
      bridge.dependency 'FBCocoa/SM'
      bridge.dependency 'RxDataSources'
      bridge.dependency 'FBBridge/Base'
      bridge.dependency 'FBHud'
    end
  end
  
  # 黑名单
  spec.subspec 'Black' do |black|
    
    black.subspec 'VM' do |vm|
      vm.source_files = "Code/FBBridge/Black/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBBean/Black'
      vm.dependency 'FBRReq'
      vm.dependency 'FBApi'
      vm.dependency 'FBResult'
      vm.dependency 'FBError'
      vm.dependency 'FBObservableMapper'
    end
    
    black.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Black/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Black/VM'
      bridge.dependency 'FBHud'
      bridge.dependency 'FBTable'
      bridge.dependency 'FBCocoa/ASM'
      bridge.dependency 'FBCocoa/Refresh'
      bridge.dependency 'FBBridge/Base'
    end
  end
  # 我的关注
  spec.subspec 'Focus' do |focus|
    
    focus.subspec 'VM' do |vm|
      
      vm.source_files = "Code/FBBridge/Focus/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBBean/Focus'
      vm.dependency 'FBRReq'
      vm.dependency 'FBApi'
      vm.dependency 'FBResult'
      vm.dependency 'FBError'
      vm.dependency 'FBObservableMapper'
    end
    
    focus.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Focus/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Focus/VM'
      bridge.dependency 'FBHud'
      bridge.dependency 'FBTable'
      bridge.dependency 'FBCocoa/ASM'
      bridge.dependency 'FBCocoa/Refresh'
      bridge.dependency 'FBBridge/Base'
    end
  end
  
  spec.subspec 'Profile' do |profile|
    
    profile.subspec 'VM' do |vm|
      
      vm.source_files = "Code/FBBridge/Profile/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBApi'
      vm.dependency 'FBRReq'
      vm.dependency 'FBCache/User'
      vm.dependency 'FBResult'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBObservableMapper'
    end
    
    profile.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Profile/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Profile/VM'
      bridge.dependency 'FBTable'
      bridge.dependency 'FBCache/Account'
      bridge.dependency 'FBBridge/Base'
      bridge.dependency 'RxGesture'
      bridge.dependency 'FBCocoa/SM'
    end
  end
  # 个人中心
  spec.subspec 'UserCenter' do |userCenter|
    
    userCenter.subspec 'VM' do |vm|
      
      vm.source_files = "Code/FBBridge/UserCenter/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBApi'
      vm.dependency 'FBRReq'
      vm.dependency 'FBCache/User'
      vm.dependency 'FBResult'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBObservableMapper'
    end
    
    userCenter.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/UserCenter/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/UserCenter/VM'
      bridge.dependency 'FBCollection'
      bridge.dependency 'FBCache/Account'
      bridge.dependency 'FBBridge/Base'
      bridge.dependency 'RxGesture'
      bridge.dependency 'FBCocoa/SM'
    end
  end
  # 个性签名
  spec.subspec 'FeedBack' do |feedBack|
    
    feedBack.subspec 'VM' do |vm|
      vm.source_files = "Code/FBBridge/FeedBack/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBRReq'
      vm.dependency 'FBApi'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBResult'
      vm.dependency 'FBError'
    end
    
    feedBack.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/FeedBack/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/FeedBack/VM'
      bridge.dependency 'FBHud'
      bridge.dependency 'FBBase'
      bridge.dependency 'FBBridge/Base'
    end
  end
  
  # 评论 comment
  spec.subspec 'Comment' do |comment|
    
    comment.subspec 'VM' do |vm|
      vm.source_files = "Code/FBBridge/Comment/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBBean/Comment'
      vm.dependency 'FBRReq'
      vm.dependency 'FBApi'
      vm.dependency 'FBResult'
      vm.dependency 'FBError'
      vm.dependency 'FBObservableMapper'
    end
    
    comment.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Comment/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Comment/VM'
      bridge.dependency 'FBHud'
      bridge.dependency 'FBTable'
      bridge.dependency 'FBBean/Circle'
      bridge.dependency 'FBCocoa/ASM'
      bridge.dependency 'FBCocoa/Refresh'
      bridge.dependency 'FBBridge/Base'
    end
  end
  
  
  # Collections 列表
  spec.subspec 'Collections' do |collections|
    
    collections.subspec 'VM' do |vm|
      vm.source_files = "Code/FBBridge/Collections/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBBean/Circle'
      vm.dependency 'FBRReq'
      vm.dependency 'FBApi'
      vm.dependency 'FBResult'
      vm.dependency 'FBError'
      vm.dependency 'FBObservableMapper'
    end
    
    collections.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Collections/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Collections/VM'
      bridge.dependency 'FBHud'
      bridge.dependency 'FBCollection'
      bridge.dependency 'FBCocoa/ASM'
      bridge.dependency 'FBCocoa/Refresh'
      bridge.dependency 'FBBridge/Base'
      bridge.dependency 'FBCache/Account'
    end
  end
  
  # 列表
  spec.subspec 'Tables' do |tables|
    
    tables.subspec 'VM' do |vm|
      vm.source_files = "Code/FBBridge/Tables/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBBean/Circle'
      vm.dependency 'FBRReq'
      vm.dependency 'FBApi'
      vm.dependency 'FBResult'
      vm.dependency 'FBError'
      vm.dependency 'FBObservableMapper'
    end
    
    tables.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Tables/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Tables/VM'
      bridge.dependency 'FBHud'
      bridge.dependency 'FBTable'
      bridge.dependency 'FBCocoa/ASM'
      bridge.dependency 'FBCocoa/Refresh'
      bridge.dependency 'FBBridge/Base'
      bridge.dependency 'FBCache/Account'
    end
  end
  
  
  
  # 1
  spec.subspec 'CollectionSection' do |cs|
    
    cs.subspec 'VM' do |vm|
      vm.source_files = "Code/FBBridge/CollectionSection/VM/*.{swift}"
      vm.dependency 'FBViewModel'
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
    end
    
    cs.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/CollectionSection/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/CollectionSection/VM'
      bridge.dependency 'FBCollection'
      bridge.dependency 'FBCocoa/SM'
      bridge.dependency 'FBBridge/Base'
      bridge.dependency 'RxDataSources'
    end
  end
  
  # 2
  spec.subspec 'TableSection' do |cs|
    
    cs.subspec 'VM' do |vm|
      vm.source_files = "Code/FBBridge/TableSection/VM/*.{swift}"
      vm.dependency 'FBViewModel'
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
    end
    
    cs.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/TableSection/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/TableSection/VM'
      bridge.dependency 'FBTable'
      bridge.dependency 'FBCocoa/SM'
      bridge.dependency 'FBBridge/Base'
      bridge.dependency 'RxDataSources'
    end
  end
  
  spec.subspec 'Area' do |area|
    
    area.subspec 'Manager' do |manager|
      
      manager.source_files = "Code/FBBridge/Area/Manager/*.{swift}"
      manager.dependency 'RxCocoa'
      manager.dependency 'FBViewModel'
      manager.dependency 'FBApi'
      manager.dependency 'FBRReq'
      manager.dependency 'FBResult'
      manager.dependency 'FBYY'
      manager.dependency 'FBBean/Area'
      manager.dependency 'FBRReq'
      manager.dependency 'FBError'
      manager.dependency 'FBObservableMapper'
    end
    area.subspec 'VM' do |vm|
      
      vm.source_files = "Code/FBBridge/Area/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBResult'
      vm.dependency 'FBBean/Area'
    end
    
    area.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Area/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Area/VM'
      bridge.dependency 'FBBridge/Area/Manager'
      bridge.dependency 'FBTable'
      bridge.dependency 'FBCollection'
      bridge.dependency 'FBBridge/Base'
      bridge.dependency 'FBCocoa/SM'
    end
  end
  
  spec.subspec 'AreaJson' do |areaJson|
    
    areaJson.source_files = "Code/FBBridge/AreaJson/*.{swift}"
    areaJson.dependency 'FBBridge/Area/Manager'
    areaJson.dependency 'FBBridge/Base'
  end
  
  spec.subspec 'Address' do |address|
    
    address.subspec 'VM' do |vm|
      
      vm.source_files = "Code/FBBridge/Address/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBViewModel'
      vm.dependency 'ObjectMapper'
      vm.dependency 'FBApi'
      vm.dependency 'FBRReq'
      vm.dependency 'FBResult'
      vm.dependency 'FBBean/Area'
      vm.dependency 'FBBean/Address'
      vm.dependency 'WLToolsKit/String'
      vm.dependency 'FBError'
      vm.dependency 'FBObservableMapper'
    end
    
    address.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Address/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Address/VM'
      bridge.dependency 'FBTable'
      bridge.dependency 'FBBridge/Base'
      bridge.dependency 'FBHud'
      bridge.dependency 'FBCocoa/ASM'
      bridge.dependency 'FBCocoa/SM'
      bridge.dependency 'FBCocoa/Refresh'
    end
  end
  spec.subspec 'Message' do |message|
    
    message.subspec 'VM' do |vm|
      
      vm.source_files = "Code/FBBridge/Message/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBApi'
      vm.dependency 'FBRReq'
      vm.dependency 'FBResult'
      vm.dependency 'FBBean/Message'
      
    end
    
    message.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Message/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Message/VM'
      bridge.dependency 'FBCollection'
      bridge.dependency 'FBBridge/Base'
      bridge.dependency 'FBCocoa/ASM'
      bridge.dependency 'FBCocoa/Refresh'
    end
  end
  
  # 翻译
  #  spec.subspec 'Translate' do |translate|
  #
  #    translate.subspec 'VM' do |vm|
  #
  #      vm.source_files = "Code/FBBridge/Translate/VM/*.{swift}"
  #      vm.dependency 'RxCocoa'
  #      vm.dependency 'FBViewModel'
  #      vm.dependency 'ObjectMapper'
  #      vm.dependency 'FBApi'
  #      vm.dependency 'FBRReq'
  #      vm.dependency 'FBResult'
  #    end
  #
  #    translate.subspec 'Bridge' do |bridge|
  #      bridge.source_files = "Code/FBBridge/Translate/Bridge/*.{swift}"
  #      bridge.dependency 'FBBridge/Translate/VM'
  #      bridge.dependency 'FBTransition'
  #      bridge.dependency 'FBBridge/Base'
  #      bridge.dependency 'FBHud'
  #    end
  #  end
  
  spec.subspec 'Video' do |video|
    
    video.subspec 'VM' do |vm|
      
      vm.source_files = "Code/FBBridge/Video/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'FBApi'
      vm.dependency 'FBRReq'
      vm.dependency 'FBResult'
      vm.dependency 'FBViewModel'
      vm.dependency 'FBError'
    end
    
    video.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/FBBridge/Video/Bridge/*.{swift}"
      bridge.dependency 'FBBridge/Video/VM'
      bridge.dependency 'FBTransition'
      bridge.dependency 'FBCache/Account'
      bridge.dependency 'FBBridge/Base'
      bridge.dependency 'FBHud'
    end
  end
  
end
