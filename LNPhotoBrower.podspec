#
# Be sure to run `pod lib lint LNPhotoBrower-master.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LNPhotoBrower'
  s.version          = '0.0.1'
  s.summary          = 'a photo brower for iOS,Objective-C'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  a photo brower for iOS,support delegate,simble and easy to use
  
                       DESC

  s.homepage         = 'https://github.com/lengain/LNPhotoBrower-master'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lengain' => 'lengain@qq.com' }
  s.source           = { :git => 'https://github.com/lengain/LNPhotoBrower-master.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LNPhotoBrower-master/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LNPhotoBrower-master' => ['LNPhotoBrower-master/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'SDWebImage'
end
