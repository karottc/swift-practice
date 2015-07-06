//
//  ViewController.swift
//  game2048
//
//  Created by k on 15/7/6.
//  Copyright © 2015年 com.karottc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func startGame(sender: UIButton) {
        let alertController = UIAlertController(title: "开始！", message: "游戏就要开始，你准备好了吗？", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ready Go!", style: UIAlertActionStyle.Default, handler: {(alertAction:UIAlertAction) in
            self.presentViewController(MainTabViewController(), animated: true, completion: nil)
        }))
        self.presentViewController(alertController, animated:true, completion: nil)
        
        // 弹框按钮事件点击
        //alertController.delegate = self
    }
    
    //func alertView(alertAction:UIAlertAction) -> Void {
    //    self.presentViewController(MainTabViewController(), animated: true, completion: nil)
    //}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

