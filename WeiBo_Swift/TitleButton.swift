//
//  TitleButton.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/19.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Selected)
        sizeToFit()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
//        titleLabel?.frame.offsetInPlace(dx: -imageView!.bounds.width * 0.5, dy: 0)
//        imageView?.frame.offsetInPlace(dx: titleLabel!.bounds.width * 0.5, dy: 0)
        
        // swift中可以直接取出结构体中的成员
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.size.width
    }
}
