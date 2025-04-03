//
//  NetworkManager.swift
//  Nextlog
//
//  Created by Telha Wasim on 28/03/2025.
//

import Foundation
import SwiftUI
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

    //MARK: - REQUEST -
    func request<T: Decodable>(
        endPoint: APIEndpoint,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkError> {
        guard let requestURL = URL(string: endPoint.url) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        let afHeaders = endPoint.headers

        return session.request(requestURL, method: endPoint.method, parameters: endPoint.parameters, encoding: JSONEncoding.default, headers: afHeaders)
            .validate(statusCode: 200..<300)
            .publishData()
            .tryMap { response in
                if let data = response.data {
                    print("Raw Response Data: \(String(data: data, encoding: .utf8) ?? "Invalid Data")")
                }

                guard let httpResponse = response.response else {
                    throw NetworkError.unknown("No response from server")
                }

                let statusCode = httpResponse.statusCode
                
                if statusCode >= 400 {
                    if let data = response.data,
                       let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
                        if statusCode == 401 {
                            throw NetworkError.unauthorized(statusCode: apiError.status, message: apiError.message)
                        } else {
                            throw NetworkError.serverError(statusCode: apiError.status, message: apiError.message)
                        }
                    } else {
                        throw NetworkError.serverError(statusCode: statusCode, message: "Unknown server error")
                    }
                }

                // Decode success response
                return try JSONDecoder().decode(responseType, from: response.data ?? Data())
            }
            .mapError { error in
                return error as? NetworkError ?? NetworkError.unknown(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
    //MARK: - MULTIPART REQUEST -
    func multipartRequest<T: Decodable>(
        endPoint: APIEndpoint,
        image: UIImage,
        imageKey: String = "avatar",
        parameters: [String: Any] = [:],
        responseType: T.Type
    ) -> AnyPublisher<T, Error> {
        
        guard let requestURL = URL(string: endPoint.url) else {
            return Fail(error: NSError(domain: "Invalid URL", code: -1000, userInfo: [NSLocalizedDescriptionKey: "Invalid URL: \(endPoint.url)"]))
                .eraseToAnyPublisher()
        }
        
        let afHeaders = endPoint.headers
        
        return Future { promise in
            self.session.upload(multipartFormData: { multipartFormData in
                let uniqueFileName = self.generateUniqueImageName()
                
                // Append Image Data
                if let imageData = image.jpegData(compressionQuality: 0.8) {
                    multipartFormData.append(imageData, withName: imageKey, fileName: uniqueFileName, mimeType: "image/jpeg")
                }

                // Append Other Parameters
                for (key, value) in parameters {
                    if let data = "\(value)".data(using: .utf8) {
                        multipartFormData.append(data, withName: key)
                    }
                }
            }, to: requestURL, method: .post, headers: afHeaders)
            .validate()
            .responseDecodable(of: responseType) { response in
                if let data = response.data {
                    print("Raw Response Data: \(String(data: data, encoding: .utf8) ?? "Invalid Data")")
                }

                switch response.result {
                case .success(let decodedData):
                    promise(.success(decodedData))
                case .failure(let error):
                    let statusCode = response.response?.statusCode ?? -1
                    let errorMessage = error.localizedDescription
                    promise(.failure(NSError(domain: "Upload Error", code: statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    //MARK: - GENERATE UNIQUE IMAGE NAME -
    private func generateUniqueImageName() -> String {
        let timestamp = ISO8601DateFormatter().string(from: Date())
        return "image_\(timestamp).jpg"
    }

}
