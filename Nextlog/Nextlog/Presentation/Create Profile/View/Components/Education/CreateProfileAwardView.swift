//
//  CreateProfileAwardView.swift
//  Nextlog
//
//  Created by Telha Wasim on 06/04/2025.
//

import SwiftUI

struct CreateProfileAwardView: View {
    
    //MARK: - PROPERTIES -
    
    //Binding
    @Binding var awards: AwardsInfoUserModel
    //Normal
    var index: Int
    var onPressDelete: (() -> Void)?
    
    //MARK: - VIEWS -
    var body: some View {
        VStack(spacing: 20) {
            // Number and Delete Button
            HStack {
                // Number
                Text("\(self.index + 1)")
                    .frame(width: 32, height: 32)
                    .background(Color.colorF7F7F7)
                    .clipShape(Circle())
                // Spacer
                Spacer()
                // Delete Button
                Button(action: {
                    self.onPressDelete?()
                }, label: {
                    ZStack {
                        Circle()
                            .frame(width: 32)
                            .foregroundStyle(Color.color808080)
                        Image(ImageEnum.icDelete.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundStyle(Color.white)
                    }
                })
            }
            .frame(height: 59)
            // Award Textfield
            VStack(alignment: .leading, spacing: 10) {
                // Title and Asterisk
                HStack(spacing: 3) {
                    // Title
                    Text("Award Title")
                        .font(.getSemibold(.h16))
                    // Asterisk
                    Text("*")
                        .font(.getSemibold(.h16))
                        .foregroundStyle(Color.red)
                }
                // TextField
                TextField(text: self.$awards.title, label: {
                    Text("Enter award title")
                })
                .font(.getRegular(.h16))
                // Divider
                Divider()
            }
            // Award Description
            CreateProfileSummaryTextField(
                value: self.$awards.description,
                placeholder: "Award Description"
            )
        }
    }
}

#Preview {
    CreateProfileAwardView(
        awards: Binding.constant(AwardsInfoUserModel(title: "", description: "")),
        index: 0
    )
}
