//
//  ContentView.swift
//  Binding
//
//  Created by Kiselov, Oleksandr on 1/18/22.
//

import SwiftUI

struct ContentView: View {
    @State private var fruits = ["Orange", "Lemon", "Kiwi", "Apple"]
    @State private var isActive = false
    @State private var selectedFruit = ""
    var body: some View {
        NavigationView {
            VStack{
                NavigationLink(destination: FruitDetailsView(fruit: selectedFruit, isActive: $isActive),
                               isActive: $isActive, label: {})
                    .labelsHidden()
                VStack{
                    Text("Fruits")
                    ForEach(fruits, id: \.self) { fruit in
                        Button(action: {
                            selectedFruit = fruit
                            isActive = true
                            print(fruit)
                        }, label: {
                            Text(fruit)
                                .frame(width: 200)
                        })
                            .buttonStyle(.borderedProminent)
                        
                    }
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
