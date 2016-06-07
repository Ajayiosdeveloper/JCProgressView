//  Thanks LORD my God.Jesus Christ.Amen
//  JCProgressView.swift
//  JCProgressView
//
//  Created by ajaybabu singineedi on 07/06/16.
//  Copyright © 2016 Exilant Technologies. All rights reserved.
//

import UIKit

let defaultBackGroundColor = UIColor(colorLiteralRed:0, green: 127/255, blue: 231/255, alpha: 0.1)


public class JCProgressView: UIView {
    
    private var circularLayer = CAShapeLayer()
    
    public var progressColors:[UIColor]?
    
    public var allowsMultipleColors = true
    
    public var progressColor: UIColor?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = defaultBackGroundColor
        drawCircle(frame)
    
    }
    
    public init(frame: CGRect,background:UIColor) {
       
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        drawCircle(frame)
        
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
        drawCircle(self.bounds)
    }
    
    private func drawCircle(rect:CGRect){
       
        let path = UIBezierPath(ovalInRect:rect)
        circularLayer.path = path.CGPath
        circularLayer.lineWidth = 4
        circularLayer.fillColor = nil
        circularLayer.strokeColor = UIColor(red: 0.8078, green: 0.2549, blue: 0.2392, alpha: 1.0).CGColor
        
         let gradientMaskLayer = gradientMask()
        
         gradientMaskLayer.mask = circularLayer
         layer.addSublayer(gradientMaskLayer)
        
        //self.layer.addSublayer(circularLayer)
    }
    
    private func animateCircle(){
    
        circularLayer.strokeEnd = 0.0
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat(0.0)
        animation.toValue = CGFloat(1.0)
        animation.duration = 1.0
        animation.removedOnCompletion = false
        animation.repeatCount = HUGE
        animation.fillMode = kCAFillModeForwards
        circularLayer.addAnimation(animation, forKey: "strokeEnd")
       
    }
    
    private func gradientMask() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.locations = [0.0, 0.5 ,1.0]
        
        let colorTop: AnyObject = UIColor.redColor().CGColor
        let middleColor:AnyObject = UIColor.yellowColor().CGColor
        let colorBottom: AnyObject = UIColor.blueColor().CGColor
        let arrayOfColors: [AnyObject] = [colorTop, middleColor,colorBottom]
        gradientLayer.colors = arrayOfColors
        
        return gradientLayer
    }
    
    
    public func startAnimation(){
    
        self.animateCircle()
    }
    
    public func stopAnimation(){
        
     circularLayer.removeAllAnimations()
        
    }

    /*
     Only override drawRect: if you perform custom drawing.
     An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
         Drawing code
    }
    */

}
