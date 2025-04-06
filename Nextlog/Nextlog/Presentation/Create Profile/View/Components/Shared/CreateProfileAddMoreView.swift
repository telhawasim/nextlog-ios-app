//
//  CreateProfileAddMoreView.swift
//  Nextlog
//
//  Created by Telha Wasim on 06/04/2025.
//

import SwiftUI

struct CreateProfileAddMoreView: View {
    
    //MARK: - PROPERTIES -
    
    //Normal
    var onPress: (() -> Void)?
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        HStack {
            // Spacer
            Spacer()
            // Add More Button
            Button(action: {
                self.onPress?()
            }, label: {
                Text("Add More")
                    .font(.getSemibold(.h18))
                    .foregroundStyle(Color.white)
                    .frame(width: 144, height: 42)
                    .background(Color.color808080)
                    .clipShape(Capsule())
            })
        }
    }
}

#Preview {
    CreateProfileAddMoreView()
}
