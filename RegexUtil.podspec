Pod::Spec.new do |s|
  s.name             = 'RegexUtil'
  s.version          = '1.1'
  s.license          = 'MIT'
  s.summary          = 'RegexUtil'
  s.homepage         = 'https://github.com/bmichotte/RegexUtil'
  s.authors          = { 'Benjamin Michotte' => 'bmichotte@gmail.com' }
  s.source           = { :git => 'https://github.com/bmichotte/RegexUtil.git' }

  s.platform = :osx
  s.osx.deployment_target = '10.10'
  s.framework = 'Foundation'

  s.source_files = 'Sources/**/*.swift'
  s.requires_arc = true
end
