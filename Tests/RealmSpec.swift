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
