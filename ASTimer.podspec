#
# Be sure to run `pod lib lint ASTimer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ASTimer"
  s.version          = "0.1.3"
  s.summary          = "ASTimer is a convinient timer that will observe NSNotificationCenter noticaitons so it can readjust accordingly."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
ASTimer was created to add a convinient way to manage NSTimers that need to persist over background to foreground state changes or other arbitrarly NSNotificationCenter notifications. You will be able to set the initial start time for the timer, a completion block, and listen to NSNotificationCenter notifications to pasuse/resume the timer.
                       DESC

  s.homepage         = "https://github.com/asowers1/ASTimer"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'WTFPL'
  s.author           = { "asowers1" => "asow123@gmail.com" }
  s.source           = { :git => "https://github.com/asowers1/ASTimer.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/andrewsowers'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'ASTimer' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
