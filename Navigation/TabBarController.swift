//
//  TabBarController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 11.03.2022.
//

import UIKit

class TabBarController: UITabBarController {

    private enum tabBarIndex {
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
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewControllers?.enumerated().forEach({ (index, viewController) in
            switch index {
            case 0:
                viewController.tabBarItem.title = tabBarIndex.feed.label
            case 1:
                viewController.tabBarItem.title = tabBarIndex.profile.label
            default:
                viewController.tabBarItem.title = tabBarIndex.profile.label
            }
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
