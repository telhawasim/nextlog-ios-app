//
//  EmployeesView.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct EmployeesView: View {
    
    //MARK: - PROPERTIES -
    
    //EnvironmentObject
    @EnvironmentObject var router: Routing
    //StateObject
    @StateObject var viewModel: EmployeesView.ViewModel
    //State
    @State private var search: String = ""
    
    //MARK: - VIEWS -
    var body: some View {
        // Main View
        VStack(spacing: 0) {
            // Name and Add Employee Button
            HStack {
                // Name
                Text("Employees")
                    .font(.getBold(FontSize.h20))
                // Spacer
                Spacer()
                // Add Employee Button
                HomeAddEmployeeButtonView(
                    onPress: {
                        self.navigateToAddEmployee()
                    }
                )
            }
            // Logo, Textfield and Filter Button
            HStack(spacing: 10) {
                // Logo
                Image(systemName: ImageEnum.icMagnifyingGlass.rawValue)
                    .resizable()
                    .frame(width: 19, height: 19)
                // Search TextField
                TextField(text: self.$search, label: {
                    Text("Search...")
                        .font(.getMedium())
                })
                // Spacer
                Spacer()
                // Filter Button
                Button(action: {
                    
                }, label: {
                    Image(ImageEnum.icFilter.rawValue)
                        .resizable()
                        .frame(width: 19, height: 19)
                })
            }
            .frame(height: 50)
            .padding(.horizontal, 20)
            .background(Color.colorF7F7F7)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .padding(.top, 25)
            // Listing
            if let employees = self.viewModel.model?.employees {
                if employees.count > 0 {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(spacing: 20) {
                            ForEach(employees, id: \.id) { employee in
                                HomeEmployeeListRowView(employee: employee)
                            }
                        }
                        .padding(.top, 18)
                    }
                } else {
                    // Spacer
                    Spacer()
                    // Empty State
                    AppEmptyState(emptyState: .employeeListing)
                        .padding(.bottom, 65)
                    // Spacer
                    Spacer()
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 20) {
                        ForEach(0...10, id: \.self) { index in
                            HomeEmployeeListRowShimmerView()
                        }
                    }
                    .padding(.top, 18)
                }
                .disabled(true)
            }
        }
        .padding(.top, 10)
        .padding(.horizontal, 16)
    }
}

//MARK: - FUNCTIONS -
extension EmployeesView {
    
    //MARK: - NAVIGATE TO ADD EMPLOYEE -
    private func navigateToAddEmployee() {
        let viewModel = AddEmployeeView.ViewModel()
        self.router.push(.addEmployee(viewModel))
    }
    
    //MARK: - NAVIGATE TO EMPLOYEE DETAILS -
    private func navigateToEmployeeDetails() {
        //        let viewModel = EmployeeDetailView.ViewModel(container: self.)
    }
}

#Preview {
    EmployeesView(
        viewModel: EmployeesView.ViewModel()
    )
}
