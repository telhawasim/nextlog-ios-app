//
//  NextlogApp.swift
//  Nextlog
//
//  Created by Telha Wasim on 19/03/2025.
//

import SwiftUI

@main
struct NextlogApp: App {
    
    @StateObject var router = Routing()
    
    var body: some Scene {
        WindowGroup {
//            SplashView(container: DependencyContainer())
            EmployeesView()
        }
        .environmentObject(self.router)
    }
}
