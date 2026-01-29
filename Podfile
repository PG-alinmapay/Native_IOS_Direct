platform :ios, '13.0'

target 'DemoApp' do
  use_frameworks!

  # Local plugin
  pod 'direct-ios-plugin',
      :path => '/Users/riyasrazak/Documents/concerto/SDK/IOSNativeDirect/direct-ios-plugin'

  # Other pods
  pod 'SwiftyMenu', '~> 1.1'
  pod 'iOSDropDown'
  pod 'SwiftPublicIP', '~> 0.0.2'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
