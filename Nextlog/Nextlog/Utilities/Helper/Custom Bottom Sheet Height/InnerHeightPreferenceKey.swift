//
//  InnerHeightPreferenceKey.swift
//  Nextlog
//
//  Created by Telha Wasim on 08/04/2025.
//

import Foundation
import SwiftUI

struct InnerHeightPreferenceKey: PreferenceKey {
    
    //MARK: - PROPERTIES -
    static let defaultValue: CGFloat = .zero
    
    //MARK: - REDUCE -
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
