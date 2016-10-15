//
//  ViewController.swift
//  miracle-pills
//
//  Created by Mac on 10/14/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate {
    
    
    @IBOutlet var upperView: UIView!
    
    
    @IBOutlet var profileImageUpload: UIImageView!
    @IBOutlet var profileImage: UIImageView!
    
    
    @IBOutlet var statePickerValue: UITextField!
    
    
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var pickerCountryValue: UITextField!
    @IBOutlet var pickerCountryButton: UIButton!
    
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var submitButton: UIButton!
    
    var typePickerView: UIPickerView = UIPickerView()
    
    var hiddingOperation = false
    var statePickerAction = false
    
    
    // picker view array values
    
    let pickerRowTitles = ["first ","second ","third ", "fourth "];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.typePickerView.dataSource = self;
        self.typePickerView.delegate = self;
        
        // define picker view
        
        
        self.typePickerView.alpha = 0
        self.typePickerView.backgroundColor = UIColor.whiteColor()
        self.typePickerView.frame = CGRectMake(self.statePickerValue.frame.origin.x, self.statePickerValue.frame.origin.y + self.statePickerValue.frame.size.height + 8, self.view.frame.size.width - 80, 200)
        
        self.upperView.addSubview(typePickerView)
        
        
        // circle profile image
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        self.profileImage.clipsToBounds = true;
        
        
        // corner submit button
        
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.blackColor().CGColor
        
        // tap recognizer for imageediting
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(ViewController.imageTapped(_:)))
        profileImageUpload.userInteractionEnabled = true
        profileImageUpload.addGestureRecognizer(tapGestureRecognizer)
        
        
        // tap recognizer for upper view
        
        let ViewtapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(endEiting))
        upperView.userInteractionEnabled = true
        upperView.addGestureRecognizer(ViewtapGestureRecognizer)
        
        
        
        
        
    }
    
    
    // MARK:  override picker methods
    
    
    
    // picker # of columns
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        
        return 1;
    }
    
    
    // picker # of rows
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return pickerRowTitles.count;
    }
    
    // title for each row
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerRowTitles[row]
        
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        
        
        if (pickerView.frame.origin.y < self.pickerCountryValue.frame.origin.y){
            
            statePickerAction = true
            
            self.statePickerValue.text = pickerRowTitles[row]
            
        }else{
            
            statePickerAction = false
            
            self.pickerCountryValue.text = pickerRowTitles[row]
            
        }
        
        
        self.showAndHidePicker()
        
        
        
        
    }
    
    // MARK:  image edit func
    
    
    
    func imageTapped(img: AnyObject)
    {
        
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        
        let deleteAction = UIAlertAction(title: "Upload", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("upload")
        })
        let saveAction = UIAlertAction(title: "Take Photo", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("take photo")
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
        
    }
    
    
    
    // MARK:  upper view  gesture func
    
    
    
    
    func endEiting() {
        
        
        self.upperView.endEditing(true)
    }
    
    
    
    
    // MARK:  show state picker
    
    
    
    @IBAction func showPicker(sender: AnyObject) {
        
        self.typePickerView.frame = CGRectMake(self.statePickerValue.frame.origin.x, self.statePickerValue.frame.origin.y + self.statePickerValue.frame.size.height + 8, self.view.frame.size.width - 80, 200)
        
        statePickerAction = true
        self.showAndHidePicker()
        
    }
    
    
    
    // MARK:  country picker func
    
    
    
    @IBAction func countryPickAction(sender: AnyObject) {
        
        statePickerAction = false
        self.typePickerView.frame = CGRectMake(self.pickerCountryValue.frame.origin.x, self.pickerCountryValue.frame.origin.y + self.pickerCountryValue.frame.size.height + 8, self.view.frame.size.width - 80, 200)
        
        self.showAndHidePicker()
        
    }
    
    
    // MARK:  override text keyboard func
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        
        textField.resignFirstResponder()
        
        return false
        
    }
    
    
    // MARK:  submit func
    
    
    @IBAction func submitChanges(sender: AnyObject) {
        
        
        let alert = UIAlertController(title: "Success", message: "changed updated", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion:nil)
        
        
    }
    
    // MARK:  show and hide picker
    
    
    func showAndHidePicker(){
        
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            
            if (!self.hiddingOperation){
                
                if(self.statePickerAction){
                    
                    self.countryLabel.frame.origin.y = self.countryLabel.frame.origin.y+self.typePickerView.frame.size.height + 8
                    self.pickerCountryValue.frame.origin.y = self.pickerCountryValue.frame.origin.y+self.typePickerView.frame.size.height + 8
                    self.pickerCountryButton.frame.origin.y = self.pickerCountryButton.frame.origin.y+self.typePickerView.frame.size.height + 8
                    self.submitButton.frame.origin.y = self.submitButton.frame.origin.y+self.typePickerView.frame.size.height + 8
                    
                }else{
                    
                    self.submitButton.frame.origin.y = self.submitButton.frame.origin.y+self.typePickerView.frame.size.height + 8
                    
                }
                
                
                
            }else{
                
                self.typePickerView.alpha = 0
                
            }
            
            
            UIView.animateWithDuration(0.3, delay: 0.2, options: UIViewAnimationOptions.CurveLinear, animations: {
                
                
                if (!self.hiddingOperation){
                    
                    
                    
                    self.typePickerView.alpha = 1
                    
                }else{
                    
                    
                    if(self.statePickerAction){
                        
                        self.countryLabel.frame.origin.y = self.countryLabel.frame.origin.y - self.typePickerView.frame.size.height - 8
                        self.pickerCountryValue.frame.origin.y = self.pickerCountryValue.frame.origin.y - self.typePickerView.frame.size.height - 8
                        self.pickerCountryButton.frame.origin.y = self.pickerCountryButton.frame.origin.y - self.typePickerView.frame.size.height - 8
                        self.submitButton.frame.origin.y = self.submitButton.frame.origin.y-self.typePickerView.frame.size.height - 8
                    }else{
                        
                        self.submitButton.frame.origin.y = self.submitButton.frame.origin.y-self.typePickerView.frame.size.height - 8
                        
                    }
                    
                }
                
                
                
                }, completion: nil)
            
            
            
            self.hiddingOperation = !self.hiddingOperation
            self.statePickerAction = false
            
            
            }, completion: nil)
        
        
    }
    
}