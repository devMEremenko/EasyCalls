
Pod::Spec.new do |s|

    s.name                  = 'EasyCalls'
    s.version               = '1.0.0'
    s.summary               = 'Syntax sugar for Swift API'
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
    s.source_files          = 'Classes/Calls/{Common}**/*.{h,m}'
    s.pod_target_xcconfig   = { 'SWIFT_WHOLE_MODULE_OPTIMIZATION' => 'YES' }

    s.subspec 'Queues' do |queues|
        queues.source_files = 'Classes/Calls/{Queues}/**/*.{h,m}'
    end

    s.subspec 'Realm' do |realm|
        realm.source_files = 'Classes/Calls/{Realm}/**/*.{h,m}'
        realm.dependency 'RealmSwift', '~> 3.1.1'
    end

    s.frameworks = 'Foundation'
end
