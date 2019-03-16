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
    
    // var adventurers: [NSManagedObject] = [];
    
    var imageArray = [UIImage(named: "download"), UIImage(named: "download (1)"), UIImage(named: "561bf8581200002e007e4e5b")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(imageArray.count)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        return imageArray.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdventureCell", for: indexPath);
        */
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdventureCell", for: indexPath) as! AdventureTableViewCell;

        // Configure the cell...
        
        cell.AdventurerImage.image = imageArray[indexPath.row];
        
        
        
        switch(indexPath.row){
            
        case 0:
            
            cell.labelName.text = "Han Solo";
            
            cell.labelLevel.text = "9";
            
            cell.labelClass.text = "Human";
            
            cell.labelAttackModifier.text = "20";
            
            cell.labelHP.text = "30/100";
            
            break;
            
        case 1:
            
            cell.labelName.text = "Chewbacka";
            
            cell.labelLevel.text = "100";
            
            cell.labelClass.text = "Wookiee";
            
            cell.labelAttackModifier.text = "900";
            
            cell.labelHP.text = "670/1000";
            
            break;
            
        case 2:
            
            cell.labelName.text = "Master Yoda";
            
            cell.labelLevel.text = "1000";
            
            cell.labelClass.text = "Yedi Master";
            
            cell.labelAttackModifier.text = "9000";
            
            cell.labelHP.text = "100000/100000";
            
            break;
            
        default:
            
            break;
        }
 
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
