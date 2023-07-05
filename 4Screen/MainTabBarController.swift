//
//  MainTabBarController.swift
//  4Screen
//
//  Created by Владимир Дроздов on 5.07.23.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
//        setupMainTabBarController()
    }
//    private func setupMainTabBarController () {
//        view.bounds
//    }
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: FirstScreenViewController(),
                title: "First"),
            generateVC(
                viewController: SecondScreenViewController(),
                title: "Second"),
            generateVC(
                viewController: ThirdScreenViewController(),
                title: "Third")
        ]
    }
    private func generateVC(viewController:UIViewController,title:String) -> UIViewController {
        viewController.tabBarItem.title = title
        return viewController
    }
}
