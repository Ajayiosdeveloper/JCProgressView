//
//  AdvancedOptionsViewController.swift
//  JCProgressView
//
//  Created by ajaybabu singineedi on 07/06/16.
//  Copyright © 2016 Exilant Technologies. All rights reserved.
//

import UIKit

class AdvancedOptionsViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet var choiceTextField: UITextField!
    
    var progressView:JCProgressView!
    
    let choicePickerView = UIPickerView()
    
    let choicesArray = ["Single Color", "Multi Color", "Default Single Color", "Default Multi Color"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Isn't Cool?👍"
        
       choiceTextField.inputView = choicePickerView
       choicePickerView.dataSource = self
        choicePickerView.delegate = self
        addDoneButtonToPicker()

    // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
         choiceTextField.becomeFirstResponder()
    }
    
    
    func addDoneButtonToPicker()
    {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target:self, action: #selector(AdvancedOptionsViewController.performChoice))
        toolBar.items = [doneButton]
        choiceTextField.inputAccessoryView = toolBar
    }
    
    func performChoice(){
        
        choiceTextField.resignFirstResponder()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return choicesArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return choicesArray[row]
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.choiceTextField.text = choicesArray[row]
        
        if let _ = progressView{
            
            progressView!.stopAnimation()
        }
        
        switch row {
        case 0:
            showProgressViewWithSingleColor()
        case 1:
            showProgressViewWithMultiColors()
        case 2:
             showProgressViewWithSingleDefaultColr()
        case 3:
             showProgressViewWithMultiDefaultColors()
        default:
            
            print("Never")
        }
        
    }
    
    func showProgressViewWithSingleColor(){
        
        progressView = JCProgressView(frame: CGRectMake(self.view.frame.width/2, 200, 100, 100))
        
        progressView.allowsMultipleColors = false
        
        progressView.progressColor = UIColor.orangeColor()
        
        self.view.addSubview(progressView)
        
        progressView.startAnimation()
        
        choiceTextField.resignFirstResponder()
    }
    
    func  showProgressViewWithSingleDefaultColr() {
        
        progressView = JCProgressView(frame: CGRectMake(self.view.frame.width/2, 200, 100, 100))
        
        progressView.allowsMultipleColors = false
        
        progressView.progressColor = nil
        
        self.view.addSubview(progressView)
        
        progressView.startAnimation()
        
        choiceTextField.resignFirstResponder()
        
    }
    
    func showProgressViewWithMultiColors(){
        
        progressView = JCProgressView(frame: CGRectMake(self.view.frame.width/2,200, 100, 100))
        
        progressView.progressColors = [UIColor.greenColor(),UIColor.blueColor(),UIColor.whiteColor()]
        
        progressView.progressColorLocations = [0.1, 0.5, 07]
        
        self.view.addSubview(progressView)
        
        progressView.startAnimation()
        
        choiceTextField.resignFirstResponder()
        
    }
    
   func  showProgressViewWithMultiDefaultColors() {
        
    
     progressView = JCProgressView(frame: CGRectMake(self.view.frame.width/2, 200, 100, 100))
   
    /* If progressColors is nil or its count is less than or equal to one then it will take default multi colors */
    
     progressView.progressColors = nil
    
     progressView.progressColorLocations = nil
    
     self.view.addSubview(progressView)
    
      progressView.startAnimation()
    
      choiceTextField.resignFirstResponder()
    
    }
    

}
