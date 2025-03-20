//
//  AppCustomButton.swift
//  Nextlog
//
//  Created by Telha Wasim on 19/03/2025.
//

import SwiftUI

struct AppCustomButton: View {
    
    //MARK: - PROPERTIES -
    
    //Environment
    @Environment(\.colorScheme) var colorScheme
    //Normal
    var title: String
    var onPress: (() -> Void)?
    
    //MARK: - VIEWS -
    var body: some View {
        Button(action: {
            self.onPress?()
        }, label: {
            Text(self.title)
                .font(.getSemibold(.h18))
                .foregroundStyle(self.colorScheme == .dark ? Color.black : Color.white)
                .frame(maxWidth: .infinity, minHeight: 55, maxHeight: 55, alignment: .center)
                .background(self.colorScheme == .dark ? Color.white : Color.black)
                .clipShape(Capsule())
        })
    }
}

#Preview {
    AppCustomButton(
        title: "Log In"
    )
}
