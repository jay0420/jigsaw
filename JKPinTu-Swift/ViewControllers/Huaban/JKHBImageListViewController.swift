//
//  JKHBImageListViewController.swift
//  PingTu-swift
//
//  Created by bingjie-macbookpro on 15/12/10.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

//jack wang

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import MJRefresh
import MBProgressHUD

final class JKHBImageListViewController: UICollectionViewController {

    fileprivate var tags = [JKHBTagDetailInfo]()
    
    var tagName:String? = ""
    
    convenience init(){
        let layout = UICollectionViewFlowLayout()
        let width = SCREEN_WIDTH/3 - 2
        layout.itemSize = CGSize(width: width, height: width * 1.5)
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 2
        layout.scrollDirection = .vertical
        self.init(collectionViewLayout:layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        
        self.collectionView!.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(JKHBImageListViewController.headerRefresh))
        self.collectionView!.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(JKHBImageListViewController.footerRefresh))
        self.collectionView!.mj_header.beginRefreshing()
    }
    
    func headerRefresh(){
        
        self.sendRequest(0)
    }
    func footerRefresh(){
        var seq = 0
        if self.tags.count != 0{
            let lastObjc = self.tags.last
            seq = lastObjc!.seq == 0 ? 0 : lastObjc!.seq
        }
        self.sendRequest(seq)
    }
    
    func sendRequest(_ seq:Int){
        
        let max = seq == 0 ? "" : "\(seq)"
        
        
        
        Alamofire.request("http://api.huaban.com/fm/wallpaper/pins", parameters: ["limit": 21 , "tag":self.tagName! , "max": max]).responseJSON {   response in
          
            
            switch response.result {
            case .success:
                if let JSON = response.result.value {
                    let pins = (JSON as! NSDictionary)["pins"]
                    let tempTags = JKHBTagDetailInfo.parseDataFromHuaban(pins as! Array)
                    self.tags =  seq != 0 ? (self.tags + tempTags) : tempTags
                    self.collectionView?.reloadData()
                    self.collectionView!.mj_header.endRefreshing()
                    self.collectionView!.mj_footer.endRefreshing()
                
                }
            case .failure(let error):
                print(error)
            }
            
            
        }

       
//jack wang  下面是原始代码：
//        Alamofire.request(.GET, "http://api.huaban.com/fm/wallpaper/pins", parameters: ["limit": 21 , "tag":self.tagName! , "max": max]).jk_responseSwiftyJSON { (request, response, JSON_obj, error) -> Void in
//            if JSON_obj == JSON.null {
//                return
//            }
//            let pins = (JSON_obj.object as! NSDictionary)["pins"]
//            let tempTags = JKHBTagDetailInfo.parseDataFromHuaban(pins as! Array)
//            self.tags =  seq != 0 ? (self.tags + tempTags) : tempTags
//            self.collectionView?.reloadData()
//            self.collectionView!.mj_header.endRefreshing()
//            self.collectionView!.mj_footer.endRefreshing()
//            
//        }
    }


    
    
    
    
    
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tags.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.contentView.backgroundColor = UIColor.white
        
        var imageView = cell.contentView.viewWithTag(1111) as? UIImageView
        if(imageView == nil){
            imageView = UIImageView(frame: cell.bounds)
            imageView!.tag = 1111
            imageView?.clipsToBounds = true
            imageView?.contentMode = .scaleAspectFill
            cell.contentView.addSubview(imageView!)
        }
        let tag = self.tags[indexPath.row]
         imageView!.kf.setImage(with: URL(string: tag.thumbnailImageURL)!)
//        imageView!.kf_setImageWithURL(URL(string: tag.thumbnailImageURL)!)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let tag = self.tags[indexPath.row]
        let url = URL(string: tag.originalImageURL)
        
        
        KingfisherManager.shared.downloader.downloadImage(with: url!, options: nil, progressBlock: { (receivedSize, totalSize) -> () in
            
            
            //            let progress = Float(receivedSize)/Float(totalSize)
            
        }, completionHandler: { [unowned self] (image, error, imageURL, originalData) -> () in
            
            (self.navigationController as! JKHBNavigationController).dismissClick({ [unowned self] () -> Void in
                if((self.navigationController as! JKHBNavigationController).imageBlock != nil){
                    jacklog.debug("\(image)")
                    (self.navigationController as! JKHBNavigationController).imageBlock!(image!)
                }
            })
        })
        // jack wang
        
//        KingfisherManager.shared.downloader.downloadImageWithURL(url!, progressBlock: { (receivedSize, totalSize) -> () in
        
 
//            let progress = Float(receivedSize)/Float(totalSize)

//            }) { [unowned self] (image, error, imageURL, originalData) -> () in
//                
//                (self.navigationController as! JKHBNavigationController).dismissClick({ [unowned self] () -> Void in
//                    if((self.navigationController as! JKHBNavigationController).imageBlock != nil){
//                        (self.navigationController as! JKHBNavigationController).imageBlock!(image!)
//                    }
//                })
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
