//
//  ContentView.swift
//  CustomViewModifier
//
//  Created by Kiselov, Oleksandr on 1/14/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Color.yellow
            .ignoresSafeArea()
            .overlay(
                Text("Hello, world!")
                    .largeBlueFont()
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
