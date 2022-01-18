//
//  HabitManagerViewModel.swift
//  HabitTracking
//
//  Created by Kiselov, Oleksandr on 1/18/22.
//

import Foundation
import SwiftUI

class HabitManager: ObservableObject {
    
    @AppStorage("activities") var activities = [Activity]()
    
    init() {
    }
    
    func add(activity :Activity) {
        activities.append(activity)
    }
    
    func increment(activity: Activity) {
        if let index = activities.firstIndex(where: {$0.id == activity.id}) {
            activities[index].count += 1
        }
        
    }
}


extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(Array<Element>.self, from: data)
        else {
            return nil
        }
        self = result
    }
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
