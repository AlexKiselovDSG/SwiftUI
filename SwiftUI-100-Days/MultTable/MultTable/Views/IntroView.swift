//
//  Intro.swift
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

struct IntroView: View {
    let sunGradient = Gradient(stops: [
        .init(color: Color(UIColor.orange), location: 0),
        .init(color: Color(UIColor.yellow).opacity(0.01), location: 1)
    ])
    let skyGradient = LinearGradient(colors: [.white, .blue], startPoint: .topTrailing, endPoint: .bottom)
    let grassGradient = Gradient(colors: [ .darkGreen, .green])
    @State private var showCows = false
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                skyGradient
                Circle()
                    .foregroundStyle(.radialGradient(sunGradient,
                                                     center: .center,
                                                     startRadius: 10,
                                                     endRadius: proxy.size.width*0.3))
                    .frame(width: proxy.size.width*0.6, height: proxy.size.width*0.6)
                    .position(x: proxy.size.width*0.85, y: proxy.size.height*0.07)
                Circle()
                    .foregroundStyle(.radialGradient(grassGradient, center: .center, startRadius: 200, endRadius: 400))
                    .frame(width: proxy.size.height, height: proxy.size.height)
                    .position(x: proxy.size.width*0.5, y: proxy.size.height)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }.ignoresSafeArea()
            .onAppear(perform: {
                showCows = true
            })
    }
}

extension Color {
    static let darkGreen = Color(red: 0, green: 0.5, blue: 0)
}

struct Intro_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
