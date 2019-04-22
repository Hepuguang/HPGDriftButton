
Pod::Spec.new do |s|

 
  s.name         = "HPGDriftButton"
  s.version      = "0.0.1"
  s.summary      = "一个可以拖动的按钮"

  s.description  = <<-DESC
                    一个可以拖动的按钮一个可以拖动的按钮
                   DESC

  s.homepage     = "https://github.com/Hepuguang/HPGDriftButton.git"

  s.license      = "MIT"


  s.author             = { "何普光" => "389720037@qq.com" }


  s.platform     = :ios


  s.source       = { :git => "https://github.com/Hepuguang/HPGDriftButton.git", :tag => "#{s.version}" }


  s.source_files  = "DriftButton/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
