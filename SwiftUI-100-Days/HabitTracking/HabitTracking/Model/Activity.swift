//
//  Activity.swift
//  HabitTracking
//
//  Created by Kiselov, Oleksandr on 1/18/22.
//

import Foundation

struct Activity: Codable, Identifiable {
    var id = UUID()
    var name: String
    var description = ""
    var count = 0
}
