//
//  TabBarController.swift
//  test_effectiveMobile
//
//  Created by Элина Абдрахманова on 08.07.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
  
    }
    
    private func setupTabBar() {
        let mainVC = self.createNav(with: "Главная",
                                  image: UIImage(named: "главная") ?? UIImage(),
                                  vc: MainViewController())
        
        let searchVC = self.createNav(with: "Поиск",
                                      image: UIImage(named: "поиск") ?? UIImage(),
                                      vc: SearchViewController())
        
        let bucketVC = self.createNav(with: "Корзина",
                                      image: UIImage(named: "корзина") ?? UIImage(),
                                      vc: BucketViewController())
        
        let profileVC = self.createNav(with: "Аккаунт",
                                      image: UIImage(named: "аккаунт") ?? UIImage(),
                                      vc: ProfileViewController())
        
        self.setViewControllers([mainVC, searchVC, bucketVC, profileVC], animated: true)
        
        tabBar.tintColor = ThemeColor.tabBar
        tabBar.unselectedItemTintColor = ThemeColor.specialGray
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = ThemeColor.separator.cgColor
        
        UITabBarItem.appearance().setTitleTextAttributes([
            .font : UIFont.systemFont(ofSize: 10, weight: .regular)],
                                                         for: .normal)
    }
    
    private func createNav(with title: String, image: UIImage, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}
