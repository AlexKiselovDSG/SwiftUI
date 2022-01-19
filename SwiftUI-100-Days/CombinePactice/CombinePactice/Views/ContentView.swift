//
//  ContentView.swift
//  CombinePactice
//
//  Created by Kiselov, Oleksandr on 1/18/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var manager = Manager()
    
    var rows = [GridItem(.fixed(130)),GridItem(.fixed(130))]
    var body: some View {
        VStack {
            Text("Score: \(manager.score)")
            Text(manager.level == 0 ? "Find or Lose" : "Level \(manager.level)")
                .font(.title)
                .fontWeight(.bold)
            LazyHGrid(rows: rows) {
                ForEach(Array(zip(manager.gameImages.indices, manager.gameImages)), id:\.0) {_, gameImage in
                    GeometryReader{ proxy in
                        gameImage.image
                    .resizable()
                    .scaledToFill()
                    .frame(width: proxy.size.width)
                    }
                    .clipped()
                    .aspectRatio(1, contentMode: .fit)
                    .shadow(radius: 5)
                    .onTapGesture {
                        manager.click(on: gameImage)
                    }
            }
            }
            Button {
                manager.changeGameState()
            } label: {
                Text(manager.isPlay ? "Stop" : "Start")
                    .frame(width: 150)
            }
            .buttonStyle(.bordered)
            
        }
        .alert(item: $manager.error) { error in
            Alert(title: Text("Game Error"),
                  message: Text(error.errorDescription),
                  dismissButton: .cancel())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
