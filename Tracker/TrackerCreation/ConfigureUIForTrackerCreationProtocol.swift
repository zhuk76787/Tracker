//
//  ConfigureUIForTrackerCreationProtocol.swift
//  Tracker
//
//  Created by Дмитрий Жуков on 8/16/24.
//

import Foundation

protocol ConfigureUIForTrackerCreationProtocol: AnyObject {
    func configureButtonsCell(cell: ButtonsCell)
    func setupBackground()
    func calculateTableViewHeight(width: CGFloat) -> CGSize
    func checkIfSaveButtonCanBePressed()
}
