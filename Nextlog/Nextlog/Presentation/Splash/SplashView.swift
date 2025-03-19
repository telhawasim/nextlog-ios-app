//
//  SplashView.swift
//  Nextlog
//
//  Created by Telha Wasim on 19/03/2025.
//

import SwiftUI

struct SplashView: View {
    
    //MARK: - PROPERTIES -
    
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
                    case .login:
                        LoginView()
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.isShowSplash = false
                self.router.push(.login)
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(Routing())
}
