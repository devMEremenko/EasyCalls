//
//  TryCatchSpec.swift
//  EasyCalls
//
//  Created by Maxim Eremenko on 3/2/18.
//  Copyright © 2018 Maxim Eremenko. All rights reserved.
//

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
