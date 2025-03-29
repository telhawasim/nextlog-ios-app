//
//  TabbarView.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct TabbarView: View {
    
    //MARK: - PROPERTIES -
    
    //EnvironmentObject
    @EnvironmentObject var router: Routing
    //StateObject
    @StateObject var viewModel: TabbarView.ViewModel
    //State
    @State private var selectedTab: TabbarType = .home
    
    //MARK: - VIEWS -
    var body: some View {
        ZStack(alignment: .bottom) {
            switch self.selectedTab {
            case .home:
                HomeView(
                    viewModel: HomeView.ViewModel(),
                    selectedTab: self.$selectedTab
                )
            case .employees:
                EmployeesView()
            case .logout:
                EmptyView()
            }
            CustomTabbarView(
                selectedTab: self.$selectedTab
            )
            .padding(.bottom, -10)
        }
        .animation(.default.speed(1.5), value: self.selectedTab)
        .onChange(of: self.selectedTab) { (oldValue, newValue) in
            if (newValue == .logout) {
                self.removeUserData()
            }
        }
    }
}

//MARK: - FUNCTIONS -
extension TabbarView {
    
    //MARK: - REMOVE USER DATA -
    private func removeUserData() {
        AppStorage.accessToken = nil
        AppStorage.user = nil
        
        self.router.reset()
        self.router.push(.login(LoginView.ViewModel()))
    }
}

#Preview {
    TabbarView(
        viewModel: TabbarView.ViewModel()
    )
}
