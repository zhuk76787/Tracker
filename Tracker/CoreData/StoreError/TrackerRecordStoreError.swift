//
//  TrackerRecordStoreError.swift
//  Tracker
//
//  Created by Дмитрий Жуков on 9/11/24.
//

import Foundation

enum TrackerRecordStoreError: Error {
    case decodingTrackerRecordIdError
    case decodingTrackerRecordDateError
    case fetchTrackerRecordError
}
