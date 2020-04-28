Pod::Spec.new do |spec|
  
  spec.name         = "FBYY"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For yycahce."
  spec.description  = <<-DESC
  FBYY是yycach的封装
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
  
  spec.vendored_frameworks = 'Framework/FBYY/FBYY.framework'
  
  spec.dependency 'YYCache'
  
end