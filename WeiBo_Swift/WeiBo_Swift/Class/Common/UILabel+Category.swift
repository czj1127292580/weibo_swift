//
//  UILabel+Category.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 2016/9/25.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

extension UILabel{
    
    // 快速创建UIlabel
    class func createLabel(color: UIColor, fontSize: CGFloat) -> UILabel{
        let label = UILabel()
        label.textColor = color
        label.font = UIFont.systemFontOfSize(fontSize)
        return label
    }
}
