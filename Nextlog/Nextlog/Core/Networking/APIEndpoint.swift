//
//  APIEndpoint.swift
//  Todo
//
//  Created by Telha Wasim on 17/03/2025.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}
