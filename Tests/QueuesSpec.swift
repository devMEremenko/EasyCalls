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
                    DispatchQueue.toMain {
                        DispatchQueue(label: "").sync {
                            DispatchQueue.toMain {
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
                    DispatchQueue.toMain {
                        DispatchQueue.toMain {
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
                    DispatchQueue.toBackground {
                        self.expectBackground(done)
                    }
                }
            })
            
            it("2. The operation should NOT be completed on the Main thread", closure: {
                
                waitUntil { done in
                    DispatchQueue.toBackground(label: "", qos: .userInteractive, {
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
                    DispatchQueue.runAfter(time: 0.1, {
                        self.expectMain(done)
                    })
                }
            })
            
            it("The block should be called late with Background QoS", closure: {
                waitUntil { done in
                    DispatchQueue.runAfter(time: 0.2, qos: .background, {
                        self.expectBackground(done)
                    })
                }
            })
            
            it("The block should be called late on the Main queue", closure: {
                waitUntil { done in
                    DispatchQueue.runAfter(time: 0.3,
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
