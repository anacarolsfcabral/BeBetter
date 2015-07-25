//
//  StartViewController.swift
//  BeBetter
//
//  Created by Mayara Mara Leite de Souza on 24/07/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBAction func startButton(sender: UIButton) {
        
        let nextWindow = CategoryViewController(nibName:"CategoryView", bundle: nil)
        self.presentViewController(nextWindow, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
