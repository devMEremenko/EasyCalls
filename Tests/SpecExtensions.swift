//
//  SpecExtensions.swift
//  EasyCalls
//
//  Created by Maxim Eremenko on 3/2/18.
//  Copyright © 2018 Maxim Eremenko. All rights reserved.
//

import Foundation
import Quick
import Nimble

extension QuickSpec {
    
    func expectMain(_ done: @escaping Empty) {
        
        let isMain = DispatchQueue.isMainQueue
        
        DispatchQueue.main.async {
            // The expect() should be executed on the main queue only
            expect(isMain).to(beTrue())
            done()
        }
    }
    
    func expectBackground(_ done: @escaping Empty) {
        
        let isMain = DispatchQueue.isMainQueue
        
        DispatchQueue.main.async {
            // The expect() should be executed on the main queue only
            expect(isMain).to(beFalse())
            done()
        }
    }
}

