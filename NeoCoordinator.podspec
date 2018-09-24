#
# Be sure to run `pod lib lint Coordinator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NeoCoordinator'
  s.version          = '0.3.9'
  s.summary          = 'A coordinator implementation to easilly use it.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A coordinator implementation to easilly use it. A Coordinator is an object the encapsulates a lifecycle that is spread over a collection of view controllers.
                       DESC

  s.homepage         = 'https://github.com/XavierDK/Coordinator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'XavierDK' => 'xavier.dekoninck@gmail.com' }
  s.source           = { :git => 'https://github.com/XavierDK/Coordinator.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Coordinator/**/*.{h,swift}'
  
  # s.resource_bundles = {
  #   'Coordinator' => ['Coordinator/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
