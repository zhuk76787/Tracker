//
//  TrackerTests.swift
//  TrackerTests
//
//  Created by Дмитрий Жуков on 9/29/24.
//

import XCTest
import SnapshotTesting
@testable import Tracker

final class TrackerTests: XCTestCase {
    
    func testTrackerViewControllerLight() {
        let vc = TrackerViewController()
        assertSnapshot(matching: vc, as: .image(traits: .init(userInterfaceStyle: .light)))
    }
    
    func testTrackerViewControllerDark() {
        let vc = TrackerViewController()
        assertSnapshot(matching: vc, as: .image(traits: .init(userInterfaceStyle: .dark)))
    }
}
