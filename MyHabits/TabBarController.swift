//
//  TabBarController.swift
//  MyHabits
//
//  Created by Pavel Grigorev on 17.11.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        let habitsViewController = UINavigationController(rootViewController: HabitsViewController())
        let infoViewController = UINavigationController(rootViewController: InfoViewController())

        self.viewControllers = [habitsViewController, infoViewController]
        let item1 = UITabBarItem(title: "Привычки", image: UIImage(systemName: "rectangle.grid.1x2.fill"), tag: 0)
        let item2 = UITabBarItem(title: "Информация", image:  UIImage(systemName: "info.circle.fill"), tag: 1)
        habitsViewController.tabBarItem = item1
        infoViewController.tabBarItem = item2
        UITabBar.appearance().tintColor = UIColor(red: 161/257, green: 22/257, blue: 204/257, alpha: 1)
        UITabBar.appearance().backgroundColor = UIColor(red: 242/257, green: 242/257, blue: 242/257, alpha: 1)
//        UITabBar.appearance().showsLargeContentViewer = true
//        UITabBar.appearance().scalesLargeContentImage = true
//        UITabBar.appearance().layer.isDoubleSided = true
        UITabBar.appearance().clipsToBounds = true
    }

}
