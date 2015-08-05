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
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var patientImg: UIImageView!
    @IBOutlet weak var doctorImg: UIImageView!
    @IBOutlet weak var patientLabel: UILabel!
    @IBOutlet weak var doctorLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if index == 0
        {
            goToBut.hidden = true
            patientImg.hidden = true
            doctorImg.hidden = true
            patientLabel.hidden = true
            doctorLabel.hidden = true
            textView.hidden = true
            
            firstLabel.alpha = 0
            secondLabel.alpha = 0
        }
        else if index == 1
        {
            imageApp.hidden=true
            firstLabel.hidden = true
            secondLabel.hidden = true
            
            goToBut.userInteractionEnabled = false
            goToBut.alpha = 0
            textView.alpha = 0
            
            patientLabel.alpha = 0
            doctorLabel.alpha = 0
            
            self.patientImg.alpha = 0.5
            self.doctorImg.alpha = 0.5
            
            self.view.addSubview(patientImg)
            self.view.addSubview(doctorImg)
            
        }
        
        

        // Do any additional setup after loading the view.
    }

    var index: Int!

    @IBAction func goToButton(sender: UIButton) {
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
        
        UIView.animateWithDuration(1.0, delay: 0.7, options: .CurveEaseIn, animations: {
            self.firstLabel.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(2.0, delay: 1.7, options: .CurveEaseIn, animations: {
            self.secondLabel.alpha = 1.0
            }, completion: nil)
        
        
        UIView.animateWithDuration(1.4, delay: 0.3, options: .CurveEaseIn, animations: { () -> Void in
            
            self.patientImg.alpha = 1.0
            
            let toImage = UIImage(named:"patient.png")
            
            UIView.transitionWithView(self.patientImg,
                
                duration:2,
                options: UIViewAnimationOptions.TransitionFlipFromLeft,
                animations: { self.patientImg.image = toImage },
                completion: nil)
            
            UIView.animateWithDuration(1.0, delay: 0.5, options: .CurveEaseIn, animations: {
                
                self.patientLabel.alpha = 1.0
                
                UIView.animateWithDuration(1.4, delay: 0.3, options: .CurveEaseIn, animations: { () -> Void in
                    
                    self.doctorImg.alpha = 1.0
                    
                    let toImage = UIImage(named:"doctor.png")
                    
                    UIView.transitionWithView(self.doctorImg,
                        
                        duration:2,
                        options: UIViewAnimationOptions.TransitionFlipFromRight,
                        animations: { self.doctorImg.image = toImage },
                        completion: nil)
                    
                    UIView.animateWithDuration(1.0, delay: 0.5, options: .CurveEaseIn, animations: {
                        
                        self.doctorLabel.alpha = 1.0
                        
                        UIView.animateWithDuration(4.0, delay: 2.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                            
                            self.textView.alpha = 1.0
                            
                            UIView.animateWithDuration(4.5, delay: 5.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                                
                                    if self.index == 1
                                    {
                                        self.goToBut.hidden = false
                                        self.goToBut.alpha = 1
                                        self.goToBut.userInteractionEnabled = true
                                    }
                                }, completion: nil)
                            
                        }, completion: nil)
                        
                    }, completion: nil)
                
                }, completion: nil)
            
            }, completion: nil)
        
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
