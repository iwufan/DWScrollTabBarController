Pod::Spec.new do |s|
  s.name	= 'DWScrollTabBarController'
  s.version	= '1.0.1'
  s.summary	= 'A scrollable tabBar with dynamic items. Each item shows a specific view.'
  s.homepage	= 'https://github.com/iwufan/DWScrollTabBarController'
  s.license	= 'MIT'
  s.platform	= :ios
  s.author 	= {'jiadawei' => 'jiadawei80@126.com'}
  s.ios.deployment_target = '8.0'
  s.source	= {:git => 'https://github.com/iwufan/DWScrollTabBarController.git', :tag => s.version}
  s.source_files = 'DWScrollTabBarControllerDemo/DWScrollTabBarControllerDemo/DWScrollTabBarController/*.{h,m}'
  s.requires_arc = true
  s.frameworks	= 'UIKit'
end
