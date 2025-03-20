//
//  HomeView.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: - PROPERTIES -
    
    //Environment
    @Environment(\.colorScheme) var colorScheme
    //EnvironmentObject
    @EnvironmentObject var router: Routing
    //StateObject
    @StateObject var viewModel: HomeView.ViewModel
    //Normal
    var isShowListing: Bool = false
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        ScrollView(.vertical, showsIndicators: false) {
            // Main View
            VStack(spacing: 0) {
                // Name and Add Employee Button
                HStack {
                    // Name
                    Text("Hello, Admin!")
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
                // Background, Total Employees and Logo
                ZStack {
                    // Background
                    RoundedRectangle(cornerRadius: 11.0)
                        .frame(maxWidth: .infinity, minHeight: 214, maxHeight: 214)
                    // Info and Logo
                    HStack {
                        // Info
                        VStack(alignment: .leading, spacing: 30) {
                            // Circle and Image
                            ZStack {
                                // Circle
                                Circle()
                                    .frame(width: 65)
                                    .foregroundStyle(Color.color808080)
                                // Image
                                Image(ImageEnum.icBrief.rawValue)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(Color.white)
                            }
                            // Total Employees and Title
                            VStack(alignment: .leading) {
                                // Total Employee
                                Text("0")
                                    .foregroundStyle(self.colorScheme == .dark ? Color.black : Color.white)
                                    .font(.getBold(.h40))
                                // Title
                                Text("Total Employees")
                                    .foregroundStyle(self.colorScheme == .dark ? Color.black : Color.white)
                                    .font(.getMedium(.h14))
                            }
                        }
                        // Spacer
                        Spacer()
                        // Logo
                        Image(ImageEnum.icLogo.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(self.colorScheme == .dark ? Color.black : Color.white)
                            .frame(width: 90, height: 90)
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.top, 25)
                // Employees and View All Button
                HStack {
                    // Employees
                    Text("Employees")
                        .font(.getSemibold(.h22))
                    // Spacer
                    Spacer()
                    // View All Button
                    Button(action: {
                        
                    }, label: {
                        Text("View All")
                            .font(.getMedium(.h16))
                            .foregroundStyle(Color.black)
                    })
                }
                .padding(.top, 27)
                if (self.isShowListing) {
                    // Listing
                    LazyVStack(spacing: 20) {
                        ForEach(0...4, id: \.self) { index in
                            HomeEmployeeListRowView()
                                .padding(.bottom, index == 4 ? 65 : 0)
                        }
                    }
                    .padding(.top, 18)
                } else {
                    AppEmptyState(emptyState: .employeeListing)
                        .padding(.top, 50)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
        }
    }
}

//MARK: - FUNCTIONS -
extension HomeView {
    
    //MARK: - NAVIGATE TO ADD EMPLOYEE -
    private func navigateToAddEmployee() {
        let viewModel = AddEmployeeView.ViewModel(container: self.viewModel.container)
        self.router.push(.addEmployee(viewModel))
    }
}

#Preview {
    HomeView(
        viewModel: HomeView.ViewModel(container: DependencyContainer())
    )
}
