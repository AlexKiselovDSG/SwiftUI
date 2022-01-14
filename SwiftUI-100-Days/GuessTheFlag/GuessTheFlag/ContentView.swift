//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kiselov, Oleksandr on 1/13/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
//            VStack(spacing: 0) {
//                Color.red
//                Color.blue
//            }

//            Text("Your content")
//                .foregroundStyle(.secondary)
//                .padding(50)
//                .background(.ultraThinMaterial)
//
            VStack {
                Button("Button 1") { }
                    .buttonStyle(.bordered)
                Button("Button 2", role: .destructive) { }
                    .buttonStyle(.bordered)
                Button("Button 3") { }
                    .buttonStyle(.borderedProminent)
                    .tint(.mint)
                Button("Button 4", role: .destructive) { }
                    .buttonStyle(.borderedProminent)
                Button {
                    print("Edit button was tapped")
                } label: {
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                }
                
            }
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
