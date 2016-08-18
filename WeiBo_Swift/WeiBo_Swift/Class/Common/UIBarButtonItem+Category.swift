//
//  UIBarButtonItem+Category.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/18.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

extension UIBarButtonItem{

    // 如果在func前面加上class，就相当于OC中的+
    class func createBarButtonItem(imageName: String, target: AnyObject?, action: Selector) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        return UIBarButtonItem(customView: btn)
    }
    
}