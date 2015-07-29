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
    

    var weeks = ["1st week", "2nd week", "3rd week", "4th week", "5th week"]
    var exercises = ["1st exercise", "2nd exercise", "3rd exercise"]

    var arrayActivity = [Activity]()
    var arrayFrequency = [FrequencyActivity]()
    var arrayPerformance = [PerformanceForWeek]()
    
    @IBAction func backButton(sender: UIButton) {
       //self.dismissViewControllerAnimated(true, completion: nil)
        let nextWindow = CategoryViewController(nibName:"CategoryView", bundle: nil)
        self.presentViewController(nextWindow, animated: true, completion: nil)

        
    }
    @IBAction func addExercise(sender: UIButton) {
        
        let nextWindow = RegisterVideoViewController(nibName:"RegisterVideoView", bundle: nil)
        self.presentViewController(nextWindow, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayActivity = DAO.sharedInstance.getActivitiesForCategory()
        arrayFrequency = DAO.sharedInstance.getFrequency(arrayActivity)
        arrayPerformance = DAO.sharedInstance.getPerformance(arrayActivity)
        
        performanceTable.delegate = self
        performanceTable.dataSource = self
        
        self.performanceTable.rowHeight = 105
        
        performanceTable.registerNib(UINib(nibName: "PerformanceCell", bundle: nil), forCellReuseIdentifier: "PerformanceCell")
        performanceTable.registerNib(UINib(nibName: "PerformanceHeaderCell", bundle: nil), forCellReuseIdentifier: "PerformanceHeaderCell")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "addActivity:", name: "insertCell", object: nil)
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayActivity.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        DAO.sharedInstance.setcurrentActivity(arrayActivity[indexPath.row])
        let nextWindow = ActivityViewController(nibName:"ActivityView", bundle: nil)
        self.presentViewController(nextWindow, animated: true, completion: nil)
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = performanceTable.dequeueReusableCellWithIdentifier("PerformanceCell", forIndexPath: indexPath) as! PerformanceCell
        
//        cell.backgroundColor = UIColor(red: 240/255, green: 231/255, blue: 227/255, alpha: 1)
        cell.backgroundColor = UIColor.whiteColor()
        cell.exerciseLabel.text = arrayActivity[indexPath.row].name
        
        var arrayDaysExercises = ""
        
        var dict = arrayFrequency[indexPath.row].daysWithAmountForDay as NSMutableDictionary
        println("PEIDEEEEEEIIIIIII")
        println(dict)
        //var dia = dict.objectForKey("1") as! Int
        
        if dict.objectForKey("1") as! Int > 0 {
            arrayDaysExercises  = " Sun"
        }
        if dict.objectForKey("2") as! Int > 0 {
            arrayDaysExercises = arrayDaysExercises + " Mon"
        }
        if dict.objectForKey("3") as! Int > 0 {
            arrayDaysExercises = arrayDaysExercises + " Tue"
        }
        if dict.objectForKey("4") as! Int > 0 {
            arrayDaysExercises = arrayDaysExercises + " Wed"
        }
        if dict.objectForKey("5") as! Int > 0 {
            arrayDaysExercises = arrayDaysExercises + " Thu"
        }
        if dict.objectForKey("6") as! Int > 0 {
            arrayDaysExercises = arrayDaysExercises + " Fri"
        }
        if dict.objectForKey("7") as! Int > 0 {
            arrayDaysExercises = arrayDaysExercises + " Sat"
        }
        
        println(arrayDaysExercises)
        
        cell.exerciseDaysLabel.text = arrayDaysExercises
        
        
        if arrayPerformance[indexPath.row].completed == 0
        {
            cell.evolutionImage.image = UIImage(named: "ad0")
        }
        else if arrayPerformance[indexPath.row].completed == arrayFrequency[indexPath.row].selectedDaysCount
        {
            cell.evolutionImage.image = UIImage(named: "ad1")
        }
        else if ((arrayFrequency[indexPath.row].selectedDaysCount - arrayPerformance[indexPath.row].completed) == arrayFrequency[indexPath.row].selectedDaysCount / 2)
        {
            cell.evolutionImage.image = UIImage(named: "a2d1")
        }
        else
        {
            cell.evolutionImage.image = UIImage(named: "a\(arrayFrequency[indexPath.row].selectedDaysCount)d\(arrayPerformance[indexPath.row].completed)")
        }
        
        
        //self.performanceTable.registerClass(PerformanceCell.self, forCellWithReuseIdentifier: "PerformanceCell")
        // 3
        // Configure the cell...
//        switch (indexPath.section) {
//        case 0:
//            cell.backgroundColor=UIColor.whiteColor()
//        case 1:
//            cell.backgroundColor=UIColor.whiteColor()
//        case 2:
//            cell.backgroundColor=UIColor.whiteColor()
//            //return sectionHeaderView
//        case 3:
//            cell.backgroundColor=UIColor.whiteColor()
//        case 4:
//            cell.backgroundColor=UIColor.whiteColor()
//        default:
//            cell.backgroundColor=UIColor.whiteColor()
//        }
        
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  headerCell = performanceTable.dequeueReusableCellWithIdentifier("PerformanceHeaderCell") as! PerformanceHeaderCell
        headerCell.backgroundColor = UIColor(red: 244/255, green: 235/255, blue: 231/255, alpha: 1)
    
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
    
    func addActivity(notification : NSNotification){
        //vai fazer algo com o DAO
        
        self.exercises += ["4th exercise"]
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.performanceTable.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        
        performanceTable.reloadData()
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            //performanceTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
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
