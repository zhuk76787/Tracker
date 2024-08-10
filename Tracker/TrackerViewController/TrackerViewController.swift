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
    private let addTrackerButton: UIButton = {
        let button = UIButton()
        if let imageButton = UIImage(named: "addTrackerIcon") {
            button.setImage(imageButton, for: .normal)
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var dateLable: UILabel = {
        let labe = UILabel()
        labe.backgroundColor = #colorLiteral(red: 0.9531050324, green: 0.9531050324, blue: 0.9531050324, alpha: 1)
        labe.layer.cornerRadius = 8
        labe.layer.masksToBounds = true
        labe.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        labe.textColor = #colorLiteral(red: 0.1019607843, green: 0.1058823529, blue: 0.1333333333, alpha: 1)
        labe.text = dateFormatter.string(from: Date())
        labe.textAlignment = .right
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
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter
    }()
    
    // MARK: - methods ViewControllera
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setConstraints()
    }
    
    @objc
    private func didTapButton() {
        print("tap button")
    }
    // MARK: - setup View and Constraits
    private func setupView() {
        let subViews = [customNavigationBar, image, questionLable]
        subViews.forEach { view.addSubview($0) }
        setupNavigationBar()
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
      let subViews = [addTrackerButton, dateLable, titleLable, searchBar]
      subViews.forEach{customNavigationBar.addSubview($0)}
      setupNavigationBarConstraints()
      setupNavigationItemsConstraints()
       navigationItem.leftBarButtonItem = UIBarButtonItem(customView: addTrackerButton)
       navigationItem.rightBarButtonItem = UIBarButtonItem(customView: dateLable)
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
            
            // Констрейнты для dateLabel
            dateLable.topAnchor.constraint(equalTo: customNavigationBar.topAnchor, constant: 49),
            dateLable.trailingAnchor.constraint(equalTo: customNavigationBar.trailingAnchor, constant: -16),
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
}


