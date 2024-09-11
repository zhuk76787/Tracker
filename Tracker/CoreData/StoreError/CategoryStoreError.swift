//
//  CategoryStoreError.swift
//  Tracker
//
//  Created by Дмитрий Жуков on 9/11/24.
//

import Foundation

enum CategoryStoreError: Error {
    case decodingTitleError
    case decodingTrackersError
    case addNewTrackerError
    case fetchingCategoryError
}
