/*
 Copyright (c) 2018 Maxim Eremenko <devmeremenko@gmail.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
*/

import Foundation

public typealias Empty = () -> ()

private let mainQueueValue = "DispatchSpecificKey.mainQueueValue"

private let mainQueueKey: DispatchSpecificKey<String> = {
    /// It will be set only once
    let key = DispatchSpecificKey<String>()
    DispatchQueue.main.setSpecific(key: key, value: mainQueueValue)
    return key
}()


//MARK: Main

public extension DispatchQueue {
    
    static var isMainQueue: Bool {
        return DispatchQueue.getSpecific(key: mainQueueKey) != nil
    }
}

public extension DispatchQueue {
    
    static func toMain(_ block: @escaping Empty) {
        
        /**
         Being on the main thread does not guarantee to be on the main queue.
         It means, if the current queue is not main, the execution will be moved to the main queue.
         
         Check out more info at https://github.com/devMEremenko/EasyCalls#dispatchqueuetomain-
         **/
        
        if DispatchQueue.isMainQueue {
            block()
        } else {
            if Thread.isMainThread {
                DispatchQueue.main.async {
                    block()
                }
            } else {
                // Execution is not on the main queue and thread at this point.
                // The sync operation will not block any.
                
                // It is important to perform an operation synchronously.
                // Otherwise, it can cause a race condition.
                DispatchQueue.main.sync {
                    block()
                }
            }
        }
    }
}

public extension DispatchQueue {
    
    static func toBackground(qos: DispatchQoS = .default,
                             _ block: @escaping Empty) {
        
        toBackground(label: "",
                     qos: qos,
                     attr: .concurrent,
                     frequency: .inherit,
                     target: nil,
                     block)
    }
    
    static func toBackground(label: String = "",
                             qos: DispatchQoS = .default,
                             attr: DispatchQueue.Attributes = .concurrent,
                             frequency: DispatchQueue.AutoreleaseFrequency = .inherit,
                             target: DispatchQueue? = nil,
                             _ block: @escaping Empty) {
        
        DispatchQueue(label: label,
                      qos: qos,
                      attributes: attr,
                      autoreleaseFrequency: frequency,
                      target: target).async {
                        block()
        }
    }
    
    //MARK: - After
    
    static func runAfter(time: Double, _ block: @escaping Empty) {
        
        let deadline = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: deadline, execute: block)
    }
    
    static func runAfter(time: Double,
                         qos: DispatchQoS,
                         attr: DispatchQueue.Attributes = .concurrent,
                         frequency: DispatchQueue.AutoreleaseFrequency = .inherit,
                         target: DispatchQueue? = nil,
                         _ block: @escaping Empty) {
        
        let deadline = DispatchTime.now() + time
        DispatchQueue(label: "",
                      qos: qos,
                      attributes: attr,
                      autoreleaseFrequency: frequency,
                      target: target).asyncAfter(deadline: deadline, execute: block)
    }
}
