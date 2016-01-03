//
//
//  Created by midoks on 15/12/30.
//  Copyright © 2015年 midoks. All rights reserved.
//

import UIKit

class MDDropDownBackView:UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        //self.backgroundColor = UIColor.blueColor()
        //self.layer.opacity = 0.3
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("tap"))
        self.addGestureRecognizer(tap)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //点击消失
    func tap(){
        
        UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            
            self.layer.opacity = 0.0
            
            }) { (status) -> Void in
                
                self.hide()
                
                self.layer.opacity = 1
        }
        
    }
    
    func hide(){
        self.removeFromSuperview()
    }
    
}

class MDDropDownListView:UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//下拉类
class MDDropDownList:NSObject {
    
    var delegate:MDDropDownListDelegate?
    
    var bbView:UIView?
    
    var listView:UIView?
    
    var listButton: Array<UIButton> = Array<UIButton>()
    var listTriangleButton:UIButton?
    
    var listSize:CGSize = CGSize(width: 100.0, height: 35.0)
    var listImageSize:CGSize = CGSize(width: 20.0, height: 20.0)
    var navHeight:CGFloat = 64.0
    
    init(frame: CGRect) {
        super.init()
        
        self.bbView = MDDropDownBackView(frame: frame)
        
        
        self.listView = MDDropDownListView(frame: CGRect(x: frame.width - self.listSize.width - 5, y: self.navHeight, width: self.listSize.width, height: 0))
        self.listView!.backgroundColor = UIColor.whiteColor()
        self.listView!.layer.cornerRadius = 3
        
        self.bbView?.addSubview(self.listView!)
        
        self.listTriangleButton = UIButton(frame: CGRect(x: frame.width - 33, y: self.navHeight - 13, width: 15, height: 15))
        
        self.listTriangleButton?.setTitle("▲", forState: .Normal)
        self.listTriangleButton?.titleLabel?.font = UIFont.boldSystemFontOfSize(15.0)
        //self.listTriangleButton?.backgroundColor = UIColor.redColor()
        self.bbView?.addSubview(self.listTriangleButton!)
        
        
        //        let u = UIButton(frame: CGRect(x: 0, y: 0, width: self.listSize.width, height: self.listSize.height))
        //        u.tag = 0
        //        u.setImage(UIImage(named: "conversation_options_qr.png"), forState: .Normal)
        //        u.setImage(UIImage(named: "conversation_options_qr.png"), forState: .Highlighted)
        //        u.setTitle("扫一扫", forState: .Normal)
        //        u.setTitleColor(UIColor.blackColor(), forState: .Normal)
        //
        //        u.backgroundColor = UIColor.whiteColor()
        //
        //        u.titleEdgeInsets = UIEdgeInsetsMake(5.0, 5.0 - self.listImageSize.width - 30, 5.0, 5.0)
        //        u.imageEdgeInsets = UIEdgeInsetsMake(5.0, 5.0, 5.0, self.listSize.width - self.listImageSize.width - (5.0*2))
        //
        //        u.addTarget(self, action: Selector("listClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        //        u.addTarget(self, action: Selector("touchDown:"), forControlEvents: UIControlEvents.TouchDown)
        //        u.addTarget(self, action: Selector("touchDragOutside:"), forControlEvents: UIControlEvents.TouchDragOutside)
        //        self.listView?.addSubview(u)
        
        
    }
    
    //重新设置位置
    func setFrame(frame: CGRect){
        
        self.listView?.frame = CGRect(x: frame.width - self.listSize.width - 5, y: self.navHeight, width: self.listSize.width, height: self.listView!.frame.height)
        
        self.listTriangleButton?.frame = CGRect(x: frame.width - 36, y: self.navHeight - 13, width: 15, height: 15)
        self.bbView?.frame = frame
    }
    
    //MARK: - Private Methods -
    //生成纯色背景
    func imageWithColor(color:UIColor, size: CGSize) -> UIImage {
        let rect = CGRectMake(0, 0, size.height, size.height)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    //点击
    func listClick(s:UIButton){
        self.delegate?.MDDropDownListClick?(s.tag)
        self.hide()
        self.touchDragOutside(s)
    }
    
    //鼠标按下操作
    func touchDown(s:UIButton){
        s.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
    }
    
    //鼠标按下离开操作
    func touchDragOutside(s:UIButton){
        s.backgroundColor = UIColor.whiteColor()
    }
    
    //添加按钮
    func add(icon:UIImage, title:String){
        
        let c = self.listButton.count
        
        let bheight = self.listSize.height * CGFloat(c)
        let bbViewHeight = self.listSize.height * CGFloat(c+1)
        
        self.listView?.frame = CGRect(x: (self.listView?.frame.origin.x)!, y: (self.listView?.frame.origin.y)!, width: (self.listView?.frame.size.width)!, height: bbViewHeight)  // self.listSize.height * CGFloat(c+1)
        
        let u = UIButton(frame: CGRect(x: 0, y: bheight, width: self.listSize.width, height: self.listSize.height))
        u.tag = c
        u.setImage(icon, forState: .Normal)
        u.setImage(icon, forState: .Highlighted)
        u.setTitle(title, forState: .Normal)
        u.setTitleColor(UIColor.blackColor(), forState: .Normal)
        u.layer.cornerRadius = 3
        
        u.titleLabel?.font = UIFont.boldSystemFontOfSize(12.0)
        
        u.backgroundColor = UIColor.whiteColor()
        
        u.contentHorizontalAlignment = .Left
        
        //u.titleLabel?.textAlignment = .Left
        u.titleEdgeInsets = UIEdgeInsetsMake(5.0, 5.0 - self.listImageSize.width, 5.0, 5.0)
        u.imageEdgeInsets = UIEdgeInsetsMake(5.0, 5.0, 5.0, self.listSize.width - self.listImageSize.width - (5.0*2))
        
        u.addTarget(self, action: Selector("listClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        u.addTarget(self, action: Selector("touchDown:"), forControlEvents: UIControlEvents.TouchDown)
        u.addTarget(self, action: Selector("touchDragOutside:"), forControlEvents: UIControlEvents.TouchDragOutside)
        
        if c>0 {
            let line = UIView(frame: CGRect(x: 0, y: 0, width: u.frame.width, height: 1))
            line.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
            u.addSubview(line)
        }
        
        self.listView?.addSubview(u)
        self.listButton.append(u)
    }
    
    //显示
    func show(){
        UIApplication.sharedApplication().windows.first?.addSubview(self.bbView!)
    }
    
    //动画显示特效
    func showAnimation(){
        
        self.show()
        
        let sFrame = self.listView?.frame
        
        
        self.listView?.frame.size = CGSize(width: 0.0, height: 0.0)
        self.listView?.frame.origin.x = sFrame!.origin.x + (sFrame?.width)!
        
        self.listView?.layer.opacity = 0
        self.listTriangleButton?.layer.opacity = 0
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            
            self.listView?.frame.size.height += sFrame!.size.height
            self.listView?.frame.origin.x -= (sFrame?.width)!
            
            self.listView?.layer.opacity = 1
            self.listTriangleButton?.layer.opacity = 0.6
            }) { (status) -> Void in
                
                
                self.listView?.layer.opacity = 1
                self.listTriangleButton?.layer.opacity = 1
                
                self.listView?.frame = sFrame!
        }
    }
    
    //隐藏
    func hide(){
        self.bbView!.removeFromSuperview()
    }
    
}

//导航列表下拉代理
@objc protocol  MDDropDownListDelegate : NSObjectProtocol{
    optional func MDDropDownListClick(num:Int)
}
