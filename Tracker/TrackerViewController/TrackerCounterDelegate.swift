//
//  TrackerCounterDelegate.swift
//  Tracker
//
//  Created by Дмитрий Жуков on 8/16/24.
//

import Foundation

protocol TrackerCounterDelegate: AnyObject {
    func increaseTrackerCounter(id: UUID, date: Date)
    func decreaseTrackerCounter(id: UUID, date: Date)
    func checkIfTrackerWasCompletedAtCurrentDay(id: UUID, date: Date) -> Bool
    func calculateTimesTrackerWasCompleted(id: UUID) -> Int
}
