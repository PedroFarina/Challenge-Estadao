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
    private var jwt: Token?

    internal init(credentials: Credentials, authentication jwt: Token? = nil) {
        self.credentials = credentials
        self.jwt = jwt
    }

    internal func login(completionHandler: @escaping (Result<Bool, Error>) -> ()) {
        Requests.postRequest(url: "https://teste-dev-mobile-api.herokuapp.com/login",
                             method: .post,
                             header: nil,
                             params: credentials,
                             decodableType: Token.self) { [weak self] in
            switch $0 {
            case .result(let token as Token):
                self?.jwt = token
                completionHandler(.success(true))
            case .result(_):
                completionHandler(.failure(APIErrors.unexpectedAnswer))
            case .error(let err):
                completionHandler(.failure(err))
            }
        }
    }

    internal func fetchPreviewNews(completionHandler: @escaping (Result<[PreviewNews], Error>) -> ()) {
        let header = ["Authorization": "Bearer \(jwt?.token ?? "")"]
        Requests.getRequest(url: "https://teste-dev-mobile-api.herokuapp.com/news",
                            decodableType: [PreviewNews].self,
                            header: header) {
            switch $0 {
            case .result(let news as [PreviewNews]):
                completionHandler(.success(news))
            case .result(_):
                completionHandler(.failure(APIErrors.unexpectedAnswer))
            case .error(let err):
                completionHandler(.failure(err))
            }
        }
    }
}
