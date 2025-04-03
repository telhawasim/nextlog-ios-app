//
//  DeleteProfilePopUpView.swift
//  Nextlog
//
//  Created by Telha Wasim on 03/04/2025.
//

import SwiftUI

struct DeleteProfilePopUpView: View {
    
    //MARK: - PROPERTIES -
    
    //Binding
    @Binding var isShowPopup: Bool
    //Normal
    var onPressYes: (() -> Void)?
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        ZStack {
            // Background
            Color.black
                .opacity(self.isShowPopup ? 0.6 : 0)
                .ignoresSafeArea()
            // Main View
            ZStack {
                // Icon, Title, Description, Buttons
                VStack(spacing: 0) {
                    // Icon
                    Image(ImageEnum.icConfirmation.rawValue)
                        .resizable()
                        .frame(width: 80, height: 70)
                    // Title and Description
                    VStack(spacing: 7) {
                        Text("Are you sure?")
                            .font(.getMedium(.h28))
                        Text("You want to delete this user?")
                            .font(.getRegular())
                    }
                    .padding(.top, 25)
                    // Buttons
                    HStack(spacing: 12) {
                        // No Button
                        Button(action: {
                            self.isShowPopup = false
                        }, label: {
                            Text("No")
                                .font(.getMedium(.h16))
                                .foregroundStyle(Color.black)
                                .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .stroke(Color.black, lineWidth: 1.0)
                                )
                            
                        })
                        // Yes Button
                        Button(action: {
                            self.isShowPopup = false
                            self.onPressYes?()
                        }, label: {
                            Text("Yes")
                                .font(.getMedium(.h16))
                                .foregroundStyle(Color.white)
                                .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                                .background(Color.black)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        })
                    }
                    .padding(.vertical, 30)
                    .padding(.horizontal, 40)
                }
                .padding(.top, 40)
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 24.0))
            .padding(.horizontal, 16)
            .offset(y: self.isShowPopup ? 0 : 600)
        }
        .animation(.spring(response: 0.8, dampingFraction: 0.6, blendDuration: 0), value: self.isShowPopup)
    }
}

#Preview {
    DeleteProfilePopUpView(
        isShowPopup: Binding.constant(true)
    )
}
