//
//  UIButton+Category.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 2016/9/25.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

extension UIButton{
    class func createButton(imageName: String, title: String) -> UIButton{
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setTitle(title, forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(10)
        btn.setBackgroundImage(UIImage(named: "timeline_card_bottom_background"), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        return btn
    }
}
