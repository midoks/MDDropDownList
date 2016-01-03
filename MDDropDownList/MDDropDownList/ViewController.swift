//
//  ViewController.swift
//
//  Created by midoks on 15/12/30.
//  Copyright © 2015年 midoks. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MDDropDownListDelegate {
    
    var dropDownList:MDDropDownList?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "导航下拉"
        
        //左边
        let rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("listFunc"))
        
        self.navigationItem.rightBarButtonItem  = rightButton
        
        self.view.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        
        
        
        self.dropDownList = MDDropDownList(frame: self.view.frame)
        self.dropDownList?.delegate = self
        self.dropDownList?.navHeight = self.navigationController!.navigationBar.frame.height + UIApplication.sharedApplication().statusBarFrame.height
        
        
        self.dropDownList?.add(UIImage(named: "conversation_options_qr.png")!, title: "扫一扫")
        self.dropDownList?.add(UIImage(named: "conversation_options_addmember.png")!, title: "加好友")
        self.dropDownList?.add(UIImage(named: "conversation_options_multichat.png")!, title: "创建讨论群")
        self.dropDownList?.add(UIImage(named: "conversation_options_transferfiles.png")!, title: "发送到电脑")
        self.dropDownList?.add(UIImage(named: "conversation_facetoface_qr.png")!, title: "面对面快传")
        self.dropDownList?.add(UIImage(named: "conversation_options_charge_icon.png")!, title: "收钱")
    }
    
    
    func listFunc(){
        //self.dropDownList?.show()
        
        self.dropDownList?.showAnimation()
    }
    
    //开始旋转
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        self.dropDownList?.hide()
    }
    
    //旋转后
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        
        self.dropDownList?.navHeight = self.navigationController!.navigationBar.frame.height + UIApplication.sharedApplication().statusBarFrame.height
        
        self.dropDownList?.setFrame(self.view.frame)
    }
    
    
    
    //MARK: - MDDropDownListDelegate -
    func MDDropDownListClick(num: Int) {
        print(num)
    }

}

