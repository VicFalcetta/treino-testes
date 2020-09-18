import XCTest
import Foundation

class Validator {

    func isValid(text: String) -> Bool {
        return text.count > 10
    }

    func isValid(number: Int) -> Bool {
        return number > 0
    }

}

class ValidatorTestCase: XCTestCase {

    var sut: Validator!

    override func setUp() {
        super.setUp()
        // Arrange
        sut = Validator()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testValidText() {
        // Act
        let text = String(repeating: "a", count: 11)
        let result = sut.isValid(text: text)

        // Assert
        XCTAssertTrue(result)
    }

    func testNotValidText() {
        // Act
        let text = String(repeating: "a", count: 10)
        let result = sut.isValid(text: text)

        // Assert
        XCTAssertFalse(result)
    }

    func testValidNumber() {
        // Act
        let number = 1
        let result = sut.isValid(number: number)
        // Assert
        XCTAssertTrue(result)
    }

    func testNotValidNumber() {
        // Act
        let number = -1
        let result = sut.isValid(number: number)
        // Assert
        XCTAssertFalse(result)
    }

}

ValidatorTestCase.defaultTestSuite.run()
//: [Next](@next)
