//
//  AdventurerRecruitmentController.swift
//  group16_assignment6
//
//  Created by Khalid Alkhatib on 3/15/19.
//  Copyright © 2019 group16. All rights reserved.
//

import UIKit

class AdventurerRecruitmentController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var imageArray = [UIImage(named: "download"), UIImage(named: "download (1)"), UIImage(named: "561bf8581200002e007e4e5b")]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdventurerRecruitmentCollectionViewCell", for: indexPath)
            as! AdventurerRecruitmentCollectionViewCell
        cell.image.image = imageArray[indexPath.row]
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
