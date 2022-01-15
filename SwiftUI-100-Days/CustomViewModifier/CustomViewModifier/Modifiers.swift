//
//  Modifiers.swift
//  CustomViewModifier
//
//  Created by Kiselov, Oleksandr on 1/14/22.
//

import SwiftUI

struct LargeBlueFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
            .padding(20)
            .background(.thinMaterial)
    }
}

extension View {
    func largeBlueFont() -> some View {
        modifier(LargeBlueFont())
    }
}
