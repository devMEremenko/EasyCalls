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
