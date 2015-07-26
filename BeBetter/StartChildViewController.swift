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
    @IBOutlet weak var pacientLabel: UILabel!
    @IBOutlet weak var doctorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if index == 0
        {
            screenNumber.hidden=true
            goToBut.hidden=true
            pacientImg.hidden = true
            doctorImg.hidden = true
            pacientLabel.hidden = true
            doctorLabel.hidden = true
            
            firstViewText.alpha = 0
        }
        else if index == 1
        {
            imageApp.hidden=true
            firstViewText.hidden = true
            screenNumber.hidden = true
            
            pacientLabel.alpha = 0
            doctorLabel.alpha = 0
            
            self.pacientImg.alpha = 0.5
            self.doctorImg.alpha = 0.5
            
            self.view.addSubview(pacientImg)
            self.view.addSubview(doctorImg)
            
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
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(1.0, delay: 0.6, options: .CurveEaseIn, animations: {
            self.firstViewText.alpha = 1.0
            }, completion: nil)
        
        
        UIView.animateWithDuration(2.0, delay: 0.3, options: .CurveEaseIn, animations: { () -> Void in
            self.pacientImg.alpha = 1.0
            
            let toImage = UIImage(named:"pacient.png")
            UIView.transitionWithView(self.pacientImg,
                duration:2,
                options: UIViewAnimationOptions.TransitionFlipFromLeft,
                animations: { self.pacientImg.image = toImage },
                completion: nil)
            
            }, completion: nil)
        
        UIView.animateWithDuration(3.5, delay: 0.7, options: .CurveEaseIn, animations: {
            self.pacientLabel.alpha = 1.0
        }, completion: nil)
        
        UIView.animateWithDuration(4.0, delay: 0.3, options: .CurveEaseIn, animations: { () -> Void in
            self.doctorImg.alpha = 1.0
            
            let toImage = UIImage(named:"doctor.png")
            UIView.transitionWithView(self.doctorImg,
                duration:2,
                options: UIViewAnimationOptions.TransitionFlipFromRight,
                animations: { self.doctorImg.image = toImage },
                completion: nil)
            
        }, completion: nil)
        
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
