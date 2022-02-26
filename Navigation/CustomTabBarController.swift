//
//  CustomTabBarController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 22.02.2022.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

         view.backgroundColor = .systemBackground
         UITabBar.appearance().barTintColor = .systemBackground
         tabBar.tintColor = .label
         setupVCs()

    }

     fileprivate func createNavController(for rootViewController: UIViewController,
     title: String,
     image: UIImage) -> UIViewController {
     let navController = UINavigationController(rootViewController: rootViewController)
     navController.tabBarItem.title = title
     navController.tabBarItem.image = image
     navController.navigationBar.prefersLargeTitles = true
     rootViewController.navigationItem.title = title
     return navController
     }

     func setupVCs() {
     viewControllers = [
     createNavController(for: FeedViewController(), title: NSLocalizedString("Feed", comment: ""), image: UIImage(systemName: "note")!),
     createNavController(for: ProfileViewController(), title: NSLocalizedString("Profile", comment: ""), image: UIImage(systemName: "person")!)
     ]
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