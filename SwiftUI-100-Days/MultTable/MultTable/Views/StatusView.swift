//
//  StatusView.swift
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

struct Result {
    var wrong: Int = 0
    var correct: Int = 0
}

struct StatusView: View {
    @Binding var result: Result
    var restart: () -> Void
    var body: some View {
        VStack {
        HStack {
            HStack {
            Image(systemName: "checkmark.square.fill")
                .foregroundColor(.green)
                .imageScale(.large)
                Text("\(result.correct)")
            }.padding(8)
            .background(Color.white.opacity(0.6), in: RoundedRectangle(cornerRadius: 10))
        Spacer()
            Button(action: {
                restart()
            }, label: {
                Text("Restart".capitalized)
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(8)
            })
                .background(Color.white.opacity(0.6), in: RoundedRectangle(cornerRadius: 10))
            Spacer()
            HStack {
                Text("\(result.wrong)")
            Image(systemName: "xmark.square.fill")
                .foregroundColor(.red)
                .imageScale(.large)
            }
            .padding(8)
            .background(Color.white.opacity(0.6), in: RoundedRectangle(cornerRadius: 10))
        }

        .padding()
            Spacer()
        }
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView(result: .constant(Result(wrong: 0, correct: 0)), restart: {})
    }
}
