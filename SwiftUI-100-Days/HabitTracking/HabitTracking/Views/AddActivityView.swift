//
//  AddActivityView.swift
//  HabitTracking
//
//  Created by Kiselov, Oleksandr on 1/18/22.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var manager: HabitManager
    @State private var activity = Activity(name: "", description: "")
    var body: some View {
        VStack {
        Form {
            Section {
                TextField("Name", text: $activity.name)
                TextField("Description", text: $activity.description)
            } header: {
                Text("Add new Activity")
            }
        }
                    HStack{
                        Button("Dismiss") {
                            dismiss()
                        }
                        Spacer()
                        Button("Add") {
                            manager.add(activity: activity)
                            dismiss()
                        }
                    }
                    .buttonStyle(.bordered)
                    .padding(40)
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView()
    }
}
