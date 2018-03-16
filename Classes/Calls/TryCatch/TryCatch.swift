//
//  TryCatch.swift
//  EasyCalls
//
//  Created by Maxim Eremenko on 3/2/18.
//  Copyright © 2018 Maxim Eremenko. All rights reserved.
//

import Foundation

public typealias ThrowableClosure = () throws -> ()
public typealias ErrorClosure = (Swift.Error) -> ()

public func tryCatch(_ closure: ThrowableClosure,
                     _ failure: ErrorClosure? = nil) {
    do {
        try closure()
    } catch let error {
        failure?(error)
    }
}

public extension Optional where Wrapped == Error {
    
    var isExist: Bool {
        return self != nil
    }
    
    var isNil: Bool {
        return self == nil
    }
}
