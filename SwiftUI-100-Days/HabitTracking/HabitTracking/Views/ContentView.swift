//
//  ContentView.swift
//  HabitTracking
//
//  Created by Kiselov, Oleksandr on 1/18/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var manager = HabitManager()
    @State private var isShowingSheet = false
    
       var body: some View {
           NavigationView{
               VStack{
               List {
                   ForEach(manager.activities) { activity in
                       NavigationLink(destination: ActivityDetailView(activity: activity)) {
                           HStack{
                               VStack(alignment: .leading, spacing: 5) {
                           Text(activity.name)
                                   .font(.body)
                               Text("Performed \(activity.count) times")
                                   .font(.caption2)
                           }
                               Spacer()
                               Image(systemName: "plus.circle")
                                   .imageScale(.medium)
                                   .padding(10)
                                   .contentShape(Rectangle())
                                   .onTapGesture{
                                   manager.increment(activity: activity)
                               }

                           }
                       }
                   }
               }
                   Button("Add Activity", action: {
                       isShowingSheet = true
                   })
                       .sheet(isPresented: $isShowingSheet, onDismiss: {}, content: {
                           AddActivityView()
                          
                       })
        
           }
           }
           .environmentObject(manager)
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
