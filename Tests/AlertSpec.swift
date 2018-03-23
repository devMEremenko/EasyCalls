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

class AlertSpec: QuickSpec {
    
    override func spec() {
        testConfiguration()
        testAction()
    }
}

extension AlertSpec {
    
    func testConfiguration() {
        
        describe("Configuration") {
            
            it("Defaults should be set correctly", closure: {
                expect(Configuration.ok).to(equal("OK"))
                expect(Configuration.cancel).to(equal("Cancel"))
                expect(Configuration.Alert.style).to(equal(UIAlertControllerStyle.alert))
                expect(Configuration.Action.defaultStyle).to(equal(UIAlertActionStyle.default))
                expect(Configuration.Action.cancelStyle).to(equal(UIAlertActionStyle.cancel))
            })
        }
    }
}

extension AlertSpec {
    
    func testAction() {
        
        describe("Action") {
            
            describe("ok", {
                
                it("`ok` should be created correctly", closure: {
                    let action = Action.ok
                    expect(action.title).to(equal(Configuration.ok))
                    expect(action.style).to(equal(Configuration.Action.defaultStyle))
                })
                
                it("`ok` with handler should be created correctly", closure: {
                    let action = Action.ok({ _ in })
                    expect(action.title).to(equal(Configuration.ok))
                    expect(action.style).to(equal(Configuration.Action.defaultStyle))
                })
            })
            
            describe("cancel", {
                
                it("`cancel` should be created correctly", closure: {
                    let action = Action.cancel
                    expect(action.title).to(equal(Configuration.cancel))
                    expect(action.style).to(equal(UIAlertActionStyle.cancel))
                })
                
                it("`cancel` with handler should be created correctly", closure: {
                    let action = Action.cancel({ _ in })
                    expect(action.title).to(equal(Configuration.cancel))
                    expect(action.style).to(equal(UIAlertActionStyle.cancel))
                })
            })
            
            describe("with", {
                
                it("`with` should be created correctly", closure: {
                    
                    let title = "Custom Title"
                    let style = UIAlertActionStyle.destructive
                    
                    let action = Action.with(title: title, style: style, { _ in })
                    expect(action.title).to(equal(title))
                    expect(action.style).to(equal(style))
                })
            })
        }
    }
}
