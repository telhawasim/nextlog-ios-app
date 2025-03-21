//
//  AddEmployeeViewModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import Foundation
import SwiftUI

extension AddEmployeeView {
    
    //MARK: - VIEW MODEL -
    class ViewModel: BaseViewModel {
        
        //MARK: - PROPERTIES -
        
        //Normal
        let container: DependencyContainer
        //Published
        @Published var isShowActionSheet: Bool = false
        @Published var isShowingImagePicker: Bool = false
        @Published var selectedImage: UIImage?
        @Published var sourceType: UIImagePickerController.SourceType = .camera
        @Published var isShowDOBDatePicker: Bool = false
        @Published var isShowDateOfJoiningPicker: Bool = false
        
        //MARK: - INITIALIZER -
        init(container: DependencyContainer) {
            self.container = container
        }
    }
}

//MARK: - FUNCTIONS -
extension AddEmployeeView.ViewModel {
    
}
