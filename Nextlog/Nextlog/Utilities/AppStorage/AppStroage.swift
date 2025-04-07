//
//  AppStorage.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

struct AppStorage {
    
    @AppStorageWrapper(key: "userModel") static var user: LoginUserResponse?
    @AppStorageWrapper(key: "access_token") static var accessToken: String?
    @AppStorageWrapper(key: "desginations") static var designations: [DesignationModel]?
    @AppStorageWrapper(key: "departments") static var departments: [DesignationModel]?
}
