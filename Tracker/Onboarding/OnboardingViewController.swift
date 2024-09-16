//
//  OnboardingViewController.swift
//  Tracker
//
//  Created by Дмитрий Жуков on 9/16/24.
//

import UIKit

class OnboardingViewController: UIPageViewController {
    // MARK: - Public Properties
    lazy var pages: [UIViewController] = {
        let blue = SinglePageOnboardingViewController (
            text: "Отслеживайте только то, что хотите",
            imageTitle: "backgrBlue"
        )
        
        let red = SinglePageOnboardingViewController(
            text: "Даже если это не литры воды и йога",
            imageTitle: "backgrRed"
        )
        
        return [blue, red]
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.1352768838, green: 0.1420838535, blue: 0.1778985262, alpha: 1)
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.1352768838, green: 0.1420838535, blue: 0.1778985262, alpha: 0.3024110099)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    // MARK: - Private Properties
    private let button = UIButton(type: .custom)
    
    // MARK: - Public Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        if let first = pages.first {
            setViewControllers(
                [first],
                direction: .forward,
                animated: true,
                completion: nil
            )
        }
        
        setupButton()
        setupPageControl()
    }
    
    // MARK: - IBAction
    @objc
    private func didTapButton() {
        let tabBarVC = TabBarController()
        guard let window = UIApplication.shared.windows.first
        else {
            fatalError("Invalid Configuration")
        }
        
        tabBarVC.tabBar.alpha = 0
        UIView.transition(
            with: window,
            duration: 0.6,
            options: UIView.AnimationOptions.curveEaseOut,
            animations: {
                window.rootViewController = tabBarVC
                tabBarVC.tabBar.alpha = 1
            })
    }
    
    // MARK: - Private Methods
    private func setupButton() {
        button.setTitle("Вот это технологии!", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.titleLabel?.textColor = .white
        button.backgroundColor = #colorLiteral(red: 0.1352768838, green: 0.1420838535, blue: 0.1778985262, alpha: 1)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupPageControl() {
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -24),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: - DataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        var previousIndex = viewControllerIndex - 1
        
        if previousIndex < 0 {
            previousIndex = pages.count - 1
        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        var nextIndex = viewControllerIndex + 1
        
        if nextIndex >= pages.count  {
            nextIndex = 0
        }
        return pages[nextIndex]
    }
}

// MARK: - Delegate
extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        if let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            pageControl.currentPage = currentIndex
        }
    }
}
