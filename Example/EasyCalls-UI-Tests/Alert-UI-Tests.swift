//
//  Alert-UI-Tests.swift
//  EasyCalls
//
//  Created by Maxim Eremenko on 3/13/18.
//  Copyright © Maxim Eremenko. All rights reserved.
//

import XCTest

class EasyCalls_UI_Tests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testSimpleAlert() {
        
        let app = XCUIApplication()
        app.buttons["Simple alert"].tap()
        app.alerts["Simple Alert"].buttons["OK"].tap()        
    }
    
    func testComplexAlert() {
        
        let app = XCUIApplication()
        app.buttons["Complex alert"].tap()
        app.alerts["More complex alert"].buttons["OK"].tap()
        
        app.buttons["Complex alert"].tap()
        app.alerts["More complex alert"].buttons["Cancel"].tap()
    }
    
    func testCustomAlert() {
        
        let app = XCUIApplication()
        app.buttons["Custom Alert"].tap()
        app.alerts["Custom"].buttons["Custom Action"].tap()
    }
    
    func testActionSheet() {
        
        let app = XCUIApplication()
        app.buttons["Action Sheet"].tap()
        app.sheets["Custom"].buttons["OK"].tap()
    }
    
    func testOwnAlert() {
        
        let app = XCUIApplication()
        app.buttons["Show your own alert"].tap()
        app.alerts["Alert"].buttons["OK"].tap()
    }
}
