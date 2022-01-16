//
//  MultTableView.swift
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

struct Question {
    var text: String = ""
    var answer: Int = 0
}

struct MultTableView: View {
    let questions: [Question]
    @Binding var result: Result
    @Binding var isShow: Bool
    @State private var currentQuestion = Question()
    @State private var answer = ""
    @FocusState private var isFocused: Bool
    @State private var questionIndex = 0
    @State private var isAlert = false
    @State private var alertMessage = ""
    @State private var isShowingStars = false
    func nextQuestion() {
        answer = ""
        questionIndex += 1
        if questionIndex < questions.count {
            currentQuestion = questions[questionIndex]
        } else {
            isFocused = false
            isShowingStars = true
        }
    }
    func reset() {
        withAnimation {
            isShowingStars = false
            isShow = false
        }
        isFocused = false
    }
    var body: some View {
        ZStack {
            if isShowingStars {
                StarsView(result: result, reset: reset)
                    .padding()
            } else {
                VStack {
                    Spacer()
                    VStack {
                        Text(currentQuestion.text)
                            .font(.title)
                            .fontWeight(.bold)
                        TextField("", text: $answer)
                            .focused($isFocused)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.center)
                            .font(.title)
                            .frame(width: 120)
                            .padding()
                            .padding(.horizontal, 20)
                            .keyboardType(.numberPad)
                            .onTapGesture {
                                isFocused = true
                            }
                        Button(action: {
                            if let answer = Int(answer) {
                                if answer == currentQuestion.answer {
                                    result.correct += 1
                                    nextQuestion()
                                } else {
                                    result.wrong += 1
                                    var txt = currentQuestion.text
                                    txt.removeFirst(8)
                                    txt.removeLast()
                                    alertMessage =  txt + " = \(currentQuestion.answer)"
                                    isAlert = true
                                }
                            }
                        }, label: {
                            Text("Answer")
                                .fontWeight(.bold)
                                .padding()
                                .foregroundColor(.white)
                                .frame(width: 120)
                                .background(Color.darkGreen)
                                .cornerRadius(10)
                        })

                    }
                    .shadow(radius: 5)
                    .padding(80)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                    .onTapGesture {
                        isFocused = false
                    }
                    Spacer()
                    Spacer()
                }
            }
        }
        .alert(isPresented: $isAlert) {
            Alert(title: Text(alertMessage),
                  message: Text(""),
                  dismissButton: .destructive(Text("Got It")) {
                nextQuestion()
            }
            )
        }
        .onAppear {
            currentQuestion = questions[questionIndex]
        }
    }
}

struct MultTableView_Previews: PreviewProvider {
    static var previews: some View {
        MultTableView(questions: [Question(text: "What is 12 x 12?", answer: 144)],
                      result: .constant(Result(wrong: 4, correct: 5)),
                      isShow: .constant(true))
    }
}
