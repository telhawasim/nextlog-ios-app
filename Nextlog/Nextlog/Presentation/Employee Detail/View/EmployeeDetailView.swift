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
        ZStack {
            // Geometry Reader
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
                                if (AppStorage.user?.role == RoleType.admin.rawValue) {
                                    EmployeeDetailButtonView(
                                        image: ImageEnum.icResume.rawValue,
                                        onPress: {
                                            self.viewModel.isShowProfilePopup = true
                                        }
                                    )
                                }
                            }
                            // Spacer
                            Spacer()
                            // Information and Delete Button
                            HStack {
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
                                // Spacer
                                Spacer()
                                // Delete Button
                                if (AppStorage.user?.role == RoleType.admin.rawValue) {
                                    EmployeeDetailButtonView(
                                        image: ImageEnum.icDelete.rawValue,
                                        color: .red,
                                        onPress: {
                                            self.viewModel.isShowDeleteProfilePopup = true
                                        }
                                    )
                                }
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
                            if profiles.count > 0 {
                                ScrollView {
                                    LazyVStack(spacing: 20) {
                                        ForEach(Array(profiles.enumerated()), id: \.element.id) { (index, profile) in
                                            EmployeeDetailCVListView(
                                                index: index,
                                                profile: profile,
                                                onPressOption: {
                                                    self.viewModel.selectedIndex = index
                                                    self.viewModel.isShowOptionSheet = true
                                                }
                                            )
                                            .onTapGesture {
                                                let id = self.viewModel.model?.profiles?[index].id ?? ""
                                                self.navigateToProfileDetail(id: id)
                                            }
                                        }
                                    }
                                    .padding(.all, 1)
                                    .padding(.top, 24)
                                }
                            } else {
                                // Spacer
                                Spacer()
                                // Empty State
                                EmployeeDetailEmptyStateView(
                                    role: AppStorage.user?.role ?? "",
                                    onPress: {
                                        self.viewModel.isShowProfilePopup = true
                                    }
                                )
                                // Spacer
                                Spacer()
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
            // Create Profile Popup
            CreateProfilePopUpView(
                isShowPopUp: self.$viewModel.isShowProfilePopup,
                value: self.$viewModel.profileName,
                onPressDone: {
                    self.viewModel.addProfileAPI()
                }
            )
            // Delete Profile Popup
            DeleteProfilePopUpView(
                isShowPopup: self.$viewModel.isShowDeleteProfilePopup,
                onPressYes: {
                    self.viewModel.deleteEmployeeAPI { isSuccess in
                        if (isSuccess) {
                            self.router.pop()
                        }
                    }
                }
            )
            // Loader
            LoaderView()
                .opacity(self.viewModel.isLoading ? 1 : 0)
        }
        .animation(.default, value: self.viewModel.isShowProfilePopup)
        .animation(.default, value: self.viewModel.isLoading)
        // Error Alert for the user
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
        .sheet(isPresented: self.$viewModel.isShowOptionSheet) {
            EmployeeDetailOptionsView(
                index: self.$viewModel.selectedIndex,
                onPressEdit: {
                    let id = self.viewModel.model?.profiles?[self.viewModel.selectedIndex].id ?? ""
                    self.navigateToCreateProfile(id: id)
                    self.viewModel.isShowOptionSheet = false
                },
                onPressDelete: {
                    let id = self.viewModel.model?.profiles?[self.viewModel.selectedIndex].id ?? ""
                    self.viewModel.deleteProfileAPI(id: id)
                }
            )
            .presentationDragIndicator(.visible)
            .overlay {
                GeometryReader { proxy in
                    Color.clear.preference(key: InnerHeightPreferenceKey.self, value: proxy.size.height)
                }
            }
            .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
                self.viewModel.sheetHeight = newHeight
            }
            .presentationDetents([.height(self.viewModel.sheetHeight)])
            .presentationBackground(.clear)
            .presentationCornerRadius(30)
        }
        .task {
            self.fetchEmployeeProfileImage()
        }
    }
}

//MARK: - FUNCTIONS -
extension EmployeeDetailView {
    
    //MARK: - FETCH EMPLOYEE PROFILE IMAGE -
    private func fetchEmployeeProfileImage() {
        Utilities.shared.fetchImage(from: self.viewModel.model?.avatar ?? "") { image in
            if let userImage = image {
                self.userImage = userImage
            } else {
                self.userImage = UIImage(named: ImageEnum.icUserPlaceholder.rawValue)!
            }
        }
    }
    
    //MARK: - SET REQUIRED PHONE NUMBER -
    private func setRequiredPhoneNumber() -> String {
        guard let phone = self.viewModel.model?.phone, phone.hasPrefix("+92") else {
            return ""
        }
        
        return String(phone.dropFirst(3))
    }
    
    //MARK: - NAVIGATE TO CREATE PROFILE -
    private func navigateToCreateProfile(id: String) {
        let viewModel = CreateProfileView.ViewModel(
            profileID: id,
            name: self.viewModel.model?.name ?? "",
            email: self.viewModel.model?.email ?? "",
            phone: Utilities.shared.removeThePrefixFromPhoneNumber("+92", self.viewModel.model?.phone),
            designation: self.viewModel.model?.designation?.name ?? "",
            designationID: self.viewModel.model?.designation?.id ?? ""
        )
        self.router.push(.createProfile(viewModel))
    }
    
    //MARK: - NAVIGATE TO PROFILE DETAIL -
    private func navigateToProfileDetail(id: String) {
        let viewModel = ProfileDetailView.ViewModel(
            profileID: id
        )
        self.router.push(.profileDetail(viewModel))
    }
}

#Preview {
    EmployeeDetailView(
        viewModel: EmployeeDetailView.ViewModel(employeeId: "")
    )
}
