
Pod::Spec.new do |s|
  s.name             = 'SmartCallingSDK'
  s.version          = '1.6.1'
  s.summary          = 'Use this library to add SmartCalling functionality to your iOS application.'
  s.description      = <<-DESC
    Using the SmartCalling SDK let's you add a contact to the iOS AddressBook so users of your app can know when they receive a call from a valid call from your company
                       DESC
  s.homepage         = 'https://github.com/Smartcalling/SmartCalling-iOS'
  s.license          = { :type => 'Commercial', :file => 'LICENSE' }
  s.author           = { 'SmartCom' => 'cj@smartcalling.co.uk' }
  s.source           = { :http => 'https://github.com/Smartcalling/SmartCalling-iOS/releases/download/1.6.1/SmartCalling.zip' }
  s.ios.deployment_target = '12.0'

  s.ios.vendored_frameworks = 'SmartCalling.xcframework'

end
