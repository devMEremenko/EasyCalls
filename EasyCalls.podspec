
Pod::Spec.new do |s|

    s.name                  = 'EasyCalls'
    s.version               = '1.1.0'
    s.summary               = 'This repository contains a number of methods over Swift API to use it safely.'
    s.description           = <<-DESC
        The pod simplifies using Swift API.
        It includes changing DispatchQueue and errors handing now.
                       DESC

    s.homepage              = 'https://github.com/devmeremenko/EasyCalls'
    s.license               = { :type => 'MIT', :file => 'LICENSE' }
    s.author                = { 'Maxim Eremenko' => 'devmeremenko@gmail.com' }
    s.source                = { :git => 'https://github.com/devmeremenko/EasyCalls.git' }
    s.social_media_url      = 'https://twitter.com/eremenko_maxim/'
    s.ios.deployment_target = '8.0'
    s.pod_target_xcconfig   = { 'SWIFT_WHOLE_MODULE_OPTIMIZATION' => 'YES',
                                'SWIFT_VERSION' => '4.0'}

    s.subspec 'Alert' do |alert|
        alert.source_files = 'Classes/Calls/Alert/**/*.swift'
        alert.dependency 'EasyCalls/Queues'
        alert.frameworks = 'Foundation', 'UIKit'
    end

    s.subspec 'Queues' do |queues|
        queues.source_files = 'Classes/Calls/Queues/**/*.swift'
    end

    s.default_subspec = "TryCatch", "Queues"

    s.subspec 'Realm' do |realm|
        realm.dependency 'EasyCalls/TryCatch'
        realm.dependency 'RealmSwift', '~> 3.1.1'
        realm.source_files = 'Classes/Calls/Realm/**/*.swift'
    end

    s.subspec 'TryCatch' do |tryCatch|
        tryCatch.source_files = 'Classes/Calls/TryCatch**/*.swift'
    end

    s.frameworks = 'Foundation'
end
