//
//  BaseViewModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 19/03/2025.
//

import Foundation

class BaseViewModel: Hashable, Equatable, ObservableObject {
    static func == (lhs: BaseViewModel, rhs: BaseViewModel) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
