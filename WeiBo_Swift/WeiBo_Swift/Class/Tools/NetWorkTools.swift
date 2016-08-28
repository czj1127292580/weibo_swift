//
//  NetWorkTools.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/28.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit
import AFNetworking

class NetWorkTools: AFHTTPSessionManager {

    static let tools: NetWorkTools = {
        
        let url = NSURL(string: "https://api.weibo.com/")
        
        let t = NetWorkTools(baseURL: url)
        
        // 设置AFN能够接受的数据类型
        t.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set<String>
        return t
        
    }()
    
    class func shareNetWorkTools() -> NetWorkTools {
        return tools
    }
    
    
}
