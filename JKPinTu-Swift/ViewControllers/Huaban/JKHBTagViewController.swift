//
//  JKHBTagViewController.swift
//  PingTu-swift
//
//  Created by bingjie-macbookpro on 15/12/10.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MJRefresh
import SwiftyBeaver

final class JKHBTagViewController: UITableViewController {

    fileprivate let cellIdentifier = "UITableViewCell"
    
    fileprivate var tags = [JKHBTagInfo]()


    override func viewDidLoad() {
        super.viewDidLoad()
        print("美图分类")
        self.edgesForExtendedLayout = UIRectEdge()
        self.title = "美图分类"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(JKHBTagViewController.sendRequest))
        self.tableView.mj_header.beginRefreshing()
    }
    
    func sendRequest(){
 
        
        
        
        
        Alamofire.request("http://api.huaban.com/fm/wallpaper/tags").responseJSON{   response in
//            print(response.request)  // original URL request
//            print(response.response) // HTTP URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
            
            switch response.result {
            case .success:
                print("Validation Successful")
                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
                    let tempTags = JKHBTagInfo.parseDataFromHuaban(JSON as! Array)
                    self.tags = tempTags
                    self.tableView.reloadData()
                    self.tableView.mj_header.endRefreshing()
                }
            case .failure(let error):
                print(error)
            }
            
          
        }
        
        //jack wang  原始代码：
//        Alamofire.request(.GET, "http://api.huaban.com/fm/wallpaper/tags").responseSwiftyJSON { (request, response, JSON_obj, error) -> Void in
//            if JSON_obj == JSON.null {
//                return
//            }
//            let tempTags = JKHBTagInfo.parseDataFromHuaban(JSON_obj.object as! Array)
//            self.tags = tempTags
//            self.tableView.reloadData()
//            self.tableView.mj_header.endRefreshing()
//            
//        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.tags.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if(cell == nil){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
            cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell?.textLabel?.textColor = UIColor.black
            cell?.detailTextLabel?.textColor = UIColor.gray
        }
        
        let tag = self.tags[indexPath.row]
        
        let tagName = tag.tag_name
        let pinCountString = " 共\(tag.pin_count!)张"
        let displayString = tagName! + pinCountString


        let attributedString = NSMutableAttributedString(string: displayString, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 17)])

        attributedString.setAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 11),NSForegroundColorAttributeName:UIColor.gray], range: NSMakeRange((tagName?.characters.count)!, pinCountString.characters.count))
        cell?.textLabel?.attributedText = attributedString

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let tag = self.tags[indexPath.row]
        let vc = JKHBImageListViewController()
        vc.tagName = tag.tag_name
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

class JKHBNavigationController:BaseNavigationController {
    
    var imageBlock : ((AnyObject) -> Void)?
    
    class func initJKHBNavigationController()->JKHBNavigationController{
        let vc = JKHBTagViewController()
        let nav:JKHBNavigationController = JKHBNavigationController(rootViewController:vc)
//        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: nav, action: #selector(JKHBNavigationController.dismiss))
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: nav, action: #selector(dismissself))

        return nav
    }
    
    func dismiss(){
        self.dismissClick { () -> Void in
        }
    }
    //关键字冲突
    func dismissself(){
        self.dismissClick { () -> Void in
        }
    }
    func dismissClick(_ completion: (() -> Void)?){
        self.dismiss(animated: true, completion: completion)
    }
    
    override func viewDidLoad() {
        
    }
}
