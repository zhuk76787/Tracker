//
//  StatisticViewController.swift
//  Tracker
//
//  Created by Дмитрий Жуков on 8/7/24.
//

import UIKit
import SwiftUI
// MARK: - Preview
struct StatisticViewControllerPreview: PreviewProvider {
    static var previews: some View {
        StatisticViewController().showPreview()
    }
}

// MARK: - StatisticVC
final class StatisticViewController: UIViewController, ViewConfigurable {
    // MARK: - Subviews
    private let titleLable: UILabel = {
        let labe = UILabel()
        labe.font = UIFont.boldSystemFont(ofSize: 34)
        labe.textColor = .label
        labe.text = NSLocalizedString("statistics", comment: "")
        labe.translatesAutoresizingMaskIntoConstraints = false
        return labe
    }()
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        if let image = UIImage(named: "cryIcon") {
            imageView.image = image
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let questionLable: UILabel = {
        let labe = UILabel()
        labe.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        labe.textColor = .label
        labe.text = NSLocalizedString("placeholder.noStatistics", comment: "")
        labe.textAlignment = .center
        labe.translatesAutoresizingMaskIntoConstraints = false
        return labe
    }()
    // MARK: - methods ViewControllera
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureView()
    }
    // MARK: - ViewConfigurable Methods
    func addSubviews() {
        let subViews = [titleLable,image,questionLable]
        subViews.forEach { view.addSubview($0) }
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
            titleLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLable.heightAnchor.constraint(equalToConstant: 41),
            titleLable.widthAnchor.constraint(equalToConstant: 254),
            
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 375),
            image.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 80),
            image.widthAnchor.constraint(equalToConstant: 80),
            
            questionLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 463),
            questionLable.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            questionLable.heightAnchor.constraint(equalToConstant: 18),
            questionLable.widthAnchor.constraint(equalToConstant: 343)
        ])
    }
}
