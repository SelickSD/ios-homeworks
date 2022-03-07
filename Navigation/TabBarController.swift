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
        self.setupTabBar()
    }
    private func setupTabBar() {

        let items: [TabBarItem] = [.feed, .profile]

        self.viewControllers = items.map({tabBarItem in
            switch tabBarItem {
            case .feed:
                return ViewController()
            case .profile:
                return ProfileViewController()
            }
        })

        self.viewControllers?.enumerated().forEach({(index, viewController) in
            viewController.tabBarItem.title = items[index].title
            viewController.tabBarItem.image = items[index].image
        })
    }
}
