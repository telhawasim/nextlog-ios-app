//
//  EmployeeDetailView.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct EmployeeDetailView: View {
    
    //MARK: - PROPERTIES -
    
    //EnvironmentObject
    @EnvironmentObject var router: Routing
    //StateObject
    @StateObject var viewModel: EmployeeDetailView.ViewModel
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        GeometryReader { proxy in
            // Main View
            VStack(spacing: 0) {
                // Image, Background, Information and Buttons
                ZStack {
                    // Background
                    Image(ImageEnum.icGradient.rawValue)
                        .resizable()
                        .frame(width: proxy.size.width, height: proxy.size.height * 0.4)
                    // Information and Buttons
                    VStack(alignment: .leading) {
                        // Back and Add Profile Button
                        HStack {
                            // Back Button
                            EmployeeDetailButtonView(
                                image: ImageEnum.icLeftArrow.rawValue,
                                onPress: {
                                    self.router.pop()
                                }
                            )
                            // Spacer
                            Spacer()
                            // Profile Button
                            EmployeeDetailButtonView(
                                image: ImageEnum.icResume.rawValue,
                                onPress: {
                                    
                                }
                            )
                        }
                        // Spacer
                        Spacer()
                        // Information
                        VStack(alignment: .leading, spacing: 7) {
                            // Name
                            Text("Telha Wasim")
                                .font(.getBold(.h20))
                                .foregroundStyle(Color.white)
                            // Designation
                            Text("iOS Developer")
                                .font(.getMedium())
                                .foregroundStyle(Color.white)
                            // Email
                            Text(verbatim: "telha.wasim@nxb.com.pk")
                                .font(.getRegular())
                                .foregroundStyle(Color.white)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 70)
                    .padding(.bottom, 30)
                }
                .frame(width: proxy.size.width, height: proxy.size.height * 0.4)
                // Title and Profiles
                VStack {
                    // Title
                    Text("Profiles")
                        .font(.getMedium(.h24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(0...2, id: \.self) { index in
                                EmployeeDetailCVListView()
                            }
                        }
                        .padding(.all, 1)
                        .padding(.top, 24)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 25)
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    EmployeeDetailView(
        viewModel: EmployeeDetailView.ViewModel(container: DependencyContainer(), employeeID: "")
    )
}
