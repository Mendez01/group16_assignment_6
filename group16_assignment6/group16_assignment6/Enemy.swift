//
//  Enemy.swift
//  group16_assignment6
//
//  Created by Thomas Mendez on 3/29/19.
//  Copyright © 2019 group16. All rights reserved.
//

import Foundation

class Enemy {
    
    public var health:Int;
    
    init(){
        
        self.health = Int.random(in: 50..<100);
        
    }
    
}
