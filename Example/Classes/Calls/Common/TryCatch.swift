//
//  TryCatch.swift
//  EasyCalls
//
//  Created by Maxim Eremenko on 3/2/18.
//  Copyright © 2018 Maxim Eremenko. All rights reserved.
//

import Foundation

typealias ThrowableClosure = () throws -> ()

func tryCatch(_ closure: ThrowableClosure,
              _ failure: ErrorClosure? = nil) {
    do {
        try closure()
    } catch let error {
        failure?(error)
    }
}
