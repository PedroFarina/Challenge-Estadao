//
//  APITests.swift
//  Estadao_ChallengeTests
//
//  Created by Pedro Giuliano Farina on 28/02/21.
//

import XCTest
@testable import Estadao_Challenge

class APITests: XCTestCase {

    var sut: APIClient!

    override func setUp() {
        sut = APIClient(credentials: .defaultEstadao)
    }

    override func tearDown() {
        sut = nil
    }

    func testLogin() {
        let expectation = self.expectation(description: "Login")
        sut.login { (result) in
            do {
                let value = try result.get()
                XCTAssertTrue(value)
            } catch {
                XCTFail("Result threw")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testFetchPreviewNews() {
        let expectation = self.expectation(description: "PreviewNews")
        afterLogin(on: sut) { [self] in
            sut.fetchPreviewNews { (result) in
                do {
                    let value = try result.get()
                    XCTAssertNotNil(value)
                } catch {
                    XCTFail("Result threw")
                }
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 4, handler: nil)
    }

    func testFetchFullNews() {
        let expectation = self.expectation(description: "FullNews")
        afterLogin(on: sut) { [self] in
            sut.fetchFullNews(id: "1") { (result) in
                do {
                    let value = try result.get()
                    XCTAssertNotNil(value)
                } catch {
                    XCTFail("Result threw")
                }
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 4, handler: nil)
    }

    func afterLogin(on client: APIClient, do completionHandler: @escaping () -> Void) {
        client.login { (_) in
            completionHandler()
        }
    }
}
