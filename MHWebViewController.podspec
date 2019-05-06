Pod::Spec.new do |s|
  s.name  = 'MHWebViewController'
  s.version = '1.0.0'
  s.platform = :ios
  s.summary = 'An Instagram inspired Web View Controller.'
  s.homepage = 'https://github.com/michaelhenry/MHWebViewController'
  s.author = { 'Michael Henry Pantaleon' => 'me@iamkel.net' }
  s.source = {
    :git => 'https://github.com/michaelhenry/MHWebViewController.git',
    :tag => s.version.to_s
  }
  s.source_files = 'Sources/**/*'
  s.ios.deployment_target  = '9.0'
  s.frameworks = 'WebKit'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.swift_version = '4.2'
end