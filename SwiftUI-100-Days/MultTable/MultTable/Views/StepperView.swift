//
//  StepperView.swift
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

struct StepperView: View {
    @Binding var problemCount: Int
    @State private var stepperIndex = 0
    let problemCountPreset = [5, 10, 20]
    func increment() {
        stepperIndex += 1
        if stepperIndex >= problemCountPreset.count {
            stepperIndex = 0
        }
        problemCount = problemCountPreset[stepperIndex]
    }
    func decrement() {
        stepperIndex -= 1
        if stepperIndex < 0 {
            stepperIndex = problemCountPreset.count - 1
        }
        problemCount = problemCountPreset[stepperIndex]
    }
    var body: some View {
        VStack {
            Text("How many problems to solve today?")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(.white)
            HStack(spacing: 30) {
                Button(action: {
                    decrement()
                }, label: {
                    VStack(spacing: 0) {
                        Image("cow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaleEffect(0.7)
                        Text("-")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                })
                    .frame(width: 100, height: 100)
                    .contentShape(Rectangle())
                Image(systemName: "\(problemCount).circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.white)
                Button(action: {
                    increment()
                }, label: {
                    VStack(spacing: 0) {
                        Image("cow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("+")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                })
                    .frame(width: 100, height: 100)
                    .contentShape(Rectangle())
            }
        }
        .shadow(radius: 5)
        .onAppear {
            problemCount = problemCountPreset[stepperIndex]
        }
    }
}

struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView(problemCount: .constant(5))
    }
}
