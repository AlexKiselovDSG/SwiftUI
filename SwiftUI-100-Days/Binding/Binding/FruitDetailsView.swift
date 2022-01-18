//
//  EditFruits.swift
//  Binding
//
//  Created by Kiselov, Oleksandr on 1/18/22.
//

import SwiftUI

struct FruitDetailsView: View {
    let fruit: String
    @Binding var isActive: Bool
    var body: some View {
        
        VStack{
            Spacer()
            Text(fruit)
                .font(.title)
                .padding()
            Button(action: {
                isActive = false
            }, label: {
                Text("Close")
            })
                .buttonStyle(.borderedProminent)
            Spacer()
        }
        
    }
    
}

struct EditFruits_Previews: PreviewProvider {
    static var previews: some View {
        FruitDetailsView(fruit: "Orange", isActive: .constant(true))
    }
}
