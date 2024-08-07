//
//  TrackerViewController.swift
//  Tracker
//
//  Created by Дмитрий Жуков on 8/7/24.
//

import UIKit
import SwiftUI

struct TrackerViewControllerPreview: PreviewProvider {
    static var previews: some View {
        TrackerViewController().showPreview()
    }
}

class TrackerViewController: UIViewController {
    private let addTrackerButton: UIButton = {
        let button = UIButton()
        if let imageButton = UIImage(named: "addTrackerIcon") {
            button.setImage(imageButton, for: .normal)
            button.addTarget(TrackerViewController.self, action: #selector(didTapButton), for: .touchUpInside)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setConstraints()
    }
    
    @objc
    private func didTapButton() {
        // Действие при нажатии кнопки
    }
    
    private func setupView() {
        let subViews = [addTrackerButton,dateLable,titleLable,searchBar,image,questionLable]
        subViews.forEach { view.addSubview($0) }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            addTrackerButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            addTrackerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 6),
            addTrackerButton.heightAnchor.constraint(equalToConstant: 42),
            addTrackerButton.widthAnchor.constraint(equalToConstant: 42),
            
            dateLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 49),
            dateLable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            dateLable.heightAnchor.constraint(equalToConstant: 34),
            dateLable.widthAnchor.constraint(equalToConstant: 77),
            
            titleLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
            titleLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLable.heightAnchor.constraint(equalToConstant: 41),
            titleLable.widthAnchor.constraint(equalToConstant: 254),
            
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 136),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 36),
            
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
}


