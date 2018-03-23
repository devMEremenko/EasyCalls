# Copyright (c) 2018 Maxim Eremenko <devmeremenko@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.



Pod::Spec.new do |s|

    s.name                  = 'EasyCalls'
    s.version               = '1.2.0'
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
