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
        
        let path = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)
        if let jsonPath = path{
            let jsonData = NSData(contentsOfFile: jsonPath)
            
            do{
                // 有可能发生异常的代码放到这里
                // 序列化.json数据->Array
                // try : 发生异常会跳到catch中继续执行
                // try! : 发生异常程序会直接崩溃
                let dictArr = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers)
                print(dictArr)
                // 遍历数组
                // 在swift中，如果需要遍历一个数组，必须明确数据的类型
                for dict in dictArr as! [[String: String]] {
                    addChildViewController(dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
                }

            }catch{
                // 发生异常之后会执行的代码
                print(error)
                
                // 如果服务器没有，从本地创建控制器
                addChildViewController("HomeTableViewController", title: "首页", imageName: "tabbar_home")
                addChildViewController("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
                
                addChildViewController("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
                
                addChildViewController("DiscoverTableViewController", title: "广场", imageName: "tabbar_discover")

            }
            
        }
        
        
//        addChildViewController("HomeTableViewController", title: "首页", imageName: "tabbar_home")
//        addChildViewController("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
//
//        addChildViewController("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
//
//        addChildViewController("DiscoverTableViewController", title: "广场", imageName: "tabbar_discover")

        
    }
    
    /**
     初始化子控制器
     
     - parameter childController: 需要初始化的子控制器
     - parameter title:           子控制器的标题
     - parameter imageName:       子控制器的图片
     */
    private func addChildViewController(childControllerName: String, title:String, imageName:String) {
        
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
        
        let cls:AnyClass? = NSClassFromString(ns + "." + childControllerName)
        
        let vcCls = cls as! UIViewController.Type
        let vc = vcCls.init()
        
        
        
        
        
        
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        vc.title = title
        
        let nav = UINavigationController()
        nav.addChildViewController(vc)
        
        addChildViewController(nav)
    
    }

}
