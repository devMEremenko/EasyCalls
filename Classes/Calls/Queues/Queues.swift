//
//  DispatchQueue.swift
//  EasyCalls
//
//  Created by Maxim Eremenko on 3/2/18.
//  Copyright © 2018 Maxim Eremenko. All rights reserved.
//

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
