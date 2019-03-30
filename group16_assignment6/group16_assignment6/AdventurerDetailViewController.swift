//
//  AdventurerDetailViewController.swift
//  group16_assignment6
//
//  Created by Thomas Mendez on 3/29/19.
//  Copyright © 2019 group16. All rights reserved.
//

import UIKit

import CoreData;

class AdventurerDetailViewController: UIViewController {
    
    var adventurers = [NSManagedObject]();

    @IBOutlet weak var getName: UILabel!
    @IBOutlet weak var getLV: UILabel!
    @IBOutlet weak var getClass: UILabel!
    @IBOutlet weak var getAttack: UILabel!
    @IBOutlet weak var getHP: UILabel!
    @IBOutlet weak var getImage: UIImageView!
    @IBOutlet weak var LogDetails: UITextView!
    
    
    var _advIndex:Int = 0;
    
    // when we instantiate we need to have
    // it initialized and this will hold the
    // text that would need to be passed to the UILabel
    
    var _name: String!
    var _lv: String!
    var _class: String!
    var _attack: String!
    var _hp: String!
    var _currHP: String!
    var _imgName: String!
    var _logDetails: String = "Beggining Quest...";
    
    var _advHP: Int = 0;
    
    var _advLV: Int = 0;
    
    var _killCount: Int = 0;
    
    var _enemyCanAttack: Bool = false;
    
    private let timeInterval:Float = 0.0;
    
    var timer1:Timer!;
    
    var timer2:Timer!;
    
    // var enemy:Enemy;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // when we are at the view did load,
        // we have initialized therefore
        // we can now assign text values
        print("The name on view did load - \(String(describing: _name))");
        getName.text = _name;
        getLV.text = _lv;
        getClass.text = _class;
        getAttack.text = _attack;
        getHP.text = "\(_currHP!)/\(_hp!)";
        
        // this is used to keep track in quest
        _advHP = Int(_hp!)!;
        _advLV = Int(_lv!)!;
        _killCount = 0;
        
        _enemyCanAttack = false;
        
        LogDetails.text = _logDetails;
        
        //
        // getImage.image = UIImage(named: _imgName);
        
        // start the timer
        // goes every time based on time interval
        
        // make an enemy to start
        var enemy = Enemy();
        
        // print("Enemy health - \(enemy.health)");
        
        let enemyTimerInterval = Double.random(in: 1..<3)
        
        // timer for when things happen in the quest log
        // things happen every 1.5 seconds
        timer1 = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
            
            // have an event show up in the quest
            // print("Timer fired!")
            
            // have the player attack
            // it is attack multiplier times a rand number
            
            let newAttackVal:Int = Int(Float(self._attack)! * Float.random(in: 10..<25));
            
            print(newAttackVal);
            
            //self.LogDetails.text = self.LogDetails.text + "\n";
            
            self.LogDetails.text = self.LogDetails.text + "\n \(self._name!) attacks for \(newAttackVal) damage";
            
            enemy.health = enemy.health - newAttackVal;
            
            if (enemy.health <= 0){
                
                self._killCount = self._killCount + 1;
                
                // kill the enemy
                self.LogDetails.text = self.LogDetails.text + "\n Enemy is Defeated!";
                
                // level up at every 3 kills
                if ((self._killCount % 3 == 0) && (self._killCount != 0)){
                    
                    self._advLV = self._advLV + 1;
                    
                    self.getLV.text = "\(self._advLV)";
                    
                    self.LogDetails.text = self.LogDetails.text + "\n \(self._name!) leveled up!";
                    
                    // now save to core data
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate;
                    let managedContext = appDelegate.managedObjectContext;
                    
                    let adventurer = self.adventurers[self._advIndex];
                    
                    adventurer.setValue(self._advLV, forKey: "level");
                    
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
                
                // spawn a new one
                enemy = Enemy();
                
                print("New enemy health \(enemy.health)");
                
                self.LogDetails.text = self.LogDetails.text + "\n New enemy appears!";
                
            }
            
            else{
                
                // enemy attacks
                if (self._enemyCanAttack){
                    
                    self._enemyCanAttack = false;
                    
                    let enemyAtt:Int = Int.random(in: 1..<15);
                    
                    self.LogDetails.text = self.LogDetails.text + "\n Enemy attacks for \(enemyAtt) damage";
                    
                    self._advHP = self._advHP - enemyAtt;
                    
                    // if the player has 0 health stop the timer
                    if (self._advHP <= 0){
                        
                        self._advHP = 0;
                        
                        self.LogDetails.text = self.LogDetails.text + "\n \(self._name!) got knocked out!";
                        
                        self.LogDetails.text = self.LogDetails.text + "\n The adventure is over..";
                        
                        timer.invalidate();
                    }
                    
                    self.getHP.text = "\(self._advHP)/\(self._hp!)";
                }
                
                // the enemy is waiting
                else{
                    self.LogDetails.text = self.LogDetails.text + "\n The Enemy is watching you..";
                }
            }
        }
        
        // timer for enemy which is random from 1 to every 3 seconds
        // player always attack first
        timer2 = Timer.scheduledTimer(withTimeInterval: enemyTimerInterval, repeats: true) { timer in
            
            if (self._advHP <= 0){
                
                timer.invalidate()
            }
            
            self._enemyCanAttack = true;
            
        }
        
        
    }
    
    @IBAction func EndQuest(_ sender: Any) {
        
        // end the quest and stop the timers
        
        timer1.invalidate();
        
        timer2.invalidate();
        
        self.LogDetails.text = self.LogDetails.text + "\n Ended the quest.";

        
    }
    /*
 
     timer = NSTimer.scheduledTimer(timeInterval: [time interval], target: self, selector: #selector([function to call]), userInfo: nil, repeats: true
     
     var runCount = 0)
     
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
