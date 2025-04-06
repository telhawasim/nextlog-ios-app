//
//  CreateProfileCategoryView.swift
//  Nextlog
//
//  Created by Telha Wasim on 05/04/2025.
//

import SwiftUI

struct CreateProfileCategoryView: View {
    
    //MARK: - PROPERTIES -
    
    var title: String = "Experience"
    var isSelected: Bool = false
    
    //MARK: - VIEWS -
    var body: some View {
        Text(self.title)
            .font(.getRegular())
            .foregroundStyle(self.isSelected ? Color.white : Color.black)
            .padding(.horizontal, 20)
            .frame(height: 35)
            .background(self.isSelected ? Color.black : Color.white)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(self.isSelected ? Color.clear : Color.black)
            )
            .padding(.all, 1)
    }
}

#Preview {
    CreateProfileCategoryView()
}
