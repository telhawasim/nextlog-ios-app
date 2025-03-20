//
//  NextlogApp.swift
//  Nextlog
//
//  Created by Telha Wasim on 19/03/2025.
//

import SwiftUI

@main
struct NextlogApp: App {
    
    //MARK: - PROPERTIES -
    
    //StateObject
    @StateObject var router = Routing()
    
    //MARK: - LIFE CYCLE -
    var body: some Scene {
        WindowGroup {
            SplashView(container: DependencyContainer())
        }
        .environmentObject(self.router)
    }
}
