#
# Be sure to run `pod lib lint RxCoordinator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxCoordinator'
  s.version          = '0.3.0'
  s.summary          = 'A Rx wrapper on Coordinator.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A coordinator implementation to easilly use it. A Coordinator is an object the encapsulates a lifecycle that is spread over a collection of view controllers.
RxCoordinator provide some methods for Rx implementation.
                       DESC

  s.homepage         = 'https://github.com/XavierDK/Coordinator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'XavierDK' => 'xavier.dekoninck@gmail.com' }
  s.source           = { :git => 'https://github.com/XavierDK/Coordinator.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'RxCoordinator/**/*'
  
  # s.resource_bundles = {
  #   'Coordinator' => ['RxCoordinator/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'NeoCoordinator', '~> 0.2.0'
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'Action'
  
end
