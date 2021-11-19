//
//  TabBarController.swift
//  Jele Taxi
//
//  Created by Igor Ogai on 28.09.2021.
//

import UIKit
import FirebaseAuth

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    //MARL:- Private Properties
    
    private var userUid = Auth.auth().currentUser?.uid
    
    //MARK:- Lifecycle
    
    override func viewDidLayoutSubviews() {
        self.tabBar.items![0].image = UIImage(named: "skincare")
        self.tabBar.items![0].title = "Товары"
        self.tabBar.items![1].image = UIImage(named: "delivery")
        self.tabBar.items![1].title = "Боксы"
        self.tabBar.items![2].image = UIImage(named: "more")
        self.tabBar.items![2].title = "Ещё"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarMenu()
        addTabBar()
        selectedIndex = 0
        
    }
    
    //MARK:- Private Methods
    
    private func setupTabBarMenu() {
        
        let boxMainVC = BoxMainViewController()
        let mainVC = MainViewController()
        let moreVC = MoreViewController()
        let deliveryVC =  DeliveryViewController()
        
        if userUid == "sWJDxdIyMXfhGkGiQLwWHt8hqmQ2" {
            let mainNavVC = UINavigationController(rootViewController: boxMainVC)
            let moreNavVC = UINavigationController(rootViewController: moreVC)
            let deliveryNavVC = UINavigationController(rootViewController: deliveryVC)
            let tabBarList = [mainNavVC, deliveryNavVC, moreNavVC]
            
            viewControllers = tabBarList
        } else {
            let mainNavVC = UINavigationController(rootViewController: mainVC)
            let moreNavVC = UINavigationController(rootViewController: moreVC)
            let deliveryNavVC = UINavigationController(rootViewController: deliveryVC)
            let tabBarList = [mainNavVC, deliveryNavVC, moreNavVC]
            
            viewControllers = tabBarList
        }
        
        
    }
    
    private func addTabBar(){
        self.delegate = self
        tabBar.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        tabBar.tintColor = .white
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarController {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
