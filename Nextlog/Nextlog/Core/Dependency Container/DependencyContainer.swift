//
//  DependencyContainer.swift
//  Todo
//
//  Created by Telha Wasim on 17/03/2025.
//

import Foundation

protocol DependencyContainerProtocol {
    var userService: UserRepository { get }
}

class DependencyContainer: DependencyContainerProtocol {
    lazy var userService: UserRepository = UserService()
    
    init(userService: UserRepository? = nil) {
        if let userService = userService {
            self.userService = userService
        }
    }
}
