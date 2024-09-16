//
//  Bit.swift
//  Tracker
//
//  Created by Дмитрий Жуков on 9/11/24.
//

import Foundation

enum Bit: Int16 {
    case zero, one
    
    var description: Int {
        switch self {
        case .zero:
            return 0
        case .one:
            return 1
        }
    }
}
