//
//  EmployeesView.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct EmployeesView: View {
    
    //MARK: - PROPERTIES -
    
    @EnvironmentObject var router: Routing
    //State
    @State private var search: String = ""
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        ScrollView(.vertical, showsIndicators: false) {
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
                LazyVStack(spacing: 20) {
                    ForEach(0...10, id: \.self) { index in
                        HomeEmployeeListRowView()
                            .onTapGesture {
                                self.router.push(.employeeDetails)
                            }
                    }
                }
                .padding(.top, 18)
            }
            .padding(.top, 10)
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    EmployeesView()
}
