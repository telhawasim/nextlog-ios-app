//
//  NetworkManager.swift
//  Nextlog
//
//  Created by Telha Wasim on 28/03/2025.
//

import Foundation
import Alamofire
import Combine

final class NetworkManager {
    
    // MARK: - PROPERTIES -
    static let shared = NetworkManager()
    private let session: Session

    // MARK: - INITIALIZER -
    private init() {
        self.session = Session(interceptor: TokenInterceptor())
    }

    func request<T: Decodable>(
        endPoint: APIEndpoint,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkError> {
        guard let requestURL = URL(string: endPoint.url) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        let afHeaders = endPoint.headers

        return session.request(requestURL, method: endPoint.method, parameters: endPoint.parameters, encoding: JSONEncoding.default, headers: afHeaders)
            .validate()
            .publishDecodable(type: responseType)
            .tryMap { response in
                if let data = response.data {
                    print("Raw Response Data: \(String(data: data, encoding: .utf8) ?? "Invalid Data")")
                }

                guard let value = response.value else {
                    throw NSError(domain: "Decoding Error", code: -1005, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response."])
                }
                
                return value
            }
            .mapError { error in
                if let afError = error.asAFError, let statusCode = afError.responseCode {
                    switch statusCode {
                    case 401: return .unauthorized
                    case 500...599: return .serverError(statusCode: afError.responseCode ?? -1)
                    default: return .unknown(error)
                    }
                }
                return .unknown(error)
            }
            .eraseToAnyPublisher()
    }
}
