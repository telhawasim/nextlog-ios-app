//
//  APIError.swift
//  Todo
//
//  Created by Telha Wasim on 17/03/2025.
//

import Foundation

enum APIError: Error {
    case unknown
    case invalidResponse
    case invalidData
    case decodingError(String)
    case networkError(String)
    case clientError(statusCode: Int, message: String)
    case serverError(statusCode: Int, message: String)
    
    var errorDescription: String? {
        switch self {
        case .clientError(_, let message), .serverError(_, let message):
            return message
        case .invalidResponse:
            return "Invalid response from the server."
        case .unknown:
            return "An unknown error occurred."
        case .invalidData:
            return "Invalid Data"
        case .decodingError(_):
            return ""
        case .networkError(_):
            return ""
        }
    }
    
    var errorStatus: Int? {
        switch self {
        case .clientError(let status, _), .serverError(let status, _):
            return status
        default:
            return nil
        }
    }
}
