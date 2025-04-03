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
    case unauthorized(statusCode: Int, message: String)
    case serverError(statusCode: Int, message: String)
    case unknown(String)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .noData: return "No data received"
        case .decodingError: return "Failed to decode response"
        case .unauthorized: return "Unauthorized access"
        case .serverError(let code, let message): return "Server error with status code \(code) and message: \(message)"
        case .unknown(let message): return message
        }
    }
}

struct APIError: Decodable {
    let message: String
    let status: Int
}
