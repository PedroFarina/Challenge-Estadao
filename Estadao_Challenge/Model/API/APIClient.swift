//
//  APIClient.swift
//  Estadao_Challenge
//
//  Created by Pedro Giuliano Farina on 28/02/21.
//

import Foundation
import EndpointsRequests

internal class APIClient {
    internal enum APIErrors: Error {
        case unexpectedAnswer
    }

    let credentials: Credentials
    private var jwt: String?

    init(credentials: Credentials) {
        self.credentials = credentials
    }

    internal func login(completionHandler: @escaping (Result<Bool, Error>) -> ()) {
        Requests.postRequest(url: "https://teste-dev-mobile-api.herokuapp.com/login",
                             method: .post,
                             params: credentials) { [weak self] in
            switch $0 {
            case .result(let data as Data):
                if let result = String(data: data, encoding: .utf8) {
                    self?.jwt = result
                    completionHandler(.success(true))
                } else {
                    completionHandler(.failure(APIErrors.unexpectedAnswer))
                }
            case .result(_):
                completionHandler(.failure(APIErrors.unexpectedAnswer))
            case .error(let err):
                completionHandler(.failure(err))
            }
        }
    }

    internal func fetchNews() {

    }
}
