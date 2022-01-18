//
//  ActivityDetailView.swift
//  HabitTracking
//
//  Created by Kiselov, Oleksandr on 1/18/22.
//

import SwiftUI

struct ActivityDetailView: View {
    let activity: Activity
    var body: some View {
        VStack {
            Text(activity.name)
                .font(.title)
            Text(activity.description)
                .font(.headline)
            Text("Performed \(activity.count) times")
        }
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activity: Activity(name: "Test", description: "Test"))
    }
}
