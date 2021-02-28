//
//  DummyLoggedAPIClient.swift
//  Estadao_ChallengeTests
//
//  Created by Pedro Giuliano Farina on 28/02/21.
//

@testable import Estadao_Challenge

internal class DummyLoggedAPIClient: APIClient {
    init() {
        let jwt = Token(token: "jjJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.0IEYC9TrL0FfQLhfE8Sp8DnDcv2xrJLUADIM75xUSPw")
        super.init(credentials: .defaultEstadao, authentication: jwt)
    }
}
