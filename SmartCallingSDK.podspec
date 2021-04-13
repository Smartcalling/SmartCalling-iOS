
Pod::Spec.new do |s|
  s.name             = 'SmartCallingSDK'
  s.version          = '1.5.0'
  s.summary          = 'Use this library to add SmartCalling functionality to your iOS application.'
  s.description      = <<-DESC
    Using the SmartCalling SDK let's you add a contact to the iOS AddressBook so users of your app can know when they receive a call from a valid call from your company
                       DESC
  s.homepage         = 'https://github.com/Smartcalling/SmartCalling-iOS'
  s.license          = { :type => 'Commercial', :file => 'LICENSE' }
  s.author           = { 'SmartCom' => 'cj@smartcalling.co.uk' }
  s.source           = { :git => 'https://github.com/Smartcalling/SmartCalling-iOS.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'

  s.ios.vendored_frameworks = 'SmartCalling.xcframework'

end
