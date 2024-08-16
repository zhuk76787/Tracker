//
//  TrackerViewController.swift
//  Tracker
//
//  Created by Дмитрий Жуков on 8/7/24.
//

import UIKit
import SwiftUI
// MARK: - Preview
struct TrackerViewControllerPreview: PreviewProvider {
    static var previews: some View {
        TrackerViewController().showPreview()
    }
}
// MARK: - TrackerVC
class TrackerViewController: UIViewController {
    
    // MARK: - Subviews
    @objc private let addTrackerButton: UIButton = {
        let button = UIButton()
        if let imageButton = UIImage(named: "addTrackerIcon") {
            button.setImage(imageButton, for: .normal)
            button.addTarget(TrackerViewController.self, 
                             action: #selector(didTapButton),
                             for: .touchUpInside)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   
    private lazy var datePicker: UIDatePicker = {
            let picker = UIDatePicker()
            picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
            picker.translatesAutoresizingMaskIntoConstraints = false
            picker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
            return picker
        }()
   
    private lazy var dateLable: UILabel = {
        let labe = UILabel()
        labe.backgroundColor = #colorLiteral(red: 0.9531050324, green: 0.9531050324, blue: 0.9531050324, alpha: 1)
        labe.layer.cornerRadius = 8
        labe.layer.masksToBounds = true
        labe.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        labe.textColor = #colorLiteral(red: 0.1019607843, green: 0.1058823529, blue: 0.1333333333, alpha: 1)
        labe.textAlignment = .center
        labe.translatesAutoresizingMaskIntoConstraints = false
        return labe
    }()
    
    private let titleLable: UILabel = {
        let labe = UILabel()
        labe.font = UIFont.boldSystemFont(ofSize: 34)
        labe.textColor = #colorLiteral(red: 0.1019607843, green: 0.1058823529, blue: 0.1333333333, alpha: 1)
        labe.text = "Трекеры"
        labe.translatesAutoresizingMaskIntoConstraints = false
        return labe
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        if let image = UIImage(named: "starIcon") {
            imageView.image = image
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let questionLable: UILabel = {
        let labe = UILabel()
        labe.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        labe.textColor = #colorLiteral(red: 0.1019607843, green: 0.1058823529, blue: 0.1333333333, alpha: 1)
        labe.text = "Что будем отслеживать?"
        labe.textAlignment = .center
        labe.translatesAutoresizingMaskIntoConstraints = false
        return labe
    }()
    
    let collectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
          return collectionView
      }()
    
    // MARK: - Public Properties
    var categories: [TrackerCategory] = []
    var completedTrackers: [TrackerRecord] = []
    var currentDate = Date()
    lazy var currentCategories: [TrackerCategory] = {
        filterCategoriesToShow()
    }()
    
    // MARK: - methods ViewControllera
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setConstraints()
    }
    
    @objc
    func didTapButton() {
        let createTrackerViewController = NewTrackerViewController()
        createTrackerViewController.delegate = self
        let createTracker = UINavigationController(rootViewController: createTrackerViewController)
        navigationController?.present(createTracker, animated: true)
    }
    
    @objc private func datePickerChanged() {
        updateDateLabel()
        guard let date = dateLable.text else {return}
        print("Выбранная дата: \(date)")
    }

    private func updateDateLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        dateLable.text = formatter.string(from: datePicker.date)
    }
    // MARK: - setup View and Constraits
    private func setupView() {
        let subViews = [customNavigationBar, image, questionLable]
        subViews.forEach { view.addSubview($0) }
        setupNavigationBar()
        updateDateLabel()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 402),
            image.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 80),
            image.widthAnchor.constraint(equalToConstant: 80),
            
            questionLable.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            questionLable.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            questionLable.heightAnchor.constraint(equalToConstant: 18),
            questionLable.widthAnchor.constraint(equalToConstant: 343)
        ])
    }
    
    // MARK: - Custom Navigation Bar
    
    private let customNavigationBar: UIView = {
        let navigationBar = UIView()
        navigationBar.backgroundColor = .white
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        return navigationBar
    }()

   func setupNavigationBar() {
      navigationController?.navigationBar.prefersLargeTitles = true
      let subViews = [addTrackerButton, datePicker,dateLable, titleLable, searchBar]
      subViews.forEach{customNavigationBar.addSubview($0)}
      setupNavigationBarConstraints()
      setupNavigationItemsConstraints()
       navigationItem.leftBarButtonItem = UIBarButtonItem(customView: addTrackerButton)
       navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
  }

    private func setupNavigationBarConstraints() {
        NSLayoutConstraint.activate([
            customNavigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            customNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavigationBar.heightAnchor.constraint(equalToConstant: 182) // Высота с учетом всех элементов
        ])
    }
  
  // MARK: - setup Constraits SubView Navigation Bara

    private func setupNavigationItemsConstraints() {
        NSLayoutConstraint.activate([
            // Констрейнты для кнопки addTrackerButton
            addTrackerButton.topAnchor.constraint(equalTo: customNavigationBar.topAnchor, constant: 45),
            addTrackerButton.leadingAnchor.constraint(equalTo: customNavigationBar.leadingAnchor, constant: 6),
            addTrackerButton.heightAnchor.constraint(equalToConstant: 42),
            addTrackerButton.widthAnchor.constraint(equalToConstant: 42),
            
            // Констрейнты для datePicker
            datePicker.topAnchor.constraint(equalTo: customNavigationBar.topAnchor, constant: 49),
            datePicker.trailingAnchor.constraint(equalTo: customNavigationBar.trailingAnchor, constant: -16),
            datePicker.heightAnchor.constraint(equalToConstant: 34),
            datePicker.widthAnchor.constraint(equalToConstant: 77),
            
            // Констрейнты для dateLable
            dateLable.centerXAnchor.constraint(equalTo: datePicker.centerXAnchor),
            dateLable.centerYAnchor.constraint(equalTo: datePicker.centerYAnchor),
            dateLable.heightAnchor.constraint(equalToConstant: 34),
            dateLable.widthAnchor.constraint(equalToConstant: 77),
            
            // Констрейнты для titleLabel
            titleLable.topAnchor.constraint(equalTo: customNavigationBar.topAnchor, constant: 88),
            titleLable.leadingAnchor.constraint(equalTo: customNavigationBar.leadingAnchor, constant: 16),
            titleLable.heightAnchor.constraint(equalToConstant: 41),
            titleLable.widthAnchor.constraint(equalToConstant: 254),
            
            // Констрейнты для searchBar
            searchBar.topAnchor.constraint(equalTo: customNavigationBar.topAnchor, constant: 136),
            searchBar.leadingAnchor.constraint(equalTo: customNavigationBar.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: customNavigationBar.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    // MARK: setupCollectionView
    private func setupCollectionView() {
        collectionView.delegate = self
            collectionView.dataSource = self
            
            collectionView.register(
                TrackerCollectionViewCell.self,
                forCellWithReuseIdentifier: TrackerCollectionViewCell.identifier
            )
            collectionView.register(
                HeaderCollectionReusableView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HeaderCollectionReusableView.identifier
            )
            collectionView.backgroundColor = .white
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(collectionView)
            
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
    
    private func showPlaceHolder() {
        let backgroundView = PlaceHolderView(frame: collectionView.frame)
        backgroundView.setupNoTrackersState()
        collectionView.backgroundView = backgroundView
    }
    
    private func filterCategoriesToShow() -> [TrackerCategory] {
        currentCategories = []
        let weekdayInt = Calendar.current.component(.weekday, from: currentDate)
        let day = (weekdayInt == 1) ?  WeekDays(rawValue: 7) : WeekDays(rawValue: weekdayInt - 1)
        
        categories.forEach { category in
            let title = category.title
            let trackers = category.trackers.filter { tracker in
                tracker.schedule.contains(day!)
            }
            
            if trackers.count > 0 {
                currentCategories.append(TrackerCategory(title: title, trackers: trackers))
            }
        }
        return currentCategories
    }
    
    private func updateCollectionAccordingToDate() {
        currentCategories = filterCategoriesToShow()
        collectionView.reloadData()
    }
}

extension TrackerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentCategories[section].trackers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrackerCollectionViewCell.identifier,
            for: indexPath
        ) as? TrackerCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.prepareForReuse()
        cell.counterDelegate = self
        let tracker = currentCategories[indexPath.section].trackers[indexPath.row]
        cell.trackerInfo = TrackerInfoCell(
            id: tracker.id,
            name: tracker.name,
            color: tracker.color,
            emoji: tracker.emoji,
            daysCount: calculateTimesTrackerWasCompleted(id: tracker.id),
            currentDay: currentDate,
            state: tracker.state
        )
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if currentCategories.count == 0 {
            showPlaceHolder()
        } else {
            collectionView.backgroundView = nil
        }
        return currentCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderCollectionReusableView.identifier,
                for: indexPath
            ) as? HeaderCollectionReusableView {
                sectionHeader.titleLabel.text = categories[indexPath.section].title
                return sectionHeader
            }
        }
        return UICollectionReusableView()
    }
    
}

extension TrackerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - 16 * 2 - 9
        let cellWidth = availableWidth / 2
        return CGSize(width: cellWidth, height: 148)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 46)
    }
}

//MARK: TrackerCounterDelegate
extension TrackerViewController: TrackerCounterDelegate {
    func increaseTrackerCounter(id: UUID, date: Date) {
        completedTrackers.append(TrackerRecord(id: id, date: date))
    }
    
    func decreaseTrackerCounter(id: UUID, date: Date) {
        completedTrackers = completedTrackers.filter {
            if $0.id == id && Calendar.current.isDate(
                $0.date,
                equalTo: currentDate,
                toGranularity: .day
            ) {
                return false
            }
            return true
        }
    }
    
    func checkIfTrackerWasCompletedAtCurrentDay(id: UUID, date: Date) -> Bool {
        let contains = completedTrackers.filter {
            $0.id == id && Calendar.current.isDate(
                $0.date,
                equalTo: currentDate,
                toGranularity: .day
            )
        }.count > 0
        return contains
    }
    
    func calculateTimesTrackerWasCompleted(id: UUID) -> Int {
        let contains = completedTrackers.filter {
            $0.id == id
        }
        return contains.count
    }
}

//MARK: - SearchController
extension TrackerViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text != ""{
            updateCollectionAccordingToSearchRequest(trackerToSearch: text)
        }
    }
    
    private func updateCollectionAccordingToSearchRequest(trackerToSearch: String) {
        currentCategories = []
        categories.forEach { category in
            let title = category.title
            let trackers = category.trackers.filter { tracker in
                tracker.name.contains(trackerToSearch)
            }
            if trackers.count > 0 {
                currentCategories.append(TrackerCategory(title: title, trackers: trackers))
            }
        }
        collectionView.reloadData()
    }
}

extension TrackerViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        updateCollectionAccordingToDate()
    }
}

//MARK: TrackerCreationDelegate
extension TrackerViewController: TrackerCreationDelegate {
    func createTracker(tracker: Tracker, category: String) {
        let categoryFound = categories.filter{
            $0.title == category
        }
        
        var trackers: [Tracker] = []
        
        if categoryFound.count > 0 {
            categoryFound.forEach {
                trackers = trackers + $0.trackers
            }
            
            trackers.append(tracker)
            
            categories = categories.filter {
                $0.title != category
            }
            
            if !trackers.isEmpty {
                categories.append(TrackerCategory(title: category, trackers: trackers))
            }
        } else {
            categories.append(TrackerCategory(title: category, trackers: [tracker]))
        }
        updateCollectionAccordingToDate()
    }
}
