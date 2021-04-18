# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'TranslationCards' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for TranslationCards
  
  # Rx
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxFirebase/Firestore'
  pod 'RxFirebase/RemoteConfig'
  pod 'RxFirebase/Storage'
  pod 'RxFirebase/Auth'
  pod 'RxFirebase/Functions'
  pod 'RxDataSources'
  pod 'RxKeyboard'
  pod 'RxAlamofire'
  
  # Firebase
  pod 'Firebase/Analytics'

  # UIViews
  pod 'JJFloatingActionButton', '2.1.0'
  pod 'NVActivityIndicatorView', '4.8.0'
  pod 'RSSelectionMenu', '6.1.0'
  
  # UI
  pod 'SnapKit', '~>5.0.0'

end

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
  end
 end
end
