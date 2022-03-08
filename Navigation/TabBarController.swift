//
//  TabBarController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 07.03.2022.
//

import UIKit

class TabBarController: UITabBarController {

    private enum TabBarItem {
        case feed
        case profile

        var title: String {
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

        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        
        self.setupTabBar()
    }
    private func setupTabBar() {

        let items: [TabBarItem] = [.feed, .profile]

        self.viewControllers = items.map({tabBarItem in
            switch tabBarItem {
            case .feed:
                return createNavController(for: ViewController(), index: .feed)
            case .profile:
                return createNavController(for: ProfileViewController(), index: .profile)
            }
        })
    }

    private func createNavController(for rootViewController: UIViewController,
                                     index: TabBarItem) -> UIViewController {

        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = index.title
        navController.tabBarItem.title = index.title
        navController.tabBarItem.image = index.image
        return navController
    }

}
