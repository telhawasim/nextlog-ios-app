//
//  AppStorageWrapper.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

@propertyWrapper
struct AppStorageWrapper<T: Codable> {
    
    //MARK: - PROPERTIES -
    private let key: String
    private let defaults = UserDefaults.standard

    //MARK: - WRAPPED VALUE -
    var wrappedValue: T? {
        get {
            guard let data = self.defaults.data(forKey: key),
                  let decoded = try? JSONDecoder().decode(T.self, from: data) else {
                return nil
            }
            return decoded
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                self.defaults.set(encoded, forKey: key)
            } else {
                self.defaults.removeObject(forKey: key)
            }
        }
    }

    //MARK: - INITIALIZER -
    init(key: String) {
        self.key = key
    }
}
