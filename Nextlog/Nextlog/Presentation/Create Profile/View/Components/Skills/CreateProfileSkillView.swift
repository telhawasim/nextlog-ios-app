//
//  CreateProfileSkillView.swift
//  Nextlog
//
//  Created by Telha Wasim on 06/04/2025.
//

import SwiftUI

struct CreateProfileSkillView: View {
    
    //MARK: - PROPERTIES -
    
    //Binding
    @Binding var skill: SkillInfoUserModel
    //Normal
    var title: String = "Skill"
    var placeholder: String = "Enter skill"
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
            // Skill Textfield
            VStack(alignment: .leading, spacing: 10) {
                // Title and Asterisk
                HStack(spacing: 3) {
                    // Title
                    Text(self.title)
                        .font(.getSemibold(.h16))
                    // Asterisk
                    Text("*")
                        .font(.getSemibold(.h16))
                        .foregroundStyle(Color.red)
                }
                // TextField
                TextField(text: self.$skill.name, label: {
                    Text(self.placeholder)
                })
                .font(.getRegular(.h16))
                // Divider
                Divider()
            }
        }
    }
}

#Preview {
    CreateProfileSkillView(
        skill: Binding.constant(SkillInfoUserModel(name: "")),
        index: 0
    )
}
