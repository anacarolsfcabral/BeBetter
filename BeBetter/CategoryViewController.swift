//
//  CategoryViewController.swift
//  BeBetter
//
//  Created by Ana Carolina Cabral on 21/07/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var categoryCollection: UICollectionView!
    var categoryNames = ["Fonoaudiologia","Fisioterapia","Oftalmologia"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryCollection.registerClass(CategoryCell.self, forCellWithReuseIdentifier: "cell")
        
        self.categoryCollection.registerNib(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        categoryCollection.backgroundColor = UIColor.whiteColor()
        categoryCollection.delegate = self
        categoryCollection.dataSource =  self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CategoryCell
        
        cell.backgroundColor = UIColor.blackColor()
        cell.categoryName.text = categoryNames[indexPath.row]
        cell.controllerCollection = self

        return cell
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
