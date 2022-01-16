//
//  SelectionCard.swift
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

struct SelectionCardView: View {
    let animals = ["buffalo", "chick", "crocodile", "chicken", "dog",
                   "duck", "elephant", "frog", "giraffe", "goat",
                   "gorilla", "hippo", "horse", "monkey", "moose",
                   "narwhal", "owl", "panda", "parrot", "penguin",
                   "pig", "rabbit", "rhino", "sloth", "snake",
                   "walrus", "whale", "zebra"].shuffled()
    let columns = Array(repeating: GridItem(), count: 4)
    @State private var isShowingButtons = false
    @State private var isShowingStepper = false
    @State private var isShowingTable = false
    @State private var problemCount = 5
    @State private var currentTable = 1
    @State private var result = Result()
    func restart() {
        result = Result()
        isShowingButtons = true
        isShowingStepper = true
        isShowingTable = false
    }
    func generateQuestions(for table: Int, count: Int) -> [Question] {
        var questions = [Question]()
        let range = 1..<13
        for _ in 0..<count {
            let factor = range.randomElement()!
            questions.append(Question(text: "What is \(table) x \(factor)?", answer: table*factor))
        }
        return questions
    }
    var body: some View {
        ZStack {
            StatusView(result: $result, restart: restart)
            if isShowingTable {
                MultTableView(questions: generateQuestions(for: currentTable, count: problemCount),
                              result: $result, isShow: $isShowingTable)
                    .transition(.move(edge: .bottom))
            }
            VStack(spacing: 10) {
                LazyVGrid(columns: columns, content: {
                    ForEach(0..<12) {index in
                        Button(action: {
                            isShowingButtons = false
                            isShowingStepper = false
                            withAnimation(.default.delay(1.2)) {
                                isShowingTable = true
                            }
                            currentTable = index+1
                        }, label: {
                            VStack(spacing: 0) {
                                Image(animals[index])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(minWidth: 50, idealWidth: 60, maxWidth: 80,
                                           minHeight: 50, idealHeight: 60, maxHeight: 80)
                                    .padding(10)
                                Text("x \(index+1)")
                                    .font(.title)
                                    .foregroundColor(.black)
                            }
                        })
                            .background(Color.white.opacity(0.6), in: RoundedRectangle(cornerRadius: 10))
                            .tint(.black)
                            .shadow(radius: 5)
                            .contentShape(Rectangle())
                            .offset(y: isShowingButtons ? 0.0 : -1000.0)
                            .animation(Animation.spring(response: 0.2,
                                                        dampingFraction: 0.8,
                                                        blendDuration: 0.2)
                                        .delay(Double(index+1)*0.1),
                                       value: isShowingButtons)
                    }
                    .padding()
                })
                StepperView(problemCount: $problemCount)
                    .offset(y: isShowingStepper ? 0.0 : 1000.0)
                    .animation(Animation.spring(response: 0.9,
                                                dampingFraction: 0.8,
                                                blendDuration: 0.9),
                               value: isShowingStepper)
            }
            .padding(.top, 50)
            .zIndex(5)
        }
        .onChange(of: isShowingTable, perform: { val in
            if !val {
                isShowingButtons = true
                isShowingStepper = true
            }
        })
        .onAppear(perform: {
            isShowingButtons = true
            isShowingStepper = true
        })
    }
}

struct SelectionCard_Previews: PreviewProvider {
    static var previews: some View {
        SelectionCardView()
    }
}
