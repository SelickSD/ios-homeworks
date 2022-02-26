//
//  TabBarController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 26.02.2022.
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
                return "Профль"
            }
        }
        var image: UIImage? {
            switch self {
            case .feed:
                return UIImage(systemName: "newspaper")
            case .profile:
                return UIImage(systemName: "person")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTabBar()
        // Do any additional setup after loading the view.
    }

    private func setupTabBar(){
        let items: [TabBarItem] = [.feed, .profile]

        self.viewControllers = items.map({tabBarItem in
            switch tabBarItem {
            case .feed:
                return UINavigationController(rootViewController: FeedViewController())
            case .profile:
                return ProfileViewController()
            }
        })
        self.viewControllers?.enumerated().forEach({(index, viewController) in
            viewController.tabBarItem.title = items[index].title
            viewController.tabBarItem.image = items[index].image
        })
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
