//
//  Tracker.swift
//  Tracker
//
//  Created by Дмитрий Жуков on 8/13/24.
//

import UIKit

struct Tracker {
    let id = UUID()
    let name: String
    let color: UIColor
    let emoji: String
    let schedule: Set<WeekDays>
    let state: State
    
    init(name: String, color: UIColor, emoji: String, schedule: Set<WeekDays>, state: State
    )
    {
        self.name = name
        self.color = color
        self.emoji = emoji
        self.schedule = schedule
        self.state = state
    }
}
