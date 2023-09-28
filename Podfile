# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Solinx_iOS_Code_Test' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Alamofire'
  pod 'CombineCocoa'
  pod 'Kingfisher'
  pod 'IQKeyboardManagerSwift'
  pod 'lottie-ios'
  pod 'SnapKit'
  pod 'NVActivityIndicatorView' , '~> 4.8.0'
  pod 'CRRefresh'
  pod 'RealmSwift'
  pod 'SwiftyJSON'
  # Pods for Solinx_iOS_Code
  pod 'Kingfisher'

  target 'Solinx_iOS_Code_TestTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Solinx_iOS_Code_TestUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
                  xcconfig_relative_path = "Pods/Target Support Files/#{target.name}/#{target.name}.#{config.name}.xcconfig"
                  file_path = Pathname.new(File.expand_path(xcconfig_relative_path))
                  next unless File.file?(file_path)
                  configuration = Xcodeproj::Config.new(file_path)
                  next if configuration.attributes['LIBRARY_SEARCH_PATHS'].nil?
                  configuration.attributes['LIBRARY_SEARCH_PATHS'].sub! 'DT_TOOLCHAIN_DIR', 'TOOLCHAIN_DIR'
                  configuration.save_as(file_path)
               end
          end
   end
end



