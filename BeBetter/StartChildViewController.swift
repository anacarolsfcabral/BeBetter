//
//  StartChildViewController.swift
//  BeBetter
//
//  Created by Mayara Mara Leite de Souza on 25/07/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class StartChildViewController: UIViewController {

    @IBOutlet weak var imageApp: UIImageView!
    @IBOutlet weak var goToBut: UIButton!
    @IBOutlet weak var firstViewText: UITextView!
    @IBOutlet weak var pacientImg: UIImageView!
    @IBOutlet weak var doctorImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if index == 0
        {
            screenNumber.hidden=true
            goToBut.hidden=true
            pacientImg.hidden = true
            doctorImg.hidden = true
        }
        else if index == 1
        {
            imageApp.hidden=true
            firstViewText.hidden = true
            screenNumber.hidden = true
        }
      
       screenNumber.text = ("Screen #\(index)")
        
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var screenNumber: UILabel!
    var index: Int!

    @IBAction func goToButton(sender: UIButton) {
        println("clicou")
        let nextWindow = CategoryViewController(nibName:"CategoryView", bundle: nil)
        self.presentViewController(nextWindow, animated: true, completion: nil)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }

    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
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
