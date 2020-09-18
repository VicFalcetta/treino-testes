import UIKit
import XCTest

enum RequestError: Error {
    case api(error: Error)
    case not200
    case noResponse
    case noData
}

class APIClient {

    let client: URLSession

    init(client: URLSession = URLSession.shared) {
        self.client = client
    }

    func fetchData(url: String, completion: @escaping (Result<Data, RequestError>) -> Void) {
        execute(URL: URL(string: url)!, completion: completion)
    }

    func execute(completion: @escaping (Result<Data, RequestError>) -> Void) {
        execute(URL: URL(string: "www.test.com")!, completion: completion)
    }

    func execute(URL: URL, completion: @escaping (Result<Data, RequestError>) -> Void) {
        client.dataTask(with: URL) { (data, response, error) in
            if let error = error {
                completion(.failure(RequestError.api(error: error)))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(RequestError.noResponse))
                return
            }

            guard response.statusCode == 200 else {
                completion(.failure(RequestError.not200))
                return
            }

            guard let data = data else {
                completion(.failure(RequestError.noData))
                return
            }

            completion(.success(data))
        }.resume()
    }

}

class URLSessionStub: URLSession {

    var shouldError: Bool = false
    var dataResponse: Data = Data()
    var urlResponse: HTTPURLResponse = HTTPURLResponse()
    var statusCode: Int = 200
    var error: Error = NSError(domain:String(), code:404, userInfo:nil)

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        if !shouldError {
            urlResponse = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
            completionHandler(dataResponse, urlResponse , nil)
            return URLSessionDataTaskFake()
        }
        completionHandler(nil, nil , error)
        return URLSessionDataTaskFake()
    }
}

class URLSessionDataTaskFake: URLSessionDataTask {

    override func resume() { }

}

class APIClientTestCase: XCTestCase {

    var urlSessionStub: URLSessionStub!
    var sut: APIClient!
    
    override func setUp() {
        super.setUp()
        urlSessionStub = URLSessionStub()
        sut = APIClient(client: urlSessionStub)
    }
    
    override func tearDown() {
        sut = nil
        urlSessionStub = nil
        super.tearDown()
    }

    func testSuccess() {
        let expectation = XCTestExpectation(description: #function)
        var data: Data?
        sut.execute { result in
            if case .success(let dataResponse) = result {
                data = dataResponse
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertNotNil(data)
    }
    
    func testError() {
        let expectation = XCTestExpectation(description: #function)
        var testError: RequestError?
        
        urlSessionStub.statusCode = 300
        
        sut.execute { result in
            if case .failure(let error) = result {
                testError = error
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(testError)
        
        guard case .not200 = testError else {
            return XCTFail("Error difference \(String(describing: testError)) expected .not200")
        }
    }
}
APIClientTestCase.defaultTestSuite.run()
