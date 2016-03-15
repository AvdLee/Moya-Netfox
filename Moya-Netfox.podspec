Pod::Spec.new do |s|
  s.name             = "Moya-Netfox"
  s.version          = "1.0.0"
  s.summary          = "Contains a plugin for Moya to record calls into Netfox."
  s.description      = "Contains a plugin for Moya to record calls into Netfox. Custom Netfox branch is needed."

  s.homepage         = "https://github.com/AvdLee/Moya-Netfox"
  s.license          = 'MIT'
  s.author           = { "Antoine van der Lee" => "info@avanderlee.com" }
  s.source           = { :git => "https://github.com/AvdLee/Moya-Netfox.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Source/**/*'
  s.dependency 'Moya'

end
