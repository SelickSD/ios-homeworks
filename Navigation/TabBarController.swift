//
//  TabBarController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 11.03.2022.
//

import UIKit

class TabBarController: UITabBarController {

    private enum TabBarItem {
        case feed
        case profile

        var label: String {
            switch self {
            case .feed:
                return "Лента"
            case .profile:
                return "Профиль"
            }
        }
        var image: UIImage? {
            switch self {
            case .feed:
                return UIImage(systemName: "note")
            case .profile:
                return UIImage(systemName: "person")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label

        self.setupTabBarController()
    }
    
    private func setupTabBarController() {

        let items: [TabBarItem] = [.feed, .profile]

        self.viewControllers = items.map({tabBarItem in
            switch tabBarItem {
            case .feed:
                return createNavigationController(for: FeedViewController(), index: .feed)
            case .profile:
                return createNavigationController(for: ProfileViewController(), index: .profile)
            }
        })
    }

    private func createNavigationController(for rootViewController: UIViewController,
                                            index: TabBarItem) -> UIViewController {

        let navigationController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = index.label
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem.title = index.label
        navigationController.tabBarItem.image = index.image
        return navigationController
    }
}
