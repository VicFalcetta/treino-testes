//: [Previous](@previous)

import Foundation
import XCTest

class MotorcycleCourier {

    func getOrder(result: @escaping (Bool) -> Void) {
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { timer in
            result(true)
            timer.invalidate()
        }
    }

}

class MotorcycleCourierTestCase: XCTestCase {

    var sut: MotorcycleCourier!

    override func setUp() {
        super.setUp()
        sut = MotorcycleCourier()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testGetOrder() {
        var testResult = false
        let expectation = XCTestExpectation(description: #function)
        sut.getOrder { result in
            testResult = result
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.6)
        XCTAssertTrue(testResult)
    }

}

MotorcycleCourierTestCase.defaultTestSuite.run()

//: [Next](@next)
