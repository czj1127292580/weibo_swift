//
//  User.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/9/1.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

class User: NSObject {

    var id: Int = 0
    
    var name: String?
    
    var profile_image_url: String?{
        didSet{
            if let urlStr = profile_image_url {
                imageUrl = NSURL(string: urlStr)
            }
        }
    }
    
    // 用于保存用户头像的URL
    var imageUrl: NSURL?
    
    var verified: Bool = false
    
    // 用户的认证类型，-1：没有认证、0：认证用户、2，3，5：企业认证、220：达人
    var verified_type: Int = -1{
        didSet{
            switch verified_type {
            case 0:
                verifiedImage = UIImage(named: "avatar_vip")
            case 2,3,5:
                verifiedImage = UIImage(named: "avatar_enterprise_vip")
            case 220:
                verifiedImage = UIImage(named: "avatar_grassroot")
            default:
                verifiedImage = nil
            }
        }
    }
    
    var user: User?
    
    // 保存当前用户的认证图片
    var verifiedImage: UIImage?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        super.setValue(value, forKey: key)
        
        if "user" == key {
            user = User(dict: value as! [String : AnyObject])
            return
        }
    }
    
    // 打印当前模型
    var properties = ["id", "name", "profile_image_url", "verified", "verified_type",]
    override var description: String{
        let dict = dictionaryWithValuesForKeys(properties)
        
        return "\(dict)"
    }

}
