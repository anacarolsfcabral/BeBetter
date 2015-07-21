//
//  PerformanceViewController.swift
//  BeBetter
//
//  Created by Ana Carolina Cabral on 21/07/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class PerformanceViewController: UIViewController, UITableViewDelegate
{
    @IBOutlet weak var performanceTable: UITableView!

    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
