

Pod::Spec.new do |s|

  s.name                = "TextFieldAnimation"
  s.version             = "1.0.0"
  s.summary             = "Text field animation provide custom animation to UITextField"
  s.description         = "Using TextFieldAnimation framework, you can add custom leftView and rightView image, append pending, animate the placeholder with custom color and font family, add action in leftView and rightView"

  s.homepage            = "https://github.com/AghaShahriyar"
  s.license             = "MIT"
  s.author              = { "Agha Shahriyar" => "aghaf13@yahoo.com" }
  s.platform            = :ios, "12.0"
  s.source               
  
  s.source              = { :git => "https://github.com/AghaShahriyar/TextFieldAnimation.git", :tag => "1.0.0" }
  s.source_files        = "TextFieldAnimation"
  s.swift_version       = "5"

end


