//
//  View+Ext.swift
//  Nextlog
//
//  Created by Telha Wasim on 11/04/2025.
//

import SwiftUI

extension View {
    
    //MARK: - HIDE KEYBOARD -
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
