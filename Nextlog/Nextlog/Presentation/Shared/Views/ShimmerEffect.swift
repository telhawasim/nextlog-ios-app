//
//  ShimmerEffect.swift
//  Nextlog
//
//  Created by Telha Wasim on 21/03/2025.
//

import SwiftUI

struct ShimmerEffect: View {
    
    //MARK: - PROPERTIES -
    
    //State
    @State private var startPoint: UnitPoint = .init(x: -1.8, y: -1.2)
    @State private var endPoint: UnitPoint = .init(x: 0, y: -0.2)
    //Normal
    private var gradientColors = [
        Color.gray.opacity(0.2),
        Color.white.opacity(0.2),
        Color.gray.opacity(0.2)
    ]
    
    //MARK: - VIEWS -
    var body: some View {
        LinearGradient(
            colors: self.gradientColors,
            startPoint: self.startPoint,
            endPoint: self.endPoint
        )
        .onAppear {
            withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: false)) {
                self.startPoint = .init(x: 1, y: 1)
                self.endPoint = .init(x: 2.2, y: 2.2)
            }
        }
    }
}

#Preview {
    ShimmerEffect()
}
