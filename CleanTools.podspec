Pod::Spec.new do |spec|
  spec.name         = "CleanTools"
  spec.version      = "1.0.0"
  spec.summary      = "Protocols and extensions designed to enhance your development productivity and code clarity."
  spec.description  = "SwiftCleanTools is a Swift framework packed with various utility protocols and extensions designed to enhance your development productivity and code clarity."
  spec.homepage     = "https://github.com/alegelos/SwiftCleanTools"
  spec.license      = "MIT"
  spec.author       = { "Alejandro Gelos" => "alegelos@gmail.com" }
  spec.source       = { :git => "https://github.com/alegelos/SwiftCleanTools.git", :tag => "#{1.0.0}" }
  spec.source_files  = "Sources", "Sources/CleanTools/"
  spec.exclude_files = "Classes/Exclude"
end
