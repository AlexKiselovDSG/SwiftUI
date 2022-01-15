//
//  ContentView.swift
//  BetterRest
//
//  Created by Kiselov, Oleksandr on 1/14/22.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultDateTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    static var defaultDateTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    var body: some View {
        NavigationView {
            Form {
                Section(content: {
                    HStack {
                        Spacer()
                        DatePicker("Please enter a time",
                                   selection: $wakeUp,
                                   displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                }, header: {
                    Text("When do you want to wake up?")
                        .font(.headline)
                })
                Section(content: {
                    Stepper("\(sleepAmount.formatted()) hours",
                            value: $sleepAmount,
                            in: 4...12, step: 0.25)
                }, header: {
                    Text("Desired amount of sleep")
                        .font(.headline)
                })
                Section(content: {
                    Picker(coffeeAmount == 1 ? "Cup" : "Cups",
                           selection: $coffeeAmount, content: {
                        ForEach(0 ..< 21) {
                            Text("\($0)")
                        }
                    })
                }, header: {
                    Text("Daily coffee intake")
                        .font(.headline)
                })
                Section(content: {
                    HStack {
                        Spacer()
                        Text(alertMessage)
                            .font(.headline)
                    }
                }, header: {
                    Text(alertTitle)
                        .font(.headline)
                })
            }
            .navigationTitle("BetterRest")
            //            .toolbar(content: {
            //                Button("Calculate", action: calculateBedTime)
            //            })
            .onAppear(perform: {
                calculateBedTime()
            })
            .onChange(of: wakeUp.timeIntervalSince1970, perform: {_ in
                calculateBedTime()
            })
            .onChange(of: sleepAmount, perform: { _ in
                calculateBedTime()
            })
            .onChange(of: coffeeAmount, perform: { _ in
                calculateBedTime()
            })
            //            .alert(alertTitle, isPresented: $showingAlert, actions: {
            //                Button("OK") {}
            //            }, message: {
            //                Text(alertMessage)
            //            })
        }
    }
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try BetterRest(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute),
                                                  estimatedSleep: sleepAmount,
                                                  coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            // Error
            alertTitle = "Error"
            alertMessage = "There was a problem calculating time"
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
