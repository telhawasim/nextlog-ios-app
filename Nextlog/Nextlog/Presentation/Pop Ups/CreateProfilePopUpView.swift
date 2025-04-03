//
//  CreateProfilePopUpView.swift
//  Nextlog
//
//  Created by Telha Wasim on 03/04/2025.
//

import SwiftUI

struct CreateProfilePopUpView: View {
    
    //MARK: - PROPERTIES -
    
    //Binding
    @Binding var isShowPopUp: Bool
    @Binding var value: String
    //Normal
    var isDisabled: Bool {
        return self.value.isEmpty
    }
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        ZStack {
            // Background
            Color.black
                .opacity(self.isShowPopUp ? 0.6 : 0)
                .ignoresSafeArea()
            // Main View
            ZStack(alignment: .top) {
                // Icon, Description, TextField and Button
                VStack(spacing: 0) {
                    // Icon
                    Image(ImageEnum.icProfileName.rawValue)
                        .resizable()
                        .frame(width: 67, height: 67)
                    // Description
                    Text("What would you like to name this profile?")
                        .font(.getRegular(.h14))
                        .multilineTextAlignment(.center)
                        .lineSpacing(2.0)
                        .padding(.horizontal, 60)
                        .padding(.top, 25)
                    // Title, TextField and Divider
                    VStack(alignment: .leading, spacing: 6) {
                        // Title
                        Text("Profile Name")
                            .font(.getSemibold(.h16))
                        // TextField
                        TextField(text: self.$value, label: {
                            Text("Name")
                        })
                        .font(.getRegular(.h16))
                        // Divider
                        Divider()
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 24)
                    // Done Button
                    AppCustomButton(
                        title: "Done",
                        isDisabled: self.isDisabled
                    )
                        .frame(width: 200, height: 44)
                    .padding(.vertical, 30)
                    .disabled(self.isDisabled)
                }
                .padding(.top, 30)
                // Spacer and Cross Button
                HStack {
                    // Spacer
                    Spacer()
                    // Cross Button
                    Button(action: {
                        self.isShowPopUp = false
                    }, label: {
                        Image(ImageEnum.icCross.rawValue)
                            .resizable()
                            .frame(width: 22, height: 22)
                            .padding(.all, 5)
                    })
                    .padding(.trailing, 20)
                    .padding(.top, 27)
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 24.0))
            .padding(.horizontal, 16)
            .offset(y: self.isShowPopUp ? 0 : 600)
            .animation(.spring(response: 0.8, dampingFraction: 0.6, blendDuration: 0), value: self.isShowPopUp)
        }
    }
}

#Preview {
    CreateProfilePopUpView(
        isShowPopUp: Binding.constant(true),
        value: Binding.constant("")
    )
}
