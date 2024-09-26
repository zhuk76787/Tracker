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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let trackerRecordStore = TrackerRecordStore()
    private var score: Int {
        return calculateCompletedTrackers()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        statisticTableView.dataSource = self
        statisticTableView.delegate = self
        setupView()
        updateViewAccordingToScore()
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
        if score == 0 {
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
        return score == 0 ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsTableCell.identifier, for: indexPath) as? StatisticsTableCell else {
            return UITableViewCell()
        }
        cell.prepareForReuse()
        cell.setNameLabel()
        cell.setScore(with: score)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension StatisticViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CellSize.ninety
    }
}
