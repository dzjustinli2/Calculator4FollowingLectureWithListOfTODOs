//
//  Calculator4FollowingLectureWithListOfTODOsTests.swift
//  Calculator4FollowingLectureWithListOfTODOsTests
//
//  Created by justin on 20/07/2016.
//  Copyright © 2016 justin. All rights reserved.
//

import XCTest
@testable import Calculator4FollowingLectureWithListOfTODOs

class Calculator4FollowingLectureWithListOfTODOsTests: XCTestCase {
    
    var brain = CalculatorBrain()
    
    override func setUp() {
        super.setUp()
        brain = CalculatorBrain()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test1() {

        brain.setOperand(7)
        brain.performOperation("+")
        XCTAssertEqual(brain.isPartialResult, true)
        XCTAssertEqual(brain.result, 7)
        XCTAssertEqual(brain.description, "7 + ")
    }
    
    func test2(){
        brain.setOperand(7)
        brain.performOperation("+")
        brain.setOperand(9.12345678)
        brain.performOperation("=")
        
        XCTAssertFalse(brain.isPartialResult)
        XCTAssertEqualWithAccuracy(brain.result, 16.12345678, accuracy: 0.000001)
        XCTAssertEqual(brain.description, "7 + 9.123457")
    }
    
    func test7Plus9EqualSquareRoot(){
        brain.setOperand(21)
        brain.performOperation("-")
        brain.setOperand(2)
        brain.performOperation("=")
        brain.performOperation("√")
        
        XCTAssertFalse(brain.isPartialResult)
        XCTAssertEqual(brain.description, "√(21 - 2)")
        XCTAssertEqualWithAccuracy(brain.result, 4.358899, accuracy: 0.0000001)
    }
    
    func test7Plus9SqaureRoot(){
        brain.setOperand(2)
        brain.performOperation("×")
        brain.setOperand(0.2)
        brain.performOperation("√")
        
        XCTAssertTrue(brain.isPartialResult)
        XCTAssertEqual(brain.description, "2 × √(0.2)")
        XCTAssertEqualWithAccuracy(brain.result, 0.447214, accuracy: 0.000001)
    }
    
    func test7Plus9SquareRootEqual(){
        brain.setOperand(13.59)
        brain.performOperation("+")
        brain.setOperand(5.42)
        brain.performOperation("∛")
        brain.performOperation("=")
        
        XCTAssertFalse(brain.isPartialResult)
        XCTAssertEqual(brain.description, "13.59 + ∛(5.42)")
        XCTAssertEqualWithAccuracy(brain.result, 15.346574, accuracy: 0.000001)
    }
    
    func test7Plus9EqualPlus6Plus3Equal(){
        brain.setOperand(0.1)
        brain.performOperation("+")
        brain.setOperand(0.7)
        brain.performOperation("=")
        brain.performOperation("+")
        brain.setOperand(6.1)
        brain.performOperation("-")
        brain.setOperand(10.9)
        brain.performOperation("=")
        
        XCTAssertFalse(brain.isPartialResult)
        XCTAssertEqual(brain.description, "0.1 + 0.7 + 6.1 - 10.9")
        XCTAssertEqualWithAccuracy(brain.result, -4, accuracy: 0.000001)
        
    }
    
    func test7Plus9EqualSquareRoot6Plus3Equal(){
        brain.setOperand(0.1)
        brain.performOperation("+")
        brain.setOperand(0.7)
        brain.performOperation("=")
        brain.performOperation("√")
        brain.setOperand(6.1)
        brain.performOperation("-")
        brain.setOperand(10.9)
        brain.performOperation("=")
        
        XCTAssertFalse(brain.isPartialResult)
        XCTAssertEqual(brain.description, "6.1 - 10.9")
        XCTAssertEqualWithAccuracy(brain.result, -4.8, accuracy: 0.000001)
        
    }
    
    func test7PlusEqual(){
        brain.setOperand(7)
        brain.performOperation("×")
        brain.performOperation("=")
        
        XCTAssertFalse(brain.isPartialResult)
        XCTAssertEqual(brain.description, "7 × 7")
        XCTAssertEqual(brain.result, 49)
    }
    
    func test7Times9EqaulπEqual(){
        brain.setOperand(4)
        brain.performOperation("-")
        brain.setOperand(2)
        brain.performOperation("÷")
        brain.setOperand(5)
        brain.performOperation("=")
        
        XCTAssertFalse(brain.isPartialResult)
        XCTAssertEqual(brain.description, "4 - 2 ÷ 5")
        XCTAssertEqualWithAccuracy(brain.result, 0.4, accuracy: 0.000001)
        
    }
    
    func testClearBrain(){
        brain.setOperand(4)
        brain.performOperation("-")
        brain.setOperand(2)
        brain.performOperation("÷")
        brain.setOperand(5)
        brain.performOperation("=")
        brain.clearAndResetToDefault()
        
        XCTAssertFalse(brain.isPartialResult)
        XCTAssertEqual(brain.description, " ")
        XCTAssertEqual(brain.result, 0)
        
    }
    
    
    func testDoubleAccuracyThisTestIsUnrelatedToCalculatorApp(){
        XCTAssertEqualWithAccuracy(1.23, 1.24, accuracy: 0.011)
    }
//    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }
//    
    
    func testDisplay9AfterPressing2AndSaveToMemoryAnd3AndPlusAndMAndPlusAnd4AndPlus(){
        brain.variableValues["M"] = 2
        brain.setOperand(3)
        brain.performOperation("+")
        brain.setOperand("M")
        brain.performOperation("+")
        brain.setOperand(4)
        brain.performOperation("+")
        
        XCTAssertEqual(brain.result, 9)
    }
    
    func testResultEqualTo9AfterPressing9AndPlusAndMAndEqualAndSquareRootAnd72AndSaveMemory(){
        brain.setOperand(9)
        brain.performOperation("+")
        brain.setOperand("M")
        brain.performOperation("=")
        brain.performOperation("√")
        brain.variableValues["M"] = 72
        
        XCTAssertEqual(brain.result, 9)
    }
    
    func testPress2AndPlusAnd3AndPlusAndUndo(){
        brain.setOperand(2)
        brain.performOperation("+")
        brain.setOperand(3)
        brain.performOperation("+")
        brain.rewindPreviousOperation()
        
        XCTAssertEqual(brain.result, 3)
        XCTAssertEqual(brain.description, "2 + 3")
    }
    
    func testPress2AndPlusAnd3AndPlusAndUndoAndMinus(){
        brain.setOperand(2)
        brain.performOperation("+")
        brain.setOperand(3)
        brain.performOperation("+")
        brain.rewindPreviousOperation()
        brain.performOperation("-")
        
        XCTAssertEqual(brain.result, 5)
        XCTAssertEqual(brain.description, "2 + 3 - ")
    }
    
    func testUndoTwice(){
        brain.variableValues["M"] = 4
        brain.setOperand("M")
        brain.performOperation("×")
        brain.setOperand(3)
        brain.performOperation("+")
        brain.rewindPreviousOperation()
        brain.performOperation("-")
        brain.setOperand(2)
        brain.performOperation("=")
        
        XCTAssertEqual(brain.result, 10)
        XCTAssertEqual(brain.description, "M × 3 - 2")
    }
    
    func testClear(){
        brain.setOperand(3)
        brain.performOperation("-")
        brain.setOperand(2)
        brain.performOperation("=")
        brain.clearAndResetToDefault()
        
        XCTAssertEqual(brain.result, 0)
        XCTAssertEqual(brain.description, " ")
    }
    
    
}
