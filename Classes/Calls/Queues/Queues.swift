//
//  DispatchQueue.swift
//  EasyCalls
//
//  Created by Maxim Eremenko on 3/2/18.
//  Copyright © 2018 Maxim Eremenko. All rights reserved.
//

import Foundation

typealias EmptyClosure = () -> ()

private let mainQueueKey = DispatchSpecificKey<String>()
private let mainQueueValue = "DispatchSpecificKey.mainQueueValue"

//MARK: Main

extension DispatchQueue {
    
    static var isMainQueue: Bool {
        return DispatchQueue.getSpecific(key: mainQueueKey) != nil
    }
}

func toMain(_ block: @escaping EmptyClosure) {
    
    /**
        Being on the main thread does not guarantee to be in the main queue.
        It means, if the current queue is not main, the execution will be moved to the main queue.
     **/
    
    DispatchQueue.main.setSpecific(key: mainQueueKey, value: mainQueueValue)
    
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

//MARK: - Background

func toBackground(qos: DispatchQoS = .default,
                  _ block: @escaping EmptyClosure) {
    
    toBackground(label: "",
                 qos: qos,
                 attr: .concurrent,
                 frequency: .inherit,
                 target: nil,
                 block)
}

func toBackground(label: String = "",
                  qos: DispatchQoS = .default,
                  attr: DispatchQueue.Attributes = .concurrent,
                  frequency: DispatchQueue.AutoreleaseFrequency = .inherit,
                  target: DispatchQueue? = nil,
                  _ block: @escaping EmptyClosure) {
    
    DispatchQueue(label: label,
                  qos: qos,
                  attributes: attr,
                  autoreleaseFrequency: frequency,
                  target: target).async {
        block()
    }
}

//MARK: - After

func runAfter(time: Double,
              _ block: @escaping EmptyClosure) {
    
    let deadline = DispatchTime.now() + time
    DispatchQueue.main.asyncAfter(deadline: deadline, execute: block)
}

func runAfter(time: Double,
              qos: DispatchQoS,
              attr: DispatchQueue.Attributes = .concurrent,
              frequency: DispatchQueue.AutoreleaseFrequency = .inherit,
              target: DispatchQueue? = nil,
              _ block: @escaping EmptyClosure) {
    
    let deadline = DispatchTime.now() + time
    DispatchQueue(label: "",
                  qos: qos,
                  attributes: attr,
                  autoreleaseFrequency: frequency,
                  target: target).asyncAfter(deadline: deadline, execute: block)
}
