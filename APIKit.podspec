#
# Be sure to run `pod lib lint APIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'APIKit'
  s.version          = '0.0.3'
  s.summary          = 'A short description of APIKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/forestfsl/APIKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'forestfsl' => 'fengsonglin@beiyugame.com' }
  s.source           = { :git => 'https://github.com/forestfsl/APIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'APIKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'APIKit' => ['APIKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

  s.dependency 'SLCategory', '~> 0.0.1'
  s.dependency 'SLWebEngine','~> 0.0.6'
  s.dependency 'CTMediatoKit','~> 0.0.4'
  s.dependency 'AppStoreKit', '~> 0.0.1'
  s.dependency 'SegmentView', '~> 0.0.2'
  s.dependency 'IQKeyboardManager'
end
