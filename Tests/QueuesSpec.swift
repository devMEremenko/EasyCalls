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

class QueuesSpec: QuickSpec {
    
    override func spec() {
        
        testMain()
        testBackground()
        testAfter()
    }
}

//MARK: Main

extension QueuesSpec {
    
    func testMain() {
        
        it("The operation should be completed on the main thread") {
            
            waitUntil(timeout: 20, action: { done in
                DispatchQueue(label: "").async {
                    toMain {
                        DispatchQueue(label: "").sync {
                            toMain {
                                self.expectMain(done)
                            }
                        }
                    }
                }
            })
        }
        
        it("The operation should be completed on the main after recursive call") {
            waitUntil { done in
                DispatchQueue(label: "").sync {
                    toMain {
                        toMain {
                            self.expectMain(done)
                        }
                    }
                }
            }
        }
    }
}

//MARK: Background

extension QueuesSpec {
    
    func testBackground() {
        
        describe("Background") {
            
            it("1. The operation should NOT be completed on the Main thread", closure: {
                
                waitUntil { done in
                    toBackground {
                        self.expectBackground(done)
                    }
                }
            })
            
            it("2. The operation should NOT be completed on the Main thread", closure: {
                
                waitUntil { done in
                    toBackground(label: "", qos: .userInteractive, {
                        self.expectBackground(done)
                    })
                }
            })
        }
    }
}

//MARK: After

extension QueuesSpec {
    
    func testAfter() {
        
        describe("After") {
            
            it("The block should be called late on the Main queue", closure: {
                waitUntil { done in
                    runAfter(time: 0.1, {
                        self.expectMain(done)
                    })
                }
            })
            
            it("The block should be called late with Background QoS", closure: {
                waitUntil { done in
                    runAfter(time: 0.2, qos: .background, {
                        self.expectBackground(done)
                    })
                }
            })
            
            it("The block should be called late on the Main queue", closure: {
                waitUntil { done in
                    runAfter(time: 0.3,
                             qos: .background,
                             attr: .concurrent,
                             frequency: .inherit,
                             target: DispatchQueue.main, {
                        self.expectMain(done)
                    })
                }
            })
        }
    }
}
