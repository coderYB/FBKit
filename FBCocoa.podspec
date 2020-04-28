Pod::Spec.new do |spec|
  
  spec.name         = "FBCocoa"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For rxcocoa."
  spec.description  = <<-DESC
  FBCocoa是rxcocoa封装
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
  
  spec.subspec 'Button' do |button|
    button.source_files = "Code/FBCocoa/Button/*.{swift}"
    button.dependency 'RxCocoa'
  end
  
  spec.subspec 'Refresh' do |refresh|
    refresh.source_files = "Code/FBCocoa/Refresh/*.{swift}"
    refresh.dependency 'RxCocoa'
    refresh.dependency 'MJRefresh'
  end
  spec.subspec 'SM' do |sm|
    sm.source_files = "Code/FBCocoa/SM/*.{swift}"
    sm.dependency 'RxDataSources'
  end
  spec.subspec 'ASM' do |asm|
    asm.source_files = "Code/FBCocoa/ASM/*.{swift}"
    asm.dependency 'RxDataSources'
  end
end
