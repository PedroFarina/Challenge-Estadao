//
//  APIClient.swift
//  Estadao_Challenge
//
//  Created by Pedro Giuliano Farina on 28/02/21.
//

//Um Swift Package de requisições GET e POST feito por mim há 1 ano atrás.
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

    private static let loginPath = "https://teste-dev-mobile-api.herokuapp.com/login"
    private static let previewNewsPath = "https://teste-dev-mobile-api.herokuapp.com/news"
    private static let fullNewsPath = "https://teste-dev-mobile-api.herokuapp.com/news/{id}"

    internal init(credentials: Credentials) {
        self.credentials = credentials
    }

    internal func login(completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        Requests.postRequest(url: APIClient.loginPath,
                             method: .post,
                             header: nil,
                             params: credentials,
                             decodableType: Token.self) { [weak self] in
            switch $0 {
            case .result(let answer as Token):
                self?.jwt = answer
                completionHandler(.success(true))
            case .result(_):
                completionHandler(.failure(APIErrors.unexpectedAnswer))
            case .error(let err):
                completionHandler(.failure(err))
            }
        }
    }

    internal func fetchPreviewNews(completionHandler: @escaping (Result<[PreviewNews], Error>) -> Void) {
        getRequestWithDefaultCompletion(url: APIClient.previewNewsPath,
                        decodableType: [PreviewNews].self,
                        completionHandler: completionHandler)
    }

    internal func fetchFullNews(id: String, completionHandler: @escaping (Result<[FullNews], Error>) -> Void) {
        let fullPath = APIClient.fullNewsPath.replacingOccurrences(of: "{id}", with: id)
        getRequestWithDefaultCompletion(url: fullPath,
                        decodableType: [FullNews].self,
                        completionHandler: completionHandler)
    }

    private func getRequestWithDefaultCompletion<T: Decodable>(url: String,
                                               decodableType: T.Type,
                                               completionHandler: @escaping (Result<T, Error>) -> Void) {
        Requests.getRequest(url: url,
                            decodableType: decodableType,
                            header: authorizationHeader) { [weak self] in
            self?.defaultCompleteResult(answer: $0, optionalCast: {$0 as? T}, completionHandler: completionHandler)
        }
    }

    private func defaultCompleteResult<T>(answer: TaskAnswer<Any>,
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
