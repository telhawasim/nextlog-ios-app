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
                            value: self.$viewModel.name
                        )
                        // Email Address Textfield
                        AddEmployeeEmailTextField(
                            value: self.$viewModel.email
                        )
                        // Phone Number Textfield
                        AddEmployeePhoneTextField(
                            value: self.$viewModel.phone
                        )
                        // EMP ID Textfield
                        AddEmployeeEmployeeIDTextField(
                            value: self.$viewModel.empID
                        )
                        // Designation Textfield
                        AddEmployeeDesignationTextField(
                            value: self.$viewModel.designation,
                            isDesignation: true,
                            onPress: {
                                self.viewModel.isShowDesignationPicker.toggle()
                            }
                        )
                        // Department Textfield
                        AddEmployeeDesignationTextField(
                            value: self.$viewModel.department,
                            isDesignation: false,
                            onPress: {
                                self.viewModel.isShowDepartmentPicker.toggle()
                            }
                        )
                        // Date of Birth Textfield
                        AddEmployeeDobTextField(
                            selectedValue: self.$viewModel.selectedDob,
                            isDOB: true,
                            onPress: {
                                self.viewModel.isShowDOBDatePicker.toggle()
                            }
                        )
                        // Date of Joining Textfield
                        AddEmployeeDobTextField(
                            selectedValue: self.$viewModel.selectedDateOfJoining,
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
                            self.viewModel.addEmployee { isSuccess in
                                if (isSuccess) {
                                    self.router.pop()
                                }
                            }
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
            .onTapGesture {
                self.hideKeyboard()
            }
            // Date of Birth Picker
            DatePickerView(
                isShowDatePicker: self.$viewModel.isShowDOBDatePicker,
                selectedValue: self.$viewModel.selectedDob,
                selectedDate: self.$viewModel.dob
            )
            .opacity(self.viewModel.isShowDOBDatePicker ? 1 : 0)
            .animation(.default, value: self.viewModel.isShowDOBDatePicker)
            // Date Picker
            DatePickerView(
                isShowDatePicker: self.$viewModel.isShowDateOfJoiningPicker,
                selectedValue: self.$viewModel.selectedDateOfJoining,
                selectedDate: self.$viewModel.dateOfJoining
            )
            .opacity(self.viewModel.isShowDateOfJoiningPicker ? 1 : 0)
            .animation(.default, value: self.viewModel.isShowDateOfJoiningPicker)
            // Designation Picker
            DesignationPickerView(
                isShowPicker: self.$viewModel.isShowDesignationPicker,
                values: self.viewModel.desigations ?? [],
                onPress: { designation in
                    self.viewModel.designation = designation.name ?? ""
                    self.viewModel.designationId = designation.id ?? ""
                }
            )
            .opacity(self.viewModel.isShowDesignationPicker ? 1 : 0)
            .animation(.default, value: self.viewModel.isShowDesignationPicker)
            // Department Picker
            DesignationPickerView(
                isShowPicker: self.$viewModel.isShowDepartmentPicker,
                values: self.viewModel.departments ?? [],
                onPress: { department in
                    self.viewModel.department = department.name ?? ""
                    self.viewModel.departmentId = department.id ?? ""
                }
            )
            .opacity(self.viewModel.isShowDepartmentPicker ? 1 : 0)
            .animation(.default, value: self.viewModel.isShowDepartmentPicker)
        }
        .alert(isPresented: self.$viewModel.isShowErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(self.viewModel.errorMessage),
                dismissButton: .default(Text("OK"), action: {
                    if (self.viewModel.isUnauthorized) {
                        self.viewModel.isUnauthorized = false
                        Utilities.shared.removeTheUser(router: self.router)
                    }
                })
            )
        }
    }
}

#Preview {
    AddEmployeeView()
}
