#
# Be sure to run `pod lib lint VertigoX.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'VertigoX'
  s.version          = '0.3.6'
  s.summary          = 'A Swift ToolKit to help create clean, scalable and efficient apps'
  s.swift_version    = '5.0'
 
  s.homepage         = 'https://github.com/waruss321/VertigoX'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'waruss321' => 'russellwarwick1998@gmail.com' }
  s.source           = { :git => 'https://github.com/waruss321/VertigoX.git', :branch => "master", :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'Source/**/*'
  
  s.dependency 'PanModal'
  s.dependency 'IGListKit', '~> 4.0.0'
  s.dependency 'Signals', '~> 6.0'
  
end
