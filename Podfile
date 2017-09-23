# Uncomment the next line to define a global platform for your project
#platform :ios, ’10.3’

target 'All Weather' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Alamofire', '~> 4.5'
  pod 'AlamofireImage', '~> 3.3'
  pod 'ReactiveSwift', '~> 2.0'
  pod 'ReactiveCocoa', '~> 6.0.2'
  pod 'SwiftLint'

  # Pods for All Weather
  post_install do |installer|
      # Your list of targets here.
      myTargets = ['ReactiveCocoa']
      
      installer.pods_project.targets.each do |target|
          if myTargets.include? target.name
              target.build_configurations.each do |config|
                  config.build_settings['SWIFT_VERSION'] = '3.2'
              end
          end
      end
  end
  end


