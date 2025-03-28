//
//  SplashView.swift
//  Nextlog
//
//  Created by Telha Wasim on 19/03/2025.
//

import SwiftUI

struct SplashView: View {
    
    //MARK: - PROPERTIES -
    
    //EnvironmentObject
    @EnvironmentObject var router: Routing
    //State
    @State private var isShowSplash: Bool = true
    
    //MARK: - VIEWS -
    var body: some View {
        NavigationStack(path: self.$router.path) {
            // Main View
            VStack {
                // Logo
                Image(ImageEnum.icLogo.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
            }
            .navigationDestination(for: ScreenType.self) { screen in
                Group {
                    switch screen {
                    case .login(let viewModel):
                        LoginView(viewModel: viewModel)
                    case .tabbar(let viewModel):
                        TabbarView(viewModel: viewModel)
                    case .employeeDetails(let viewModel):
                        EmployeeDetailView(viewModel: viewModel)
                    case .addEmployee(let viewModel):
                        AddEmployeeView(viewModel: viewModel)
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.isShowSplash = false
                if let _ = AppStorage.user {
                    self.navigateToTabbar()
                } else {
                    self.navigateToLogin()
                }
            }
        }
    }
}

//MARK: - FUNCTIONS -
extension SplashView {
    
    //MARK: - NAVIGATE TO LOGIN -
    private func navigateToLogin() {
        let viewModel = LoginView.ViewModel()
        self.router.push(.login(viewModel))
    }
    
    //MARK: - NAVIGATE TO TABBAR -
    private func navigateToTabbar() {
        let viewModel = TabbarView.ViewModel()
        self.router.push(.tabbar(viewModel))
    }
}

#Preview {
    SplashView()
        .environmentObject(Routing())
}
