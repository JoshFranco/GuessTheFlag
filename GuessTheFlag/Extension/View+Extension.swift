//
//  View+Extension.swift
//  GuessTheFlag
//
//  Created by Josh Franco on 5/9/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import SwiftUI

extension View {
    func flatImageStyle() -> some View {
        self.modifier(FlatImage())
    }
}
