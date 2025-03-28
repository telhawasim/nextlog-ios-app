//
//  AddEmployeeView.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct AddEmployeeView: View {
    
    //MARK: - PROPERTIES -
    
    //EnvironmentObject
    @EnvironmentObject var router: Routing
    //StateObject
    @StateObject var viewModel = AddEmployeeView.ViewModel()
    //State
    @State private var name: String = ""
    @State private var designation: String = ""
    @State private var department: String = ""
    @State private var selectedDob: String = ""
    @State private var dob: Date = Date()
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var selectedDateOfJoining: String = ""
    @State private var dateOfJoining: Date = Date()
    
    //MARK: - VIEWS -
    var body: some View {
        ZStack {
            // Parent View
            ScrollView {
                // Main View
                VStack(spacing: 0) {
                    // Title and Cross Button
                    HStack {
                        // Title
                        Text("Add Employee")
                            .font(.getMedium(.h24))
                        // Spacer
                        Spacer()
                        // Cross Button
                        Button(action: {
                            self.router.pop()
                        }, label: {
                            Image(ImageEnum.icCross.rawValue)
                                .resizable()
                                .padding(.all, 5)
                                .frame(width: 30, height: 30)
                        })
                    }
                    // Profile Image and Camera Button
                    ZStack(alignment: .bottomTrailing) {
                        // Profile Image
                        if let image = self.viewModel.selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 142, height: 142)
                                .clipShape(Circle())
                        } else {
                            Circle()
                                .frame(width: 142, height: 142)
                                .foregroundStyle(Color.color808080.opacity(0.2))
                                .clipShape(Circle())
                        }
                        // Camera Button
                        AddEmployeeCameraButtonView(
                            onPress: {
                                self.viewModel.isShowActionSheet.toggle()
                            }
                        )
                    }
                    .padding(.top, 30)
                    // All Textfields
                    VStack(spacing: 20) {
                        // Name Textfield
                        AddEmployeeNameTextField(
                            value: self.$name
                        )
                        // Designation Textfield
                        AddEmployeeDesignationTextField(
                            value: self.$designation,
                            isDesignation: true
                        )
                        // Designation Textfield
                        AddEmployeeDesignationTextField(
                            value: self.$department,
                            isDesignation: false
                        )
                        // Department Textfield
                        AddEmployeeDobTextField(
                            selectedValue: self.$selectedDob,
                            isDOB: true,
                            onPress: {
                                self.viewModel.isShowDOBDatePicker.toggle()
                            }
                        )
                        // Email Address Textfield
                        AddEmployeeEmailTextField(
                            value: self.$email
                        )
                        // Phone Number Textfield
                        AddEmployeePhoneTextField(
                            value: self.$phone
                        )
                        // Date of Joining Textfield
                        AddEmployeeDobTextField(
                            selectedValue: self.$selectedDateOfJoining,
                            isDOB: false,
                            onPress: {
                                self.viewModel.isShowDateOfJoiningPicker.toggle()
                            }
                        )
                    }
                    .padding(.top, 20)
                    // Add Button
                    AppCustomButton(
                        title: "Add",
                        onPress: {
                            
                        }
                    )
                    .padding(.top, 60)
                    .padding(.bottom, 10)
                }
                .padding(.top, 10)
                .padding(.horizontal, 16)
            }
            .confirmationDialog("", isPresented: self.$viewModel.isShowActionSheet) {
                Button("Camera") {
                    self.viewModel.sourceType = .camera
                    self.viewModel.isShowingImagePicker = true
                }
                Button("Photo Gallery") {
                    self.viewModel.sourceType = .photoLibrary
                    self.viewModel.isShowingImagePicker = true
                }
            } message: {
                Text("Select an option")
            }
            .sheet(isPresented: self.$viewModel.isShowingImagePicker) {
                ImagePicker(sourceType: self.viewModel.sourceType) { image in
                    self.viewModel.selectedImage = image
                }
            }
            // Date of Birth Picker
            DatePickerView(
                isShowDatePicker: self.$viewModel.isShowDOBDatePicker,
                selectedValue: self.$selectedDob,
                selectedDate: self.$dob
            )
            .opacity(self.viewModel.isShowDOBDatePicker ? 1 : 0)
            .animation(.default, value: self.viewModel.isShowDOBDatePicker)
            // Date Picker
            DatePickerView(
                isShowDatePicker: self.$viewModel.isShowDateOfJoiningPicker,
                selectedValue: self.$selectedDateOfJoining,
                selectedDate: self.$dateOfJoining
            )
            .opacity(self.viewModel.isShowDateOfJoiningPicker ? 1 : 0)
            .animation(.default, value: self.viewModel.isShowDateOfJoiningPicker)
        }
    }
}

#Preview {
    AddEmployeeView()
}
