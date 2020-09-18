//: [Previous](@previous)

import UIKit
import XCTest

protocol CalculatorProtocol {
    func sum(_ p1: Int, _ p2: Int) -> Int
    func sub(_ p1: Int, _ p2: Int) -> Int
}

class Calculator: CalculatorProtocol {

    var auxilliaryResult: Int?

    func sum(_ p1: Int, _ p2: Int) -> Int {
        return p1 + p2
    }

    func sub(_ p1: Int, _ p2: Int) -> Int {
        return p1 - p2
    }

}

class CalculatorTestCase: XCTestCase {
    var sut: CalculatorProtocol!
    
    override func setUp() {
        super.setUp()
        sut = Calculator()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSum() {
        let result = sut.sum(1, 2)
        XCTAssertEqual(result, 3)
    }
    
    func testSub() {
        let result = sut.sub(3, 2)
        XCTAssertEqual(result, 1)
    }
}

CalculatorTestCase.defaultTestSuite.run()
//: [Next](@next)
