//
//  AlertSpec.swift
//  EasyCalls_Tests
//
//  Created by Maxim Eremenko on 3/13/18.
//  Copyright © Maxim Eremenko. All rights reserved.
//

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
