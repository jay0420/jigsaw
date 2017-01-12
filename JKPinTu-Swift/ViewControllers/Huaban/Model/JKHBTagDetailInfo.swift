//
//  JKHBTagDetailInfo.swift
//  PingTu-swift
//
//  Created by bingjie-macbookpro on 15/12/10.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

import UIKit

class JKHBTagDetailInfo: NSObject {

    var thumbnailImageURL:String!
    var originalImageURL:String!
    var seq:Int!
    
    class func parseDataFromHuaban(_ responseArray:Array<AnyObject>) -> Array<JKHBTagDetailInfo> {
        
        var objs = [JKHBTagDetailInfo]()
        for item in responseArray{
            
            let fileInfo = (item as! NSDictionary)["file"] as! NSDictionary
            let key = fileInfo["key"] as! String
            let seq = (item as! NSDictionary)["seq"] as! Int
            
            let tagDetail = JKHBTagDetailInfo()
            tagDetail.thumbnailImageURL = "http://img.hb.aicdn.com/" + key + "_fw" + String(236)
            tagDetail.originalImageURL = "http://img.hb.aicdn.com/" + key + "_fw" + String(658)
            tagDetail.seq = seq
            objs.append(tagDetail)
        }
        return objs
    }
    
}
