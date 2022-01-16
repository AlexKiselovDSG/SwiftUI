//
//  StarsView.swift
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

struct StarsView: View {
    var result: Result
    var reset: () -> Void
    @State private var stars = -1
    func getText(for stars: Int) -> String {
        switch stars {
        case 0: return "You must learn multiplication tables!"
        case 1: return "Step by step you will rich your goal."
        case 2: return "Don't give up."
        case 3: return "You need more practice."
        case 4: return "Good Job."
        case 5: return "Well Done!"
        default:
            return "See you next time"
        }
    }
    var body: some View {
        VStack(spacing: 30) {
            Text(getText(for: stars))
                .font(.title)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
            if stars >= 0 {
            HStack {
            ForEach(0..<stars) {_ in
               Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.yellow)
            }
            ForEach(0..<5-stars) {_ in
               Image(systemName: "star")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.yellow)
            }
        }
        .shadow(radius: 2)
            }
            Button(action: {
        reset()
            }, label: {Text("OK")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(20)
                    .frame(width: 120)
            })
                .background(Color.darkGreen)
                .cornerRadius(10)
                .shadow(radius: 5)
                .contentShape(Rectangle())
        }.padding()
            .background(Color.white.opacity(0.5))
            .cornerRadius(20)
            .onAppear(perform: {
                print("Result: \(result)")
                let total = result.correct + result.wrong
                if total > 0 {
                stars = Int((Double(result.correct) / Double(total) * 5).rounded(.up))
                }
                print("Stars: \(stars)")
            })
    }
}

struct StarsView_Previews: PreviewProvider {
    static var previews: some View {
        StarsView( result: Result(wrong: 0, correct: 5), reset: {})
    }
}
