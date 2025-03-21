//
//  ImagePicker.swift
//  Nextlog
//
//  Created by Telha Wasim on 21/03/2025.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    
    //MARK: - PROPERTIES -
    
    //Normal
    var sourceType: UIImagePickerController.SourceType
    var onImagePicked: (UIImage) -> Void
    //Environment
    @Environment(\.presentationMode) private var presentationMode

    //MARK: - MAKE UI VIEWCONTROLLER -
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    //MARK: - UPDATE UI VIEWCONTROLLER -
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    //MARK: - MAKE CONTROLLER -
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    //MARK: - COORDINATOR -
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        //MARK: - PROPERTIES -
        let parent: ImagePicker

        //MARK: - INITIALIZER -
        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                self.parent.onImagePicked(image)
            }
            self.parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
