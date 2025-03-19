//
//  Routing.swift
//  Nextlog
//
//  Created by Telha Wasim on 19/03/2025.
//

import Foundation
import SwiftUI

class Routing: ObservableObject {
    
    //MARK: - PROPERTIES -
    
    //Published
    @Published var path = NavigationPath()
    
    //MARK: - PUSH -
    func push(_ screen: ScreenType) {
        self.path.append(screen)
    }
    
    //MARK: - POP -
    func pop() {
        if !(self.path.isEmpty) {
            self.path.removeLast()
        }
    }
    
    //MARK: - RESET -
    func reset() {
        self.path = NavigationPath()
    }
}
