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
    //State
    @State var userImage: UIImage?
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        GeometryReader { proxy in
            // Main View
            VStack(spacing: 0) {
                // Image, Background, Information and Buttons
                ZStack {
                    // Profile Image
                    if let userImage = self.userImage {
                        Image(uiImage: userImage)
                            .resizable()
                            .frame(width: proxy.size.width, height: proxy.size.height * 0.4)
                    }
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
                            Text(self.viewModel.model?.name ?? "")
                                .font(.getBold(.h20))
                                .foregroundStyle(Color.white)
                            // Designation
                            Text(self.viewModel.model?.designation?.name ?? "")
                                .font(.getMedium())
                                .foregroundStyle(Color.white)
                            // Email
                            Text(verbatim: self.viewModel.model?.email ?? "")
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
                    if let profiles = self.viewModel.model?.profiles {
                        ScrollView {
                            LazyVStack(spacing: 20) {
                                ForEach(profiles, id: \.id) { profile in
                                    EmployeeDetailCVListView()
                                }
                            }
                            .padding(.all, 1)
                            .padding(.top, 24)
                        }
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 20) {
                                ForEach(0...2, id: \.self) { index in
                                    EmployeeDetailCVListShimmerView()
                                }
                            }
                            .padding(.all, 1)
                            .padding(.top, 24)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 25)
            }
        }
        .ignoresSafeArea(edges: .top)
        .task {
            self.fetchEmployeeProfileImage()
        }
    }
}

//MARK: - FUNCTIONS -
extension EmployeeDetailView {
    
//    //MARK: - FETCH EMPLOYEE PROFILE IMAGE -
    private func fetchEmployeeProfileImage() {
        Utilities.shared.fetchImage(from: self.viewModel.model?.avatar ?? "") { image in
            if let userImage = image {
                self.userImage = userImage
            } else {
                self.userImage = UIImage(named: ImageEnum.icUserPlaceholder.rawValue)!
            }
        }
    }
}

#Preview {
    EmployeeDetailView(
        viewModel: EmployeeDetailView.ViewModel(employeeId: "")
    )
}
