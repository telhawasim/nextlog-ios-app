//
//  APIClient.swift
//  Todo
//
//  Created by Telha Wasim on 17/03/2025.
//

import Foundation
import Combine
import UIKit

protocol APIClient {
    associatedtype EndpointType: APIEndpoint
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, APIError>
}

class URLSessionAPIClient<EndpointType: APIEndpoint>: APIClient {
    
    func request<T>(_ endpoint: EndpointType) -> AnyPublisher<T, APIError> where T : Decodable {
        /// Appending baseURL with endpoint
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        /// Make the API request
        var request = URLRequest(url: url)
        /// Adding HTTP method in request
        request.httpMethod = endpoint.method.rawValue
        /// Adding headers in request
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        /// Handle body paramters
        if endpoint.method != .GET, let paramters = endpoint.parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: paramters, options: [])
        }
        /// Retuning the request according to the model
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.unknown
                }
                
                if !(200...299).contains(httpResponse.statusCode) {
                    if let errorResponse = try? JSONDecoder().decode(APIErrorResponse.self, from: data) {
                        throw APIError.clientError(statusCode: httpResponse.statusCode, message: errorResponse.reason)
                    } else {
                        throw APIError.clientError(statusCode: httpResponse.statusCode, message: "Unexpected error")
                    }
                }
                
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> APIError in
                if let decodingError = error as? DecodingError {
                    return APIError.decodingError(decodingError.localizedDescription)
                } else if let urlError = error as? URLError {
                    return APIError.networkError(urlError.localizedDescription)
                } else if let apiError = error as? APIError {
                    return apiError 
                }
                return APIError.unknown
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    //MARK: - MULTI-PART REQUEST -
    func multipartRequest<T: Decodable>(
        to endpoint: EndpointType,
        parameters: [String: String],
        image: UIImage?,
        imageKey: String = "avatar"
    ) -> AnyPublisher<T, APIError> {
        
        var request = URLRequest(url: endpoint.baseURL.appendingPathComponent(endpoint.path))
        request.httpMethod = "POST"

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()
        
        // Append parameters
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        // Append image if available
        if let image = image, let imageData = image.jpegData(compressionQuality: 0.8) {
            let filename = "image.jpg"
            let mimeType = "image/jpeg"
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(imageKey)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.unknown
                }
                
                if !(200...299).contains(httpResponse.statusCode) {
                    if let errorResponse = try? JSONDecoder().decode(APIErrorResponse.self, from: data) {
                        throw APIError.clientError(statusCode: httpResponse.statusCode, message: errorResponse.reason)
                    } else {
                        throw APIError.clientError(statusCode: httpResponse.statusCode, message: "Unexpected error")
                    }
                }
                
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> APIError in
                if let decodingError = error as? DecodingError {
                    return APIError.decodingError(decodingError.localizedDescription)
                } else if let urlError = error as? URLError {
                    return APIError.networkError(urlError.localizedDescription)
                } else if let apiError = error as? APIError {
                    return apiError
                }
                return APIError.unknown
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
