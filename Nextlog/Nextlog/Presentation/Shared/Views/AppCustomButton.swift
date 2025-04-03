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
    var isDisabled: Bool = false
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
                .background(self.handleBackGroundColor())
                .clipShape(Capsule())
        })
    }
}

//MARK: - FUNCTIONS -
extension AppCustomButton {
    
    //MARK: - HANDLE BACKGROUND COLOR -
    private func handleBackGroundColor() -> Color {
        if (self.isDisabled) {
            return .color808080
        } else {
            if (self.colorScheme == .dark) {
                return .white
            } else {
                return .black
            }
        }
    }
}

#Preview {
    AppCustomButton(
        title: "Log In"
    )
}
