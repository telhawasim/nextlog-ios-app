//
//  TabbarView.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct TabbarView: View {
    
    //MARK: - PROPERTIES -
    
    @StateObject var viewModel: TabbarView.ViewModel
    //State
    @State private var selectedTab: TabbarType = .home
    
    //MARK: - VIEWS -
    var body: some View {
        ZStack(alignment: .bottom) {
            switch self.selectedTab {
            case .home:
                HomeView(viewModel: HomeView.ViewModel(container: self.viewModel.container))
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
    }
}

#Preview {
    TabbarView(
        viewModel: TabbarView.ViewModel(container: DependencyContainer())
    )
}
