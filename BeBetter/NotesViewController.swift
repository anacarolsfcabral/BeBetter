//
//  NotesViewController.swift
//  BeBetter
//
//  Created by Ana Carolina Cabral on 29/07/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var notesTable: UITableView!
    //var currentActivity: Activity = DAO.sharedInstance.getCurrentAcivity()
    var arrayActivity = [Activity]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayActivity = DAO.sharedInstance.getActivitiesThatHaveNote()

        
        notesTable.registerNib(UINib(nibName: "NotesCell", bundle: nil), forCellReuseIdentifier: "NotesCell")
        notesTable.delegate = self
        notesTable.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToPerformance(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayActivity.count
    }
    ////// fazer uma função para pegar as activitys que tem notas..../////
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = notesTable.dequeueReusableCellWithIdentifier("NotesCell", forIndexPath: indexPath) as! NotesCell
        
        cell.exerciseNameLabel.text = arrayActivity[indexPath.row].name
        cell.noteLabel.text = arrayActivity[indexPath.row].note as String
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete {
            //performanceTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        else if editingStyle == UITableViewCellEditingStyle.Insert{
            
        }
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        let delete = UITableViewRowAction(style: .Default, title: "Delete") { action, index in
            println("delete")
        }
        
        return [delete]
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
