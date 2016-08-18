//
//  HomeTableViewController.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/15.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 如果没有登录，就设置未登录界面的信息
        if !userLogin {
            visitorView?.setupVisitorInfo(true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        // 初始化导航条
        setupNav()
    }
    
    private func setupNav() {
        
        navigationItem.leftBarButtonItem =  UIBarButtonItem.createBarButtonItem("navigationbar_friendattention", target: self, action: #selector(leftItemClick))
        
        navigationItem.rightBarButtonItem =  UIBarButtonItem.createBarButtonItem("navigationbar_pop", target: self, action: #selector(rightItemClick))
        
        // 初始化标题按钮
        let titleBtn = TitleButton()
        titleBtn.setTitle("岑志军 ", forState: UIControlState.Normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick), forControlEvents: .TouchUpInside)
        navigationItem.titleView = titleBtn;
        
        
    }
    
    func titleBtnClick(btn: TitleButton) {
        btn.selected = !btn.selected
    }
    
    func leftItemClick() {
        print(#function)
    }

    func rightItemClick() {
        print(#function)
    }



}
