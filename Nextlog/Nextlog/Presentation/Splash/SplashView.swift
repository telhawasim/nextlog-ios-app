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
    //Normal
    var container: DependencyContainer
    
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
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.isShowSplash = false
                self.navigateToLogin()
            }
        }
    }
}

//MARK: - FUNCTIONS -
extension SplashView {
    
    //MARK: - NAVIGATE TO LOGIN -
    private func navigateToLogin() {
        let viewModel = LoginView.ViewModel(container: self.container)
        self.router.push(.login(viewModel))
    }
}

#Preview {
    SplashView(
        container: DependencyContainer()
    )
        .environmentObject(Routing())
}
