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

    internal let credentials: Credentials

    private var jwt: Token?
    private var authorizationHeader: [String:String] {
        ["Authorization": "Bearer \(jwt?.token ?? "")"]
    }

    internal init(credentials: Credentials) {
        self.credentials = credentials
    }

    internal func login(completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        Requests.postRequest(url: "https://teste-dev-mobile-api.herokuapp.com/login",
                             method: .post,
                             header: nil,
                             params: credentials,
                             decodableType: Token.self) { [weak self] in
            self?.completeResult(answer: $0, optionalCast: {$0 as? Token}, completionHandler: { (result) in
                do {
                    self?.jwt = try result.get()
                    completionHandler(.success(true))
                } catch {
                    completionHandler(.failure(error))
                }
            })
        }
    }

    internal func fetchPreviewNews(completionHandler: @escaping (Result<[PreviewNews], Error>) -> Void) {
        Requests.getRequest(url: "https://teste-dev-mobile-api.herokuapp.com/news",
                            decodableType: [PreviewNews].self,
                            header: authorizationHeader) { [weak self] in
            self?.completeResult(answer: $0, optionalCast: {$0 as? [PreviewNews]}, completionHandler: completionHandler)
        }
    }

    internal func fetchFullNews(id: String, completionHandler: @escaping (Result<[FullNews], Error>) -> Void) {
        Requests.getRequest(url: "https://teste-dev-mobile-api.herokuapp.com/news/\(id)",
                            decodableType: [FullNews].self,
                            header: authorizationHeader) { [weak self] in
            self?.completeResult(answer: $0, optionalCast: {$0 as? [FullNews]}, completionHandler: completionHandler)
        }
    }

    private func completeResult<T>(answer: TaskAnswer<Any>,
                                   optionalCast: (Any) -> T?,
                                   completionHandler: @escaping (Result<T, Error>) -> Void) {
        switch answer {
        case .result(let answer):
            if let safeValue = optionalCast(answer) {
                completionHandler(.success(safeValue))
            } else {
                completionHandler(.failure(APIErrors.unexpectedAnswer))
            }
        case .error(let err):
            completionHandler(.failure(err))
        }
    }
}
