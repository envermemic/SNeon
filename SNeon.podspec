
Pod::Spec.new do |spec|
 spec.name          = "SNeon"
 spec.version       = "1.0.0"
 spec.summary       = "Neon Extension"
 spec.description   = "SNeon is Neon extension"
 spec.homepage      = "https://github.com/envermemic"
 spec.license       = "MIT"
 spec.author        = { "Enver" => "enver.memic80@gmail.com" }
 spec.platform      = :ios, "11.2"
 spec.source        = { :git => "https://github.com/envermemic/SNeon.git" }
 spec.source_files  = "SNeon"
 
 spec.dependency 'MaterialComponents/Buttons'
 spec.dependency 'Neon'
end
