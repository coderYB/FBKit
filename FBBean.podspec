
Pod::Spec.new do |spec|
  
  spec.name         = "FBBean"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For Bean."
  spec.description  = <<-DESC
  FBBean是所有模型的封装
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
  
  spec.dependency 'ObjectMapper'
  
  spec.subspec 'Gender' do |gender|
    gender.source_files = "Code/FBBean/Gender/*.{swift}"
  end
  
  spec.subspec 'Account' do |account|
    account.source_files = "Code/FBBean/Account/*.{swift}"
  end
  
  spec.subspec 'User' do |user|
    user.source_files = "Code/FBBean/User/*.{swift}"
    user.dependency 'FBBean/Gender'
  end
  spec.subspec 'Black' do |black|
    black.source_files = "Code/FBBean/Black/*.{swift}"
    black.dependency 'FBBean/User'
    black.dependency 'RxDataSources'
  end
  spec.subspec 'Focus' do |focus|
    focus.source_files = "Code/FBBean/Focus/*.{swift}"
    focus.dependency 'FBBean/User'
    focus.dependency 'RxDataSources'
  end
  
  spec.subspec 'KeyValue' do |keyValue|
    keyValue.source_files = "Code/FBBean/KeyValue/*.{swift}"
    keyValue.dependency 'RxDataSources'
  end
  
  spec.subspec 'Circle' do |circle|
    circle.source_files = "Code/FBBean/Circle/*.{swift}"
    circle.dependency 'FBBean/KeyValue'
    circle.dependency 'FBBean/User'
    circle.dependency 'WLToolsKit/JsonCast'
  end
  
  spec.subspec 'Commodity' do |commodity|
    commodity.source_files = "Code/FBBean/Commodity/*.{swift}"
    commodity.dependency 'FBBean/KeyValue'
    commodity.dependency 'FBBean/User'
    commodity.dependency 'WLToolsKit/JsonCast'
  end
  spec.subspec 'Comment' do |comment|
    comment.source_files = "Code/FBBean/Comment/*.{swift}"
    comment.dependency 'FBBean/User'
    comment.dependency 'RxDataSources'
  end
  
  spec.subspec 'Area' do |area|
    area.source_files = "Code/FBBean/Area/*.{swift}"
    area.dependency 'RxDataSources'
  end
  
  spec.subspec 'Address' do |address|
    address.source_files = "Code/FBBean/Address/*.{swift}"
    address.dependency 'RxDataSources'
  end
  spec.subspec 'Message' do |message|
     message.source_files = "Code/FBBean/Message/*.{swift}"
     message.dependency 'RxDataSources'
   end
  
end
