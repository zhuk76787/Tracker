//
//  StatisticViewController.swift
//  Tracker
//
//  Created by Дмитрий Жуков on 9/26/24.
//

import UIKit
import SwiftUI

// MARK: - Preview
struct StatisticViewControllerPreview: PreviewProvider {
    static var previews: some View {
        StatisticViewController().showPreview()
    }
}

extension Notification.Name {
    static let dataDidChange = Notification.Name("dataDidChange")
}

class StatisticViewController: UIViewController, ViewConfigurable {
    // MARK: - Private Properties
    private let customNavigationBar: UIView = {
        let navigationBar = UIView()
        navigationBar.backgroundColor = .systemBackground
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    private let statisticTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(StatisticsTableCell.self, forCellReuseIdentifier: StatisticsTableCell.identifier)
        tableView.backgroundColor = .systemBackground
        tableView.layer.cornerRadius = 16
        tableView.layer.masksToBounds = true
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let trackerRecordStore = TrackerRecordStore()
    
    // MARK: - Computed Properties
    private var score: Int {
        return calculateCompletedTrackers()
    }
    
    private var bestPeriod: Int {
        return trackerRecordStore.bestPeriod
    }
    
    private var perfectDays: Int {
        return trackerRecordStore.perfectDays
    }
    
    private var averageTrackersPerDay: Int {
        return Int(trackerRecordStore.averageTrackersPerDay)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        statisticTableView.dataSource = self
        statisticTableView.delegate = self
        setupView()
        updateViewAccordingToScore()
        NotificationCenter.default.addObserver(self, selector: #selector(dataDidChange), name: .dataDidChange, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Private Methods
    private func updateData() {
        statisticTableView.reloadData()
        updateViewAccordingToScore()
    }
    
    @objc private func dataDidChange() {
        updateData()
    }
    
    // MARK: - ViewConfigurable Methods
    func addSubviews() {
        let subViews = [customNavigationBar, statisticTableView]
        subViews.forEach { view.addSubview($0) }
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            customNavigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            customNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavigationBar.heightAnchor.constraint(equalToConstant: 182),
            
            statisticTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            statisticTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 206),
            statisticTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statisticTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Private Methods
    private func setupView() {
        setupNavigationBar()
        configureView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = NSLocalizedString("statistics", comment: "")
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func showPlaceHolder() {
        let backgroundView = PlaceHolderView(frame: statisticTableView.frame)
        backgroundView.setupNoStatisticState()
        statisticTableView.backgroundView = backgroundView
    }
    
    private func calculateCompletedTrackers() -> Int {
        guard let result = try? trackerRecordStore.calculateCompletedTrackers() else {
            return .zero
        }
        return result
    }
    
    private func updateViewAccordingToScore() {
        if score == 0 && bestPeriod == 0 && perfectDays == 0 && averageTrackersPerDay == 0{
            showPlaceHolder()
        } else {
            statisticTableView.backgroundView = nil
        }
        statisticTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension StatisticViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return score == 0 ? 0 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsTableCell.identifier, for: indexPath) as? StatisticsTableCell else {
            return UITableViewCell()
        }
        cell.prepareForReuse()
        
        switch indexPath.row {
        case 0:
            cell.setNameLabel(with: "best_period")
            cell.setScore(with: bestPeriod)
        case 1:
            cell.setNameLabel(with: "pefect_days")
            cell.setScore(with: perfectDays)
        case 2:
            cell.setNameLabel(with: "stat.completed")
            cell.setScore(with: score)
        case 3:
            cell.setNameLabel(with: "average_value")
            cell.setScore(with: averageTrackersPerDay)
        default:
            break
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension StatisticViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CellSize.ninety
    }
}
