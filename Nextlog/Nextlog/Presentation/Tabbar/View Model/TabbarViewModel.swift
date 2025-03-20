//
//  TabbarViewModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

extension TabbarView {
    
    //MARK: - VIEW MODEL -
    class ViewModel: BaseViewModel {
        
        //MARK: - PROPERTIES -
        
        //Normal
        let container: DependencyContainer
        
        //MARK: - INITIALIZER -
        init(container: DependencyContainer) {
            self.container = container
        }
    }
}
