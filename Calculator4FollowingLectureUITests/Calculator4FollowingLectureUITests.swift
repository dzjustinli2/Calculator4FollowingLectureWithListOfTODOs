//
//  Calculator4FollowingLectureUITests.swift
//  Calculator4FollowingLectureUITests
//
//  Created by justin on 10/07/2016.
//  Copyright © 2016 justin. All rights reserved.
//

import XCTest


class Calculator4FollowingLectureUITests: XCTestCase {
    
    
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCUIDevice.sharedDevice().orientation = .LandscapeRight
        
        let app = XCUIApplication()
        app.buttons["7"].tap()
        let plusButton = app.buttons["+"]
        plusButton.tap()
        app.buttons["8"].tap()
        let equalButton = app.buttons["="]
        equalButton.tap()
        
    }
    
    func testEverything(){
        
        let app = XCUIApplication()
        let button = app.buttons["7"]
        button.tap()
        
        let button2 = app.buttons["+"]
        button2.tap()
        app.buttons["5"].tap()
        
        let button3 = app.buttons["="]
        button3.tap()
        button2.tap()
        app.buttons["6"].tap()
        button3.tap()
        button2.tap()
        button.tap()
        button3.tap()
        app.buttons["√"].tap()
        app.buttons["1/x"].tap()
        button2.tap()
        app.buttons["1"].tap()
        app.buttons["."].tap()
        app.buttons["8"].tap()
        button3.tap()
        app.buttons["10ⁿ"].tap()
        app.buttons["AC"].tap()
        app.buttons["e"].tap()
        app.buttons["xⁿ"].tap()
        app.buttons["π"].tap()
        button3.tap()
        button3.tap()
        button3.tap()
        
    }
    
}
