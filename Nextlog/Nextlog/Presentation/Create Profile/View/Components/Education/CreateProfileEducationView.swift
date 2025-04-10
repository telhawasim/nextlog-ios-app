//
//  CreateProfileEducationView.swift
//  Nextlog
//
//  Created by Telha Wasim on 06/04/2025.
//

import SwiftUI

struct CreateProfileEducationView: View {
    
    //MARK: - PROPERTIES -
    
    //Binding
    @Binding var education: EducationInfoUserModel
    //Normal
    var index: Int
    var count: Int = 0
    var selectedStartDate: String = ""
    var selectedEndDate: String = ""
    var onPressDelete: (() -> Void)?
    var onPressStart: (() -> Void)?
    var onPressEnd: (() -> Void)?
    
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
                if !(self.count == 1) {
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
            }
            .frame(height: 45)
            // Company Textfield
            VStack(alignment: .leading, spacing: 10) {
                // Title and Asterisk
                HStack(spacing: 3) {
                    // Title
                    Text("Degree")
                        .font(.getSemibold(.h16))
                    // Asterisk
                    Text("*")
                        .font(.getSemibold(.h16))
                        .foregroundStyle(Color.red)
                }
                // TextField
                TextField(text: self.$education.degree, label: {
                    Text("Enter degree")
                })
                .font(.getRegular(.h16))
                // Divider
                Divider()
            }
            // Institution Textfield
            VStack(alignment: .leading, spacing: 10) {
                // Title and Asterisk
                HStack(spacing: 3) {
                    // Title
                    Text("Institure")
                        .font(.getSemibold(.h16))
                    // Asterisk
                    Text("*")
                        .font(.getSemibold(.h16))
                        .foregroundStyle(Color.red)
                }
                // TextField
                TextField(text: self.$education.institution, label: {
                    Text("Enter institute")
                })
                .font(.getRegular(.h16))
                // Divider
                Divider()
            }
            // Start Date TextField
            VStack(alignment: .leading, spacing: 5) {
                // Title and Aesterisk
                HStack(alignment: .lastTextBaseline, spacing: 3) {
                    // Title
                    Text("Start From")
                        .font(.getSemibold(.h16))
                    // Aesterisk
                    Text("*")
                        .foregroundStyle(Color.red)
                }
                .padding(.bottom, -7)
                // Date Picker Button
                Button(action: {
                    self.onPressStart?()
                }, label: {
                    // Text and Logo
                    HStack {
                        // Text
                        Text(self.selectedStartDate == "" ? "Enter start date" : self.selectedStartDate)
                            .font(.getRegular(.h16))
                            .foregroundStyle(self.selectedStartDate == "" ? Color.gray.opacity(0.5) : Color.black)
                            .padding(.bottom, -6)
                        // Spacer
                        Spacer()
                        // Logo
                        ZStack {
                            // Background
                            Circle()
                                .frame(width: 32)
                                .foregroundStyle(Color.color808080)
                            // Image
                            Image(ImageEnum.icCalendar.rawValue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .foregroundStyle(Color.white)
                        }
                    }
                })
                // Divider
                Divider()
            }
            // End Date TextField
            VStack(alignment: .leading, spacing: 5) {
                // Title and Aesterisk
                HStack(alignment: .lastTextBaseline, spacing: 3) {
                    // Title
                    Text("End To")
                        .font(.getSemibold(.h16))
                    // Aesterisk
                    Text("*")
                        .foregroundStyle(Color.red)
                }
                .padding(.bottom, -7)
                // Date Picker Button
                Button(action: {
                    self.onPressEnd?()
                }, label: {
                    // Text and Logo
                    HStack {
                        // Text
                        Text(self.selectedEndDate == "" ? "Enter end date" : self.selectedEndDate)
                            .font(.getRegular(.h16))
                            .foregroundStyle(self.selectedEndDate == "" ? Color.gray.opacity(0.5) : Color.black)
                            .padding(.bottom, -6)
                        // Spacer
                        Spacer()
                        // Logo
                        ZStack {
                            // Background
                            Circle()
                                .frame(width: 32)
                                .foregroundStyle(Color.color808080)
                            // Image
                            Image(ImageEnum.icCalendar.rawValue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .foregroundStyle(Color.white)
                        }
                    }
                })
                // Divider
                Divider()
            }
        }
    }
}

#Preview {
    CreateProfileEducationView(
        education: Binding.constant(EducationInfoUserModel(degree: "", institution: "", startDate: "", endDate: "")),
        index: 0
    )
}
