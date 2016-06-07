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
        
        circularRing.progressColors = [UIColor.redColor(), UIColor.blueColor()]
        circularRing.progressColorLocations = [0.1,1.0]
        
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

