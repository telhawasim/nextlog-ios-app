//
//  CreateProfileExperienceView.swift
//  Nextlog
//
//  Created by Telha Wasim on 05/04/2025.
//

import SwiftUI

struct CreateProfileExperienceView: View {
    
    //MARK: - PROPERTIES -
    
    //Binding
    @Binding var experience: ExperienceInfoUserModel
    //Normal
    var isCurrentExperience: Bool = false
    var index: Int = -1
    var selectedStartDate: String = ""
    var selectedEndDate: String = ""
    var onPressDelete: (() -> Void)?
    var onPressStartDate: (() -> Void)?
    var onPressEndDate: (() -> Void)?
    var onPressDesignation: (() -> Void)?
    
    //MARK: - VIEWS -
    var body: some View {
        VStack(spacing: 15) {
            // Only show if experience is not current
            if !(self.isCurrentExperience) {
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
                .frame(height: 45)
            }
            // Company Textfield
            VStack(alignment: .leading, spacing: 10) {
                // Title and Asterisk
                HStack(spacing: 3) {
                    // Title
                    Text("Company Name")
                        .font(.getSemibold(.h16))
                    // Asterisk
                    Text("*")
                        .font(.getSemibold(.h16))
                        .foregroundStyle(Color.red)
                }
                // TextField
                TextField(text: self.$experience.companyName, label: {
                    Text("Enter name")
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
                    Text("Start Date")
                        .font(.getSemibold(.h16))
                    // Aesterisk
                    Text("*")
                        .foregroundStyle(Color.red)
                }
                .padding(.bottom, -7)
                // Start Date Picker Button
                Button(action: {
                    self.onPressStartDate?()
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
                    Text("End Date")
                        .font(.getSemibold(.h16))
                    // Aesterisk
                    Text("*")
                        .foregroundStyle(Color.red)
                }
                .padding(.bottom, -7)
                // End Date Picker Button
                Button(action: {
                    self.onPressEndDate?()
                }, label: {
                    // Text and Logo
                    HStack {
                        // Text
                        Text(self.handleEndDate())
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
                .disabled(self.isCurrentExperience)
                // Divider
                Divider()
            }
            // Only show designation TextField if current experience is false
            if !(self.isCurrentExperience) {
                // Designation TextField
                AddEmployeeDesignationTextField(
                    value: self.$experience.designationName,
                    isDesignation: true,
                    onPress: {
                        self.onPressDesignation?()
                    }
                )
            }
            // Summary TextField
            CreateProfileSummaryTextField(
                value: self.$experience.description,
                placeholder: "Job Description / Responsibilities")
            .padding(.top, 15)
        }
    }
}

//MARK: - FUNCTIONS -
extension CreateProfileExperienceView {
    
    //MARK: - HANDLE END DATE -
    private func handleEndDate() -> String {
        if (self.isCurrentExperience) {
            return "Present"
        } else {
            return self.selectedEndDate == "" ? "Enter end date" : self.selectedEndDate
        }
    }
    
    //MARK: - HANDLE END DATE COLOR -
    private func handleEndDateColor() -> Color {
        if (self.isCurrentExperience) {
            return Color.black
        } else {
            return self.selectedEndDate == "" ? Color.gray.opacity(0.5) : Color.black
        }
    }
}

#Preview {
    CreateProfileExperienceView(
        experience: Binding.constant(ExperienceInfoUserModel(companyName: "", startDate: "", endDate: "", designationName: "", designationID: "", description: ""))
    )
}
