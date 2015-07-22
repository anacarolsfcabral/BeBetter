//
//  PerformanceViewController.swift
//  BeBetter
//
//  Created by Ana Carolina Cabral on 21/07/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class PerformanceViewController: UIViewController, UITableViewDelegate , UITableViewDataSource
{
    @IBOutlet weak var performanceTable: UITableView!
    
    var weeks = ["Semana 1", "Semana 2", "Semana 3", "Semana 4", "Semana 5"]

    @IBAction func addExercise(sender: UIButton) {
        
        let nextWindow = RegisterVideoViewController(nibName:"RegisterVideoView", bundle: nil)
        self.presentViewController(nextWindow, animated: true, completion: nil)
    }
    
//    var semanas: Int
//    
//    var bolinhas: Int
//    
//    init(semanas: Int, bolinhas: Int)
//    {
//        
//        self.semanas = semanas
//        self.bolinhas = bolinhas
//        
//        super.init(nibName: "", bundle: nil)
//
//    }
//
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //aqui verifica quantas semanas o cara tem, sei la, nao sei direito
//        if(semanas == 1)
//        {
//            
//        }

        performanceTable.delegate = self
        performanceTable.dataSource = self
        
        
        performanceTable.registerNib(UINib(nibName: "PerformanceCell", bundle: nil), forCellReuseIdentifier: "PerformanceCell")
        
        
        performanceTable.registerNib(UINib(nibName: "PerformanceHeaderCell", bundle: nil), forCellReuseIdentifier: "PerformanceHeaderCell")
        

        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = performanceTable.dequeueReusableCellWithIdentifier("PerformanceCell", forIndexPath: indexPath) as! PerformanceCell
        
        //self.performanceTable.registerClass(PerformanceCell.self, forCellWithReuseIdentifier: "PerformanceCell")

        
        // 3
        // Configure the cell...
        switch (indexPath.section) {
        case 0:
            cell.backgroundColor=UIColor.whiteColor()
        case 1:
            cell.backgroundColor=UIColor.whiteColor()
        case 2:
            cell.backgroundColor=UIColor.whiteColor()
            //return sectionHeaderView
        case 3:
            cell.backgroundColor=UIColor.whiteColor()
        case 4:
            cell.backgroundColor=UIColor.whiteColor()
        default:
            cell.backgroundColor=UIColor.whiteColor()
        }
        
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  headerCell = performanceTable.dequeueReusableCellWithIdentifier("PerformanceHeaderCell") as! PerformanceHeaderCell
        
    
        headerCell.weekLabel.text = weeks[section]
        
//        switch (section) {
//        case 0:
//            headerCell.backgroundColor = UIColor.redColor()
//            //return sectionHeaderView
//        case 1:
//            headerCell.backgroundColor = UIColor.blackColor()
//
//            //return sectionHeaderView
//        case 2:
//            headerCell.backgroundColor = UIColor.blueColor()
//            //return sectionHeaderView
//        case 3:
//            headerCell.backgroundColor = UIColor.blueColor()
//        case 4:
//            headerCell.backgroundColor = UIColor.blueColor()
//        default:
//            //headerCell.backgroundColor = UIColor.greenColor()
//
//        }
        
        return headerCell
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
