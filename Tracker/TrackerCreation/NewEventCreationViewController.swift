//
//  NewEventCreationViewController.swift
//  Tracker
//
//  Created by Дмитрий Жуков on 8/16/24.
//

import UIKit

final class NewEventCreationViewController: CreationTrackerViewController {
    
    // MARK: - Public Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIDelegate = self
        configureUIDelegate?.setupBackground()
    }
    
    // MARK: - IBAction
    @objc
    override func saveButtonPressed() {
        guard let name = trackerName,
              let color = selectedColor,
              let emoji = selectedEmoji,
              let categoryTitle = trackerCategory?.title
        else { return }
        let week = WeekDays.allCases
        let weekSet = Set(week)
        let tracker = Tracker(
            name: name,
            color: color,
            emoji: emoji,
            schedule: weekSet,
            state: .Event
        )
        
        creationDelegate?.createTracker(tracker: tracker, category: categoryTitle)
        dismiss(animated: true)
    }
}

//MARK: - ConfigureUIForTrackerCreationProtocol
extension NewEventCreationViewController: ConfigureUIForTrackerCreationProtocol {
    
    // MARK: - Public Methods
    func configureButtonsCell(cell: ButtonsCell) {
        cell.prepareForReuse()
        cell.categoriesDelegate = self
        cell.state = .Event
    }
    
    func setupBackground() {
        self.title = NSLocalizedString("event.new", comment: "")
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.hidesBackButton = true
    }
    
    func calculateTableViewHeight(width: CGFloat) -> CGSize {
        return CGSize(width: width, height: 75)
    }
    
    func checkIfSaveButtonCanBePressed() {
        if trackerName != nil,
           selectedEmoji != nil,
           selectedColor != nil
        {
            saveButtonCanBePressed = true
        } else {
            saveButtonCanBePressed = false
        }
    }
}
