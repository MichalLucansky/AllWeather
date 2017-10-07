# Uncomment the next line to define a global platform for your project
platform :ios, ’10.0’

target 'All Weather' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Alamofire', '~> 4.5.1'
  pod 'AlamofireImage', '~> 3.3.0'
  pod 'ReactiveSwift', '~> 2.0.0'
  pod 'ReactiveCocoa', '~> 6.0.0'
  pod 'ObjectMapper', '~> 3.0.0' 
  pod 'SwiftLint'


  end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.2'
        end
    end
end

