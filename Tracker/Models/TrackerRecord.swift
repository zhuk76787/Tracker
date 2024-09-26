//
//  TrackerRecord.swift
//  Tracker
//
//  Created by Дмитрий Жуков on 8/13/24.
//

import Foundation

struct TrackerRecord {
    let id: UUID
    let date: Date
    
    init(
        id: UUID,
        date: Date
    ) {
        self.id = id
        self.date = date
    }
}
