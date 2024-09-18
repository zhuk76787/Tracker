//
//  ViewConfigurableProtocol.swift
//  Tracker
//
//  Created by Дмитрий Жуков on 9/18/24.
//

import UIKit

protocol ViewConfigurable {
    func addSubviews()
    func addConstraints()
    func configureView()
}


extension ViewConfigurable where Self: UIViewController {
    func configureView() {
        addSubviews()
        addConstraints()
    }
}
