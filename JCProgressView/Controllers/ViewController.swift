//
//  ViewController.swift
//  JCProgressView
//
//  Created by ajaybabu singineedi on 07/06/16.
//  Copyright © 2016 Exilant Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController,JCProgressViewDelegate {

    @IBOutlet var circularRing: JCProgressView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        //Adding Progress View from StrorBoard
        
        circularRing.progressColors = [UIColor.redColor(),UIColor.blueColor()]
        circularRing.progressColorLocations = [0.1,1.0]
        
        /* set delegate to get call backs from JCProgressView*/
        
        //circularRing.delegate = self
      }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startAnimatingCirculaRing(sender: AnyObject) {

        circularRing.startAnimation(){
            
            print("Animation Started")
        }
    }
    
    
    @IBAction func dismissAnimation(sender: AnyObject) {
        
        circularRing.stopAnimation(){
            
            print("Animation Stopped")
        }
    }
    
    //MARK: JCProgressView Delegate
    
    func willStopAnimation() {
        
        print("willStopAnimation")
    }
   
    func didStopAnimation() {
        
          print("didStopAnimation")
    }

    func willStartAnimation() {
        
          print("willStartAnimation")
    }
    
    func didStartAnimation() {
        
          print("didStartAnimation")
    }
}

