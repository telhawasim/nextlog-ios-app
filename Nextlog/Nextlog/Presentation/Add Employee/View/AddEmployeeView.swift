//
//  AddEmployeeView.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct AddEmployeeView: View {
    
    //MARK: - PROPERTIES -
    
    @State private var name: String = ""
    @State private var designation: String = ""
    @State private var department: String = ""
    @State private var dob: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var dateOfJoining: String = ""
    
    //MARK: - VIEWS -
    var body: some View {
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
                    Image("")
                        .frame(width: 142, height: 142)
                        .background(Color.color808080.opacity(0.2))
                        .clipShape(Circle())
                    // Camera Button
                    AddEmployeeCameraButtonView(
                        onPress: {
                            
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
                        value: self.$dob,
                        isDOB: true
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
                        value: self.$dateOfJoining,
                        isDOB: false
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
    }
}

#Preview {
    AddEmployeeView()
}
