//: [Previous](@previous)

import Foundation
import XCTest

class TestCase: XCTestCase {

    var sut = MyView()

    func testMetho1() {
        XCTAssertEqual(sut.backgroundColor, .red)
    }

    func testMethod2() {
        sut.backgroundColor = .blue
        XCTAssertEqual(sut.backgroundColor, .blue)
    }

}

TestCase.defaultTestSuite.run()


//: [Next](@next)
