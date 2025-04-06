//
//  CreateProfileHeaderView.swift
//  Nextlog
//
//  Created by Telha Wasim on 05/04/2025.
//

import SwiftUI

struct CreateProfileHeaderView: View {
    
    //MARK: - PROPERTIES -
    
    var title: String
    
    //MARK: - VIEWS -
    var body: some View {
        // Title and Spacer
        HStack {
            // Title
            Text(self.title)
                .font(.getMedium(.h20))
                .frame(height: 65)
            // Spacer
            Spacer()
        }
        .padding(.horizontal, 16)
        .background(Color.colorF7F7F7)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
}

#Preview {
    CreateProfileHeaderView(
        title: "Basic Info"
    )
}
