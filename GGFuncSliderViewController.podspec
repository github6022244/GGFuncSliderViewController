#
# Be sure to run `pod lib lint GGFuncSliderViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GGFuncSliderViewController'
  s.version          = '0.1.9'
  s.summary          = 'iOS 基于 JXCategoryView 封装的分类栏控制器'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/github6022244/GGFuncSliderViewController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '1563084860@qq.com' => '1563084860@qq.com' }
  s.source           = { :git => 'https://github.com/github6022244/GGFuncSliderViewController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'GGFuncSliderViewController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'GGFuncSliderViewController' => ['GGFuncSliderViewController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  #多控制器滑动
#  s.dependency 'JXPagingView/Pager'
#  s.dependency 'JXCategoryView'
  s.dependency 'JXPagingView/Pager', '2.1.2'
  s.dependency 'JXCategoryView', '1.6.1'
  s.dependency 'QMUIKit/QMUICore', '4.7.0'
end
