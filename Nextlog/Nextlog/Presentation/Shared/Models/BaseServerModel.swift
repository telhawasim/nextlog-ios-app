//
//  BaseServerModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 19/03/2025.
//

protocol BaseServerModel: Codable {
    var message: String { get }
    var status: Int { get }
    var error: Bool? { get }
    var reason: String? { get }
}
