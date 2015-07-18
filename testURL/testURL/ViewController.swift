//
//  ViewController.swift
//  testURL
//
//  Created by k on 15/7/17.
//  Copyright © 2015年 com.karottc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URLData()
        url.getHomeList2()
        sleep(2)   // 网络请求是异步的
        print("----------------------------------timestamp=\(url.id)")
        //url.getNextList(1436311798)
        url.getNextList(url.id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

