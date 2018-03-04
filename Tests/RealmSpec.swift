//
//  RealmSpec.swift
//  EasyCalls
//
//  Created by Maxim Eremenko on 3/3/18.
//  Copyright © 2018 Maxim Eremenko. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RealmSwift

class RealmSpec: QuickSpec {
    
    override func spec() {
        testTransactions()
    }
}

extension RealmSpec {
    
    func testTransactions() {
        
        describe("Write transaction") {
            
            it("Should return a realm instance in the write transaction", closure: {
                
                Realm.write(transaction: { realm in
                    expect(realm).notTo(beNil())
                    expect(realm.isInWriteTransaction).to(beTrue())
                }, { error in
                    assertionFailure("The error block should not be called")
                })
            })
        }
        
        describe("Read transaction") {
            
            it("Should return a realm instance to read", closure: {
                
                Realm.read(transaction: { realm in
                    expect(realm).notTo(beNil())
                }, { error in
                    assertionFailure("The error block should not be called")
                })
            })
        }
    }
}
