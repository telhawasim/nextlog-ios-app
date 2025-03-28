//
//  NetworkError.swift
//  Nextlog
//
//  Created by Telha Wasim on 28/03/2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case unauthorized
    case serverError(statusCode: Int)
    case unknown(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .noData: return "No data received"
        case .decodingError: return "Failed to decode response"
        case .unauthorized: return "Unauthorized access"
        case .serverError(let code): return "Server error with status code \(code)"
        case .unknown(let error): return error.localizedDescription
        }
    }
}
