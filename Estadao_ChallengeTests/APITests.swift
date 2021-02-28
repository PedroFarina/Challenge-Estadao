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
        sut.login { (result) in
            do {
                let value = try result.get()
                XCTAssertTrue(value)
            } catch {
                XCTFail("Result threw")
            }
        }
    }
}
