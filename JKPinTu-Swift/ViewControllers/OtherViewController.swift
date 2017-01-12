//
//  OtherViewController.swift
//  PingTu-swift
//
//  Created by bingjie-macbookpro on 15/12/7.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

import UIKit

class OtherViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    let photoTotalNumber = 5

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.table!.delegate = self
        self.table!.dataSource = self
        self.navigationController?.hidesBarsOnSwipe = true

    }

    // UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return     photoTotalNumber

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.width
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.none
        
        var imageView = cell.contentView.viewWithTag(1111) as? UIImageView
        if(imageView == nil){
            imageView = UIImageView(frame: cell.bounds)
            imageView!.tag = 1111
            cell.contentView.addSubview(imageView!)
        }
        let name = "00" + String(indexPath.row)
        imageView?.image = UIImage(named: name)
        
        return cell
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
