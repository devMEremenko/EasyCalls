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

fileprivate enum NetworkError: Error {
    case general
}

class TryCatchSpec: QuickSpec {
    
    override func spec() {
        testTryCatch()
        testOptionals()
    }
}

//MARK: - Try Catch

fileprivate extension TryCatchSpec {
    
    func testTryCatch() {
        
        it("The exception should be caught") {
            
            tryCatch({
                throw NetworkError.general
            }, { error in
                expect(error).notTo(beNil())
            })
        }
        
        it("The exception should be nil") {
            
            tryCatch({
                
            }, { error in
                expect(error).to(beNil())
            })
        }
        
        it("The execution should not be interrupted by an exception") {
            
            let block: ThrowableClosure = {
                
                tryCatch({
                    throw NetworkError.general
                })
            }
            
            expect(block).notTo(throwError())
        }
    }
}

extension TryCatchSpec {
    
    func testOptionals() {
        
        describe("isExist") {
            
            it("Should return `true` when an error exists") {
                
                let error: Error? = NetworkError.general
                expect(error.isExist).to(beTrue())
            }
            
            it("Should return `false` when an error exists") {
                
                let error: Error? = nil
                expect(error.isExist).to(beFalse())
            }
        }
        
        describe("isNil") {
            
            it("Should return `false` when an error exists") {
                
                let error: Error? = NetworkError.general
                expect(error.isNil).to(beFalse())
            }
            
            it("Should return `true` when an error exists") {
                
                let error: Error? = nil
                expect(error.isNil).to(beTrue())
            }
        }
    }
}
