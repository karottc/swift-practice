//
//  ViewFactory.swift
//  game2048
//
//  Created by k on 15/7/7.
//  Copyright © 2015年 com.karottc. All rights reserved.
//

import Foundation
import UIKit

class ViewFactory {
    class func getDefaultFrame() -> CGRect {
        let defaultFrame = CGRectMake(0, 0, 100, 30)
        return defaultFrame
    }
    
    class func createControl(type:String, title:[String], action:Selector, sender:AnyObject) -> UIView {
        switch(type) {
            case "label":
                return ViewFactory.createLabel(title[0])
            case "button":
                return ViewFactory.createButton(title[0], action:action, sender:sender as! UIViewController)
            case "text":
                return ViewFactory.createTextField(title[0], action:action, sender:sender as! UITextFieldDelegate)
            case "segment":
                return ViewFactory.createSegment(title, action:action, sender: sender as! UIViewController)
            default:
                return ViewFactory.createLabel(title[0])
        }
    }
    
    class func createButton(title:String, action:Selector, sender:UIViewController) -> UIButton {
        let button = UIButton(frame:ViewFactory.getDefaultFrame())
        
        button.backgroundColor = UIColor.orangeColor()
        button.setTitle(title, forState: .Normal)
        button.titleLabel!.textColor = UIColor.whiteColor()
        button.titleLabel!.font = UIFont.systemFontOfSize(16)
        
        button.addTarget(sender, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
    }
    
    class func createTextField(value:String, action:Selector, sender:UITextFieldDelegate) -> UITextField {
        let textFiled = UITextField(frame: ViewFactory.getDefaultFrame())
        textFiled.backgroundColor = UIColor.clearColor()
        textFiled.textColor = UIColor.blackColor()
        textFiled.text = value
        textFiled.borderStyle = UITextBorderStyle.RoundedRect
        textFiled.adjustsFontSizeToFitWidth = true
        textFiled.delegate = sender
        
        return textFiled
    }
    
    class func createSegment(items: [String], action:Selector, sender:UIViewController) -> UISegmentedControl {
        let segment = UISegmentedControl(items: items)
        segment.frame = ViewFactory.getDefaultFrame()
        segment.momentary = false
        segment.addTarget(sender,action:action,forControlEvents:UIControlEvents.ValueChanged)
        
        return segment
    }
    
    class func createLabel(title:String) -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.blackColor()
        label.backgroundColor = UIColor.whiteColor()
        label.text = title
        label.frame = ViewFactory.getDefaultFrame()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        
        return label
    }
}