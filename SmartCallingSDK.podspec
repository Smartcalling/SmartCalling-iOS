
Pod::Spec.new do |s|
  s.name             = 'SmartCallingSDK'
  s.version          = '1.2.0'
  s.summary          = 'Use this library to add SmartCalling functionality to your iOS application.'
  s.description      = <<-DESC
    Using the SmartCalling SDK let's you add a contact to the iOS AddressBook so users of your app can know when you recive a call from
                       DESC
  s.homepage         = 'https://github.com/Smartcalling/SmartCalling-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SmartCom' => 'cj@smartcalling.co.uk' }
  s.source           = { :git => 'https://github.com/Smartcalling/SmartCalling-iOS.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'

  s.ios.vendored_frameworks = 'SmartCalling.xcframework'

end
