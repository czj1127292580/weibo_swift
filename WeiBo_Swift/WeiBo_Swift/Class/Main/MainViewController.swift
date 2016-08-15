//
//  MainViewController.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/15.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor.orangeColor()

//        let home = HomeTableViewController()
//        home.tabBarItem.image = UIImage(named: "tabbar_home")
//        home.tabBarItem.selectedImage = UIImage(named: "tabbar_home_highlighted")
//        home.tabBarItem.title = "首页"
//        home.title = "首页"
//        let nav = UINavigationController()
//        nav.addChildViewController(home)
//        
//        addChildViewController(nav)
        
        addChildViewController(HomeTableViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(MessageTableViewController(), title: "消息", imageName: "tabbar_message_center")

        addChildViewController(ProfileTableViewController(), title: "我", imageName: "tabbar_profile")

        addChildViewController(DiscoverTableViewController(), title: "广场", imageName: "tabbar_discover")

        
    }
    
    /**
     初始化子控制器
     
     - parameter childController: 需要初始化的子控制器
     - parameter title:           子控制器的标题
     - parameter imageName:       子控制器的图片
     */
    private func addChildViewController(childController: UIViewController, title:String, imageName:String) {
        
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        childController.title = title
        
        let nav = UINavigationController()
        nav.addChildViewController(childController)
        
        addChildViewController(nav)
    
    }

}
