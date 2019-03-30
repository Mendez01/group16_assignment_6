//
//  TableViewController.swift
//  group16_assignment6
//
//  Created by Thomas Mendez on 3/14/19.
//  Copyright © 2019 group16. All rights reserved.
//

import UIKit;

import CoreData;

class AdventurerTableViewController: UITableViewController {
    
    var adventurers = [NSManagedObject]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil);
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        // this is to delete every row in core data
        // only keep this if nessary
        
        /*
         let appDelegate = UIApplication.shared.delegate as! AppDelegate;
         let managedContext = appDelegate.managedObjectContext;
         // need to have name
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Adventurer")
         // store fetch result into list
         var fetchedResults:[NSManagedObject]? = nil
         
         // try catch
         // say want tto do somethings try
         // to fetch results
         
         // grab fetch request (above)
         // grab entity name
         
         // get managed object
         do {
         try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
         } catch {
         // save as an error if failed
         let nserror = error as NSError
         NSLog("Unable to fetch \(nserror), \(nserror.userInfo)")
         // won't crash program
         abort()
         }
         
         if let results = fetchedResults {
         adventurers = results
         }
         
         for adventurer in adventurers{
         managedContext.delete(adventurer)
         }
         */
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.adventurers.count
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            // delete item at indexPath
            print("Did hit delete button");
            
            // let adv = self.adventurers[indexPath.row];
            
            // print("NSObject \(adv)");
            
            // remove it from the list we are having before deleting
            // to prevent a an exception saying that there is an incorrect number of rows
            // in the section
            
            self.adventurers.remove(at: indexPath.row);
            
            // remove it from core data
            let appDelegate = UIApplication.shared.delegate as! AppDelegate;
            let managedContext = appDelegate.managedObjectContext;
            
            // need to get the adventurers from the core data again
            // cause I just deleted from reference on the view controller
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Adventurer")
            // store fetch result into list
            var fetchedResults:[NSManagedObject]? = nil
            
            // try catch
            // say want to do somethings try
            // to fetch results
            
            // grab fetch request (above)
            // grab entity name
            
            // get managed object
            do {
                // store to variable if ok
                try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
            } catch {
                // save as an error if failed
                let nserror = error as NSError
                NSLog("Unable to fetch \(nserror), \(nserror.userInfo)")
                // won't crash program
                abort()
            }
            
            // if passed try
            // store back
            // if I can create a var out of this,
            // then I know that it has
            // prevents the storage of nil values
            
            if let results = fetchedResults {
                
                managedContext.delete(results[indexPath.row]);
                
                if managedContext.hasChanges {
                    do {
                        try managedContext.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nserror = error as NSError
                        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                    }
                }
            }
            
            // acutally delete it an play the animation
            tableView.deleteRows(at: [indexPath], with: .fade);
        }
        
        // needs to return an array of TableViewActions
        return [delete];
        
    }
    
    func loadList(){
        //load data here
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let managedContext = appDelegate.managedObjectContext;
        // need to have name
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Adventurer")
        // store fetch result into list
        var fetchedResults:[NSManagedObject]? = nil
        
        // try catch
        // say want tto do somethings try
        // to fetch results
        
        // grab fetch request (above)
        // grab entity name
        
        // get managed object
        do {
            // store to variable if ok
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            // save as an error if failed
            let nserror = error as NSError
            NSLog("Unable to fetch \(nserror), \(nserror.userInfo)")
            // won't crash program
            abort()
        }
        
        // if passed try
        // store back
        // if I can create a var out of this,
        // then I know that it has
        // prevents the storage of nil values
        
        if let results = fetchedResults {
            adventurers = results
            
            for adventurer in adventurers{
                let totalHP:Int = adventurer.value(forKey: "totalHP") as! Int;
                
                // let currentHP:Int = adventurer.value(forKey: "currentHP") as! Int;
                
                // print("Current HP: \(currentHP)");
                
                adventurer.setValue(totalHP, forKey: "currentHP");
            }
            
            // if they happened to go back to the home screen and updated health
            // change the data 
            if managedContext.hasChanges {
                do {
                    try managedContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
        
        self.tableView.reloadData();
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
         let cell = tableView.dequeueReusableCell(withIdentifier: "AdventureCell", for: indexPath);
         */
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdventureCell", for: indexPath) as! AdventureTableViewCell;
        
        /*
         // Configure the cell...
         
         cell.AdventurerImage.image = imageArray[indexPath.row];
         
         */
        
        
        // take managed person
        // convert data out and place
        // into table view
        
        let adventurer = adventurers[indexPath.row];
        
        cell.labelName.text = adventurer.value(forKey: "name") as? String;
        
        cell.labelClass.text = adventurer.value(forKey: "adv_class") as? String;
        
        cell.labelLevel.text = String(adventurer.value(forKey: "level") as! Int);
        
        let currentHP:Int = adventurer.value(forKey: "currentHP") as! Int;
        
        let totalHP:Int = adventurer.value(forKey: "totalHP") as! Int;
        
        let labelHPText:String = "\(currentHP)/\(totalHP)";
        
        cell.labelHP.text = labelHPText;
        
        cell.labelAttackModifier.text = String(adventurer.value(forKey: "attack") as! Double);
        
        /*
         let age:Int = person.value(forKey: "age") as! Int
         cell.cellAge.text = String(age)
         cell.cellOccupation.text = person.value(forKey: "occupation") as? String
         */
        
        return cell;
        
    }
    
    
    // this adds a adventurer
    
    func addAdventurer(name: String, adv_class: String) {
        
        // app delegate communicates
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        
        // the content managed
        let managedContext = appDelegate.managedObjectContext;
        
        // need correct entity name
        let entity = NSEntityDescription.entity(forEntityName: "Adventurer", in: managedContext)
        
        let adventurer = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        let level:Int = 0;
        
        let attack:Decimal = 0.00;
        
        let currentHP:Int = 0;
        
        let totalHP:Int = 0;
        
        //let adv_class:String = "Class";
        
        // must match correct keys
        adventurer.setValue(name, forKey: "name");
        adventurer.setValue(level, forKey: "level");
        adventurer.setValue(attack, forKey: "attack");
        adventurer.setValue(currentHP, forKey: "currentHP");
        adventurer.setValue(totalHP, forKey: "totalHP");
        adventurer.setValue(adv_class, forKey: "adv_classs");
        
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        
        let adventurerDetailViewController = storyboard.instantiateViewController(withIdentifier: "AdventurerDetailViewController") as! AdventurerDetailViewController ;

        // let cell = tableView.dequeueReusableCell(withIdentifier: "AdventureCell", for: indexPath) as! AdventureTableViewCell;
        
        let adventurer = self.adventurers[indexPath.row];
        
        // we do this instead of the label.text
        // becasue when we instantiate the label.text is set to
        // nul, we needed to instantiate those in view did load
        // and reset them there for the CollectionViewController
        
        adventurerDetailViewController._name = adventurer.value(forKey: "name") as? String;
        
        adventurerDetailViewController._lv = String(adventurer.value(forKey: "level") as! Int);
        
        adventurerDetailViewController._class = adventurer.value(forKey: "adv_class") as? String;
        
        adventurerDetailViewController._attack = String(adventurer.value(forKey: "attack") as! Double);
        
        adventurerDetailViewController._currHP = String(adventurer.value(forKey: "currentHP") as! Int);
        
        adventurerDetailViewController._hp = String(adventurer.value(forKey: "totalHP") as! Int);
        
        // adventurerDetailViewController.getImage.text = cell.AdventurerImage!;
        
        // pass over the list of adventurers
        adventurerDetailViewController.adventurers = adventurers;
        
        // index of adventurer to update data in quest
        adventurerDetailViewController._advIndex = indexPath.row;
        
        self.navigationController?.pushViewController(adventurerDetailViewController, animated: true);
        
    }
}
