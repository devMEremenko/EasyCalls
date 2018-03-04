
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
    s.source                = { :git => 'https://github.com/devmeremenko/EasyCalls.git', :tag => s.version.to_s }
    s.social_media_url      = 'https://www.linkedin.com/in/maxim-eremenko/'
    s.ios.deployment_target = '8.0'
    s.source_files          = 'EasyCalls/Classes/{Common}**/*{swift}'
    s.pod_target_xcconfig   = { 'SWIFT_WHOLE_MODULE_OPTIMIZATION' => 'YES' }

    s.subspec 'Queues' do |queues|
        queues.source_files = 'EasyCalls/Classes/Calls/Queues/**/*.{swift}'
    end

    s.subspec 'Realm' do |realm|
        realm.source_files = 'EasyCalls/Classes/Calls/Realm/**/*.{swift}'
        realm.dependency 'RealmSwift'
    end

    s.frameworks = 'Foundation'
end
