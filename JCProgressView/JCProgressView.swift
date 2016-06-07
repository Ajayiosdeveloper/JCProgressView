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
    
    public var progressColorLocations:[Double]?
    
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
        circularLayer.lineWidth = self.frame.width/4
        circularLayer.fillColor =  defaultBackGroundColor.CGColor
        circularLayer.strokeColor = UIColor(red: 0.8078, green: 0.2549, blue: 0.2392, alpha: 1.0).CGColor
    }
    
    private func animateCircle(){
    
        circularLayer.strokeEnd = 0
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat(0.1)
        animation.toValue = CGFloat(1.0)
        animation.duration = 1.0
        animation.removedOnCompletion = false
        animation.repeatCount = HUGE
        animation.fillMode = kCAFillModeForwards
        animation.autoreverses = false
        animation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear)
        circularLayer.addAnimation(animation, forKey: "strokeEnd")
       
    }
    
    private func gradientMask() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.allowsEdgeAntialiasing = true
        
        if  let _ = self.progressColors  where self.progressColors?.count > 1{
            gradientLayer.colors = self.getArrayOfCgColor(self.progressColors!)
        }else{
            gradientLayer.colors = addDefaultColorsToCircle()
        }
        
        if  let _ = self.progressColorLocations where self.progressColorLocations?.count > 1{
            gradientLayer.locations = self.progressColorLocations
        }else{
            gradientLayer.locations = addDefaultColorLocationsToCircle()
        }
        return gradientLayer
    }
    
    private func addDefaultColorsToCircle()->[AnyObject]{
    
        let colors = [UIColor.redColor().CGColor,UIColor.greenColor().CGColor,UIColor.orangeColor().CGColor,UIColor.yellowColor().CGColor]
       return colors
    }
    
    private func addDefaultColorLocationsToCircle()->[NSNumber]{
        
         let colorLocations = [0.0,0.3,0.6,0.9]
     
        return colorLocations
    }
    
    private func getArrayOfCgColor(colors:[UIColor])->[CGColor]{
      
        var cgColorsArray = [CGColor]()
        for color in colors{
            
            cgColorsArray.append(color.CGColor)
        }
       return cgColorsArray
    }
    
    public func startAnimation(){
        
        if let _ = self.layer.sublayers{
            
            for each in self.layer.sublayers!{
       
                each.removeFromSuperlayer()
            }
            addGradientLayerToView()
        }else{
          
            addGradientLayerToView()
        }
        
        self.animateCircle()
    }
    
    private func addGradientLayerToView(){
        circularLayer.fillColor = defaultBackGroundColor.CGColor
        let gradientMaskLayer = gradientMask()
        gradientMaskLayer.mask = circularLayer
        gradientMaskLayer.cornerRadius = self.bounds.width/2
        layer.addSublayer(gradientMaskLayer)
    }
    
    public func stopAnimation(){
        
     circularLayer.removeAllAnimations()
     circularLayer.fillColor = nil
    }

}
