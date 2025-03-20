//
//  AppEmptyState.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct AppEmptyState: View {
    
    //MARK: - PROPERTIES -
    
    //MARK: - VIEWS -
    var body: some View {
        Image(ImageEnum.icEmployeeEmptyState.rawValue)
            .foregroundStyle(Color.color808080)
    }
}

#Preview {
    AppEmptyState()
}
