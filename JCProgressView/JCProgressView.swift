//  Thanks LORD my God.Jesus Christ.Amen
//  JCProgressView.swift
//  JCProgressView
//
//  Created by ajaybabu singineedi on 07/06/16.
//  Copyright © 2016 Exilant Technologies. All rights reserved.
//

import UIKit


public protocol JCProgressViewDelegate : class{
    
    func willStartAnimation()
    
    func willStopAnimation()
    
    func didStartAnimation()
    
    func didStopAnimation()
}

let defaultBackGroundColor = UIColor(colorLiteralRed:0, green: 127/255, blue: 231/255, alpha: 0.1) // As discussed in the requirements


public class JCProgressView: UIView {
    
    private var circularLayer = CAShapeLayer() // to make animations more easier by using CAShapeLayer property (strokeEnd).
    
    public var progressColors:[UIColor]? // As discussed in requirements
    
    // ProgressColors must contains atleast two colors.
    
    public var progressColorLocations:[Double]? // As discussed in 
    
    //requirements. ProgressColorLocations must contains atleast two 
    
    //values (0 - 1.0).

    
    public var allowsMultipleColors = true // set this to false to avoid multicolor ring
    
    public var allowsFadeAnimation = true // set this false to avoid fade animation
    
    public var progressColor: UIColor? // set this value to have a user defined single colored progress View. if it is nil then default color will be taken
    
    public var duration: Double = 1.0
    
    public var progressBackgroundColor:UIColor = UIColor.clearColor()
    
    public weak var delegate:JCProgressViewDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        drawCircle(frame)
    }
    
    public init(frame: CGRect,colors:[UIColor],locations:[Double]) {
       
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.progressColors = colors
        self.progressColorLocations = locations
        drawCircle(frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
        drawCircle(self.bounds)
    }
    
    //MARK: Private Services
    
    /* Drawing Circle using UIBezier Path with top as Start angle and adding to CAShapeLayer */
    
    private func drawCircle(rect:CGRect){
        
        let center = CGPoint(x:rect.size.width/2, y: rect.size.height/2)
        
        let path = UIBezierPath(arcCenter:center , radius: rect.width/2, startAngle:CGFloat(-M_PI_2) , endAngle: CGFloat(M_PI_2 + M_PI) , clockwise: true)
        
        circularLayer.path = path.CGPath
        circularLayer.lineWidth = self.frame.width/4
        circularLayer.fillColor =  progressBackgroundColor.CGColor
        circularLayer.lineCap = kCALineCapRound
        circularLayer.strokeColor = UIColor.whiteColor().CGColor
    }
    
    /* adding Annimation to the strokeEnd property of the CAShapeLayer*/
    
    private func animateCircle(){
    
        circularLayer.strokeEnd = 0
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat(0.1)
        animation.toValue = CGFloat(1.0)
        animation.duration = duration
        animation.removedOnCompletion = false
        animation.repeatCount = HUGE
        animation.fillMode = kCAFillModeForwards
        animation.autoreverses = false
        animation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear)
        circularLayer.addAnimation(animation, forKey: "strokeEnd")
        
        if allowsFadeAnimation{
          addFadeAnimation()
        }
    }
    
    private func addFadeAnimation(){
        
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.toValue = 0.7
        fadeAnimation.duration = 2.0
        fadeAnimation.repeatCount = HUGE
        circularLayer.addAnimation(fadeAnimation, forKey: "flashAnimation")
    }
    
    /* Creating Gradient layer with multi colors and specified locations*/
    
    private func gradientMask() -> CAGradientLayer {
       
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.allowsEdgeAntialiasing = true
        
        if self.allowsMultipleColors{
        
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
        
        }
        else{
            
            if let _ = progressColor{
                
                gradientLayer.colors = [(progressColor?.CGColor)!,(progressColor?.CGColor)!]
            }else{
                
                gradientLayer.colors = [UIColor.grayColor().CGColor,UIColor.grayColor().CGColor]
            }
            
        }
        return gradientLayer
    }
    
    // adding default colors to gradient layer if progressColors.count is nil or less than 2
    
    private func addDefaultColorsToCircle()->[AnyObject]{
    
        let colors = [UIColor.redColor().CGColor,UIColor.greenColor().CGColor,UIColor.orangeColor().CGColor,UIColor.yellowColor().CGColor]
       return colors
    }
    
     // adding default color locations to gradient layer if ProgressColorLocations.count is nil or less than 2
    
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
    
    private func addGradientLayerToViewLayer(){
        
        circularLayer.fillColor = progressBackgroundColor.CGColor
        let gradientMaskLayer = gradientMask()
        gradientMaskLayer.mask = circularLayer
        gradientMaskLayer.cornerRadius = self.bounds.width/2
        layer.addSublayer(gradientMaskLayer)

        
    }
    
  /* Start and Stop Animation services exposed to API Users */
    
  //MARK: Public Services
    
    public func startAnimation(completion:()->Void){
        
        if let _ = self.layer.sublayers{
            
            for each in self.layer.sublayers!{
                
                each.removeFromSuperlayer()
            }
            addGradientLayerToViewLayer()
        }else{
            
            addGradientLayerToViewLayer()
        }
        
           self.animateCircle()
           completion()
        
    }
    
    
    public func stopAnimation(completion:()->Void){
        
        if let _ = delegate{
            delegate!.willStopAnimation()
        }
       circularLayer.removeAllAnimations()
       circularLayer.fillColor = nil
        if let _ = delegate{
            delegate!.didStopAnimation()
        }
        
        completion()
    }
    
}
