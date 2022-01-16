//
//  ContentView.swift
//  MultTable
//  Toolchain Swift version: 5.0
//
//  Created by Alex Kiselov on 1/15/22.
//  Vamrad LLC
//	www.vamrad.com
//
//  
//
//  

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Workaroound. To disable Keyboard Avoidance feature.
        GeometryReader {_ in
            ZStack {
                IntroView()
                SelectionCardView()
            }
        }
        .ignoresSafeArea(.keyboard)
        .statusBar(hidden: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
