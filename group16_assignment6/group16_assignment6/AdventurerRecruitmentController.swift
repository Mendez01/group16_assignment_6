//
//  AdventurerRecruitmentController.swift
//  group16_assignment6
//
//  Created by Khalid Alkhatib on 3/15/19.
//  Copyright © 2019 group16. All rights reserved.
//

import UIKit;

import CoreData;

class AdventurerRecruitmentController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var NameTextField: UITextField!
    
    @IBOutlet weak var ClassTextField: UITextField!
    
    // keep track of image selected
    @IBOutlet weak var img: UIImage!;
    
    var adventurers = [NSManagedObject]();
    
    var imageArray = [UIImage(named: "download"), UIImage(named: "download (1)"), UIImage(named: "561bf8581200002e007e4e5b")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // we can now reference the NameTextField Delegate
        // to dismiss the keyboard on done for both
        NameTextField.delegate = self;
        
        ClassTextField.delegate = self;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdventurerRecruitmentCollectionViewCell", for: indexPath)
            as! AdventurerRecruitmentCollectionViewCell
        cell.image.image = imageArray[indexPath.row]
        return cell
    }
    
    // the save button sends in whatever the user typed in for
    // name and class
    @IBAction func SaveButtonPressed(_ sender: AdventurerSaveButton) {
        
        if !self.NameTextField.text!.isEmpty && !self.ClassTextField.text!.isEmpty {
            
            print("Save Button Pressed");
            
            let name:String = NameTextField.text!;
            
            print("New name is \(name)");
            
            let adv_class:String = ClassTextField.text!;
            
            print("New class is \(adv_class)");
            
            addAdventurer(name: name, adv_class: adv_class);
        }
        
        
    }
    
    // this adds a adventurer
    func addAdventurer(name: String, adv_class: String) {
        
        // app delegate communicates
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        
        // the content managed
        let managedContext = appDelegate.managedObjectContext;
        
        // need correct entity name
        let entity = NSEntityDescription.entity(forEntityName: "Adventurer", in: managedContext)
        
        // make an adventurer an NSManaged Object
        let adventurer = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        // add stuff to the adventurer 
        
        let level:Int = 1;
        
        let attack = Float.random(in: 2 ..< 4)
        
        let totalHP = Int.random(in: 100 ..< 201);
        
        var currentHP = totalHP - 0;
        
        //let imageName:String ;
        
        
        print("\(name) \(adv_class)");
        
        //let adv_class:String = "Class";
        
        // must match correct keys
        adventurer.setValue(name, forKey: "name");
        adventurer.setValue(level, forKey: "level");
        adventurer.setValue(attack, forKey: "attack");
        adventurer.setValue(currentHP, forKey: "currentHP");
        adventurer.setValue(totalHP, forKey: "totalHP");
        adventurer.setValue(adv_class, forKey: "adv_class");
        //adventurer.setValue(imageName, forKey: "imageName");
        
        // try to save back to managed context
        do {
            try managedContext.save()
        } catch {
            let nserror = error as NSError
            NSLog("Unable to save \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        // if succeds add to entity
        adventurers.append(adventurer)
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Hide the keyboard.
        // text field should resign its first-responder
        // status because the text field is no longer an active
        // object in the app
        textField.resignFirstResponder();
        
        return true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    
}
