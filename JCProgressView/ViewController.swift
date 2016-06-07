//
//  ViewController.swift
//  JCProgressView
//
//  Created by ajaybabu singineedi on 07/06/16.
//  Copyright © 2016 Exilant Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var circularRing: JCProgressView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        //Adding Progress View from StrorBoard
        
        circularRing.progressColors = [UIColor.redColor()]
        circularRing.progressColorLocations = [0.1]
        
        
        //Programatically Creating Progress View (Multi color)
    
        
        let progressView = JCProgressView(frame:CGRectMake(0, 0, 200, 200), colors: [UIColor.redColor(),UIColor.blueColor()],locations: [0.1,0.5])
        
        self.view.addSubview(progressView)
        
        progressView.startAnimation()

        
        //Programatically Creating Progress View (Multi color)
        
        //With single color using defaulr gray color
        
        let singleColorProgressView = JCProgressView(frame: CGRectMake(200, 200, 100, 100))
        singleColorProgressView.allowsMultipleColors = false
        
        self.view.addSubview(progressView)
        
        progressView.startAnimation()
        
        /*
         
           uncomment this below line to set your own custom color to the ProgressView insetd of default gray color
        */
        
       // progressView.progressColor = UIColor.orangeColor() 
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startAnimatingCirculaRing(sender: AnyObject) {

        circularRing.startAnimation()
    }
    
    
    @IBAction func dismissAnimation(sender: AnyObject) {
        
        circularRing.stopAnimation()
    }


}

