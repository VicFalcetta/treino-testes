//: [Previous](@previous)

import Foundation
import XCTest

class Sleeper {

    func dream() {
        sleep(3)
    }

}

class SleeperTestCase: XCTestCase {

    var sut: Sleeper!

    override func setUp() {
        super.setUp()
        sut = Sleeper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testDream() {
        self.measure {
            sut.dream()
        }
    }

}

SleeperTestCase.defaultTestSuite.run()

//: [Next](@next)
