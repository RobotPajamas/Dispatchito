Pod::Spec.new do |s|
  s.name             = 'Dispatchito'
  s.version          = '0.1.0'
  s.summary          = ''
  s.description      = <<-DESC
                       DESC

  s.homepage         = 'https://github.com/RobotPajamas/Dispatchito'
  s.license          = { :type => 'Apache', :file => 'LICENSE' }
  s.authors          = ['sureshjoshi']
  s.source           = { :git => 'https://github.com/RobotPajamas/SwiftyTeeth.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.3'

  s.source_files = 'Sources/**/*'

  s.frameworks = ''
end
