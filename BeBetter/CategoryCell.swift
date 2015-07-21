//
//  CategoryCell.swift
//  BeBetter
//
//  Created by Ana Carolina Cabral on 21/07/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    var controllerCollection: CategoryViewController!
    @IBOutlet weak var categoryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func enterCategory(sender: UIButton) {
        
//        let n = PerformanceViewController(semanas: 20, bolinhas: 10)
        let nextWindow = PerformanceViewController(nibName:"PerformanceView", bundle: nil)
        self.controllerCollection.presentViewController(nextWindow, animated: true, completion: nil)
        
    }

}
