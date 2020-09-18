import XCTest
import LocalAuthentication

class RequestBiometry {

    let context: LAContext
    
    init(context: LAContext = LAContext()) {
        self.context = context
    }

    func request(completion: @escaping (Bool) -> Void) {
        var authError: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            let reason = "Identify yourself!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { result, authenticationError in
                completion(result)
                return
            }
        }
        completion(false)
        return
    }

}

class RequestBiometryTestCase: XCTestCase {

    var sut: RequestBiometry!
    var contextStub: LAContextStub!

    override func setUp() {
        super.setUp()
        contextStub = LAContextStub()
        sut = RequestBiometry(context: contextStub)
    }

    override func tearDown() {
        contextStub = nil
        sut = nil
        super.tearDown()
    }

    func testRequestSucessed() {
        var sucessed: Bool = false
        let expectation = self.expectation(description: #function)
        sut.request { isGranted in
            if isGranted {
                sucessed = true
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 2)
        XCTAssertTrue(sucessed)
    }

    func testRequestError() {
        contextStub.shouldEvaluatePolicy = false
        
        var refused: Bool = false
        let expectation = self.expectation(description: #function)
        sut.request { isGranted in
            if !isGranted {
                refused = true
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 2)
        XCTAssertTrue(refused)
    }

}

RequestBiometryTestCase.defaultTestSuite.run()

final class LAContextStub: LAContext {

    var shouldEvaluatePolicy: Bool = true
    var shouldError: Bool = false
    var errorCode: LAError.Code = .invalidContext

    override func canEvaluatePolicy(_ policy: LAPolicy, error: NSErrorPointer) -> Bool {
        if !shouldEvaluatePolicy {
            error?.pointee = NSError(domain: "self", code: errorCode.rawValue, userInfo: nil)
        }
        return shouldEvaluatePolicy
    }

    override func evaluatePolicy(_ policy: LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void) {
        if shouldError {
            let error: LAError = LAError(errorCode)
            reply(false, error)
            return
        }
        reply(shouldEvaluatePolicy, nil)
    }
}
