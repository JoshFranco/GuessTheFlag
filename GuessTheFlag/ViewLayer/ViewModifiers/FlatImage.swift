//
//  FlatImage.swift
//  GuessTheFlag
//
//  Created by Josh Franco on 5/9/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import SwiftUI

struct FlatImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}
