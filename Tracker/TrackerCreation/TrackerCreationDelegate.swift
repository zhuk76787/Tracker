//
//  TrackerCreationDelegate.swift
//  Tracker
//
//  Created by Дмитрий Жуков on 8/16/24.
//

import Foundation

protocol TrackerCreationDelegate: AnyObject {
    func createTracker(tracker: Tracker, category: String)
}
