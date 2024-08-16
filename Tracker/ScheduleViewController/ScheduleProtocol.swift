//
//  ScheduleProtocol.swift
//  Tracker
//
//  Created by Дмитрий Жуков on 8/16/24.
//

import Foundation

protocol ScheduleProtocol: AnyObject {
    func saveSelectedDays(selectedDays: Set<WeekDays>)
}
