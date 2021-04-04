//
//  HomeTabBarController.swift
//  LibertySolutionDemo
//
//  Created by Ashish Viltoriya on 03/04/21.
//

import UIKit

class HomeTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController.isKind(of: FavouritesViewController.self) {
            let postsViewController = tabBarController.viewControllers?[0] as! PostsViewController
            let data = postsViewController.posts
            let favVC = viewController as! FavouritesViewController
            favVC.getPostsData(with: data!)
        }
    }

}
