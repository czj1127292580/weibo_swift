//
//  String+Category.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/28.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

extension String {

    func cacheDir() -> String {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
    }
    
    
    func docDir() -> String {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
    }
    
    
    func tmpDir() -> String {
        let path = NSTemporaryDirectory() as NSString
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
    }
    
}

