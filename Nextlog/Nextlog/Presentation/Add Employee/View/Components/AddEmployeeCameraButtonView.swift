//
//  AddEmployeeCameraButtonView.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct AddEmployeeCameraButtonView: View {
    
    //MARK: - PROPERTIES -
    
    //Normal
    var onPress: (() -> Void)?
    
    //MARK: - VIEWS -
    var body: some View {
        // Camera Button
        Button(action: {
            self.onPress?()
        }, label: {
            ZStack {
                Circle()
                    .frame(width: 42)
                    .foregroundStyle(Color.color808080)
                Image(ImageEnum.icCamera.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.white)
            }
        })
    }
}

#Preview {
    AddEmployeeCameraButtonView()
}
