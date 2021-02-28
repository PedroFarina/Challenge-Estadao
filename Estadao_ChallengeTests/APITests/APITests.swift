//
//  APITests.swift
//  Estadao_ChallengeTests
//
//  Created by Pedro Giuliano Farina on 28/02/21.
//

import XCTest
@testable import Estadao_Challenge

class APITests: XCTestCase {

    func testLogin() {
        let sut = APIClient(credentials: .defaultEstadao)
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
        waitForExpectations(timeout: 3, handler: nil)
    }

    func testFetchPreviewNewss() {
        let sut = APIClient(credentials: .defaultEstadao)
        let expectation = self.expectation(description: "PreviewNews")
        afterLogin(on: sut) {
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
        waitForExpectations(timeout: 3, handler: nil)
    }

    func afterLogin(on client: APIClient, do completionHandler: @escaping () -> Void) {
        client.login { (_) in
            completionHandler()
        }
    }
}
