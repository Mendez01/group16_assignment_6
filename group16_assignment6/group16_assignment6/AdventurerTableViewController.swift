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
    
    var adventurers = [NSManagedObject]()
    
    // var imageArray = [UIImage(named: "download"), UIImage(named: "download (1)"), UIImage(named: "561bf8581200002e007e4e5b")]
    
    
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

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return adventurers.count;
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
}
