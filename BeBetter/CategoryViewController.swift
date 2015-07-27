//
//  CategoryViewController.swift
//  BeBetter
//
//  Created by Ana Carolina Cabral on 21/07/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet var edgeGesture: UIScreenEdgePanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DAO.sharedInstance.saveActivity()
        
        var gesture = UIScreenEdgePanGestureRecognizer(target: self, action: "goToStartView:")
        gesture.edges = UIRectEdge.Left
        self.view.addGestureRecognizer(gesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setSpeechtherapy(sender: AnyObject) {
        
        DAO.sharedInstance.setChoosenCategory("speechtherapy")
        goToPerformance()
    }
    
    @IBAction func setPhysiotherapy(sender: AnyObject) {
        
        DAO.sharedInstance.setChoosenCategory("physiotherapy")
        goToPerformance()
    }
    
    @IBAction func setOphthalmology(sender: AnyObject) {
        
        DAO.sharedInstance.setChoosenCategory("ophthalmology")
        goToPerformance()
    }
    
    
    func goToPerformance(){
        
        let nextWindow = PerformanceViewController(nibName:"PerformanceView", bundle: nil)
        self.presentViewController(nextWindow, animated: true, completion: nil)
    }

    func goToStartView(gesture: UIScreenEdgePanGestureRecognizer)
    {
        let nextWindow = StartViewController(nibName:"StartView", bundle: nil)
        self.presentViewController(nextWindow, animated: true, completion: nil)
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
