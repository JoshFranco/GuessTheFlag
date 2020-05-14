//
//  Shake.swift
//  GuessTheFlag
//
//  Created by Josh Franco on 5/14/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import SwiftUI

struct Shake: GeometryEffect {
    var amonut: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat
    
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: amonut * sin(animatableData * .pi * CGFloat(shakesPerUnit)), y: 0))
    }
}

// MARK: - Extension
extension View {
    func shake(for attempts: Int) -> some View {
        self.modifier(Shake(animatableData: CGFloat(attempts)))
    }
}

// MARK: - Example
struct ShakeExample: View {
    @State private var attemtps = 0
    
    var body: some View {
        Button("Test Shake") {
            withAnimation {
                self.attemtps += 1
            }
        }
        .frame(width: 200, height: 125)
        .background(Color.red)
        .foregroundColor(.white)
        .shake(for: attemtps)
    }
    
}

struct ShakeExample_Previews: PreviewProvider {
    static var previews: some View {
        ShakeExample()
    }
}
