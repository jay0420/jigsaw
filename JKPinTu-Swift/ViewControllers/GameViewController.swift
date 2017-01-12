//
//  GameViewController.swift
//  PingTu-swift
//
//  Created by bingjie-macbookpro on 15/12/5.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

import UIKit



class GameViewController: BaseViewController {
    
    let photoTotalNumber = 5
    var gameView : GameView!
    var preView : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.edgesForExtendedLayout = .None
//        self.extendedLayoutIncludesOpaqueBars = true
        self.view.backgroundColor = UIColor.white
        self.title = "拼图"
        
        let settingButton = UIBarButtonItem(title: "设置", style: .plain, target: self, action: #selector(GameViewController.settingButtonClick))
        let refreshButton = UIBarButtonItem(title: "换图", style: .plain, target: self, action: #selector(GameViewController.changePhotoClick))
        let huabanButton = UIBarButtonItem(title: "花瓣", style: .plain, target: self, action: #selector(GameViewController.huabanClick))
        self.navigationItem.rightBarButtonItems = [huabanButton,refreshButton,settingButton]
        
        // Do any additional setup after loading the view.
        let rect = CGRect(x: 20, y: 10, width: SCREEN_WIDTH - 2*20, height: SCREEN_WIDTH - 2*20)
        self.gameView = GameView(frame: rect)
        gameView.backgroundColor = UIColor.clear
        self.view.addSubview(gameView)
        
        let chechButton = UIButton(type: .custom)
        chechButton.setTitle("check", for: UIControlState())
        chechButton.setTitleColor(UIColor.randomColor(), for: UIControlState())
        chechButton.addTarget(self, action: #selector(GameViewController.checkGameOver(_:)), for: .touchUpInside)
        chechButton.frame = CGRect(x: 0, y: self.gameView.bottom() + 10, width: SCREEN_WIDTH/3, height: 20)
        self.view.addSubview(chechButton)
        
        let randomButton = UIButton(type: .custom)
        randomButton.setTitle("随机一下", for: UIControlState())
        randomButton.setTitleColor(UIColor.randomColor(), for: UIControlState())
//        randomButton.addTarget(self, action: Selector("randomButton"), forControlEvents: .TouchUpInside)
        randomButton.frame = CGRect(x: chechButton.right(), y: self.gameView.bottom() + 10, width: SCREEN_WIDTH/3, height: 20)
        self.view.addSubview(randomButton)
        randomButton.rac_signal(for: .touchUpInside).subscribeNext { (button) -> Void in
            self.randomButton()
        }
        
        let completeButton = UIButton(type: .custom)
        completeButton.setTitle("自动完成", for: UIControlState())
        completeButton.setTitleColor(UIColor.randomColor(), for: UIControlState())
//        completeButton.addTarget(self, action: Selector("completeButton"), forControlEvents: .TouchUpInside)
        completeButton.frame = CGRect(x: randomButton.right(), y: self.gameView.bottom() + 10, width: SCREEN_WIDTH/3, height: 20)
        self.view.addSubview(completeButton)
        completeButton.rac_signal(for: .touchUpInside).subscribeNext { (button) -> Void in
            self.completeButton()
        }
        
        self.preView = UIImageView()
        self.preView.frame = CGRect(x: 0, y: chechButton.frame.origin.y + chechButton.frame.size.height + 15, width: SCREEN_WIDTH, height: self.view.bounds.size.height - chechButton.frame.origin.y - chechButton.frame.size.height - STATUSBARHEIGHT - TOPBARHEIGHT - 30)
        self.preView.contentMode = .scaleAspectFit
        self.view.addSubview(self.preView)
        
        self.changePhotoClick()
        
        self.gameView.numberOfRows = 4
    }
    
    func huabanClick(){
    
        let nav:JKHBNavigationController = JKHBNavigationController.initJKHBNavigationController()
        nav.imageBlock = { (image) -> Void in
            let newImage = self.dealWithImage(image as! UIImage)
            self.gameView.image = newImage
            self.preView.image = newImage
        }

        self.present(nav, animated: true) { () -> Void in
        }
    }
    
    func dealWithImage(_ image:UIImage) -> UIImage {
        let w = image.size.width
        let h = image.size.height
        let imageWidth = w>h ? h: w
        let px = w>h ? (w - imageWidth)*0.5 : 0
        let py = w>h ? 0 : (h - imageWidth)*0.5
        let newImage = UIImage.clipImage(image, withRect: CGRect(x: px, y: py, width: imageWidth, height: imageWidth))
        return newImage
    }
    
    func settingButtonClick(){
        
        let alertController = UIAlertController(title: "设置", message: "", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let array = [3,4,5,6]
        for value in array{
            let name = String(value) + "*" +  String(value)
            let a = UIAlertAction(title: name, style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
                self.gameView.numberOfRows = value
            }
            alertController.addAction(a)
        }
        
        let mode1 = UIAlertAction(title: "正常模式", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            self.gameView.gameMode = .normal
        }
        alertController.addAction(mode1)
        
        let mode2 = UIAlertAction(title: "对换模式", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            self.gameView.gameMode = .swapping
        }
        alertController.addAction(mode2)
        
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func changePhotoClick(){
        let index = arc4randomInRange(0, to: photoTotalNumber )
        let imageName = "00" + String(index)
        self.gameView.image = UIImage(named: imageName)
        self.preView.image = UIImage(named: imageName)    }
    
    func randomButton(){
        self.gameView.randomGrids()
    }
    
    func completeButton(){
        
//        if self.gameView.gameMode == .swapping{
//            return
//        }
        self.gameView.completeAllGridByPositions()
    }
    
    
    func checkGameOver(_ button:UIButton){
        
        if(self.gameView.checkGameOver() == true){
            button.setTitle("恭喜成功", for: UIControlState())
        }else{
            button.setTitle("check again", for: UIControlState())
        }
    }
    
}
