//
//  MealViewController.swift
//  Food Tracker
//
//  Created by Elaine Breen on 13/06/2017.
//  Copyright © 2017 ElaineCo. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    //@IBOutlet weak var defaultTextLabelButton: UIButton!
    //@IBOutlet weak var textColor: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var meal: Meal?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field's user input through delegate callbacks.
        // Self refers to ViewController class because we are within the scope
        // of the ViewController class definitio
        nameTextField.delegate = self
        
        //Set up views if editing an existing Meal
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            ratingControl.rating = meal.rating
            photoImageView.image = meal.photo
        }
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }

    //override func didReceiveMemoryWarning() {
    //    super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    //}
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //Hides the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable the save button when editing
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    //MARK: UIImagePickerControlDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        //Dismiss the picker if the user cancelled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //The info dictionary may contain multiple representations of the image. You 
        //want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as?
            UIImage else {
                fatalError("Expected a dictionary containing an image but was provided the following: \(info)")
        }
        
        //Set photoImageView to display the selected image
        photoImageView.image = selectedImage
        
        //Dismiss the picker
        dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
        
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    //This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //Configure the destination view controller only when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling..", log: OSLog.default, type:.debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        //Set the meal to be passed to MealTableViewController after the unwind segue.
        meal = Meal(name: name, rating: rating, photo: photo)
    }

    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        //Hide the keyboard
        nameTextField.resignFirstResponder()
        
        //UIImagePickerController is a view controller that lets you pick media
        //from the photo library.
        let imagePickerController = UIImagePickerController()
        
        //Only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        
        //Make sure ViewController is notified when user picks an image
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        //Disable the save button if the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
//    @IBAction func setDefaultLabelText(_ sender: UIButton) {
//        
//        mealNameLabel.text = "Default Text"
//        
//        // returns a random number between 1 and 6
//        let diceRoll = Int(arc4random_uniform(6) + 1)
//        
//        // depending on the rand number returned set the text label and button color
//        switch diceRoll
//        {
//        case 1:
//            mealNameLabel.textColor = UIColor.red
//            //this line changes the background color of the text label
//            mealNameLabel.backgroundColor = UIColor.white
//            defaultTextLabelButton.tintColor = UIColor.red
//            
//            // not sure what this does...
//        //defaultTextLabelButton.setTitleShadowColor(UIColor.gray, for: UIControlState.normal)
//        case 2:
//            mealNameLabel.textColor = UIColor.blue
//            mealNameLabel.backgroundColor = UIColor.white
//            defaultTextLabelButton.tintColor = UIColor.blue
//        case 3:
//            mealNameLabel.textColor = UIColor.green
//            mealNameLabel.backgroundColor = UIColor.white
//            defaultTextLabelButton.tintColor = UIColor.green
//        case 4:
//            mealNameLabel.textColor = UIColor.yellow
//            mealNameLabel.backgroundColor = UIColor.gray
//            defaultTextLabelButton.tintColor = UIColor.yellow
//        case 5:
//            mealNameLabel.textColor = UIColor.orange
//            mealNameLabel.backgroundColor = UIColor.white
//            defaultTextLabelButton.tintColor = UIColor.orange
//        case 6:
//            mealNameLabel.textColor = UIColor.purple
//            mealNameLabel.backgroundColor = UIColor.white
//            defaultTextLabelButton.tintColor = UIColor.purple
//        default:
//            mealNameLabel.textColor = UIColor.black
//            //mealNameLabel.backgroundColor = UIColor.white
//        }
//
//    }
    
}

