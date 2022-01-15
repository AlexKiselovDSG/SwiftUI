//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Kiselov, Oleksandr on 1/14/22.
//

import SwiftUI

struct FlagImageView: View {
    let country: String
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImageView(country: "US")
    }
}
