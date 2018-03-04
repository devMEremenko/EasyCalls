
Pod::Spec.new do |s|

    s.name                  = 'EasyCalls'
    s.version               = '1.0.1'
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
    s.pod_target_xcconfig   = { 'SWIFT_WHOLE_MODULE_OPTIMIZATION' => 'YES',
                                'SWIFT_VERSION' => '4.0'}

    s.subspec 'Common' do |common|
        common.source_files = 'Classes/Calls/Common**/*.swift'
    end

    s.subspec 'Queues' do |queues|
        queues.source_files = 'Classes/Calls/Queues/**/*.swift'
    end

    s.default_subspec = "Common", "Queues"

    s.subspec 'Realm' do |realm|
        realm.dependency 'EasyCalls/Common'
        realm.dependency 'RealmSwift', '~> 3.1.1'
        realm.source_files = 'Classes/Calls/Realm/**/*.swift',
    end

    s.frameworks = 'Foundation'
end
