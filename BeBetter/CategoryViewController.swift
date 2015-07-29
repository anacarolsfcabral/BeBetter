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
        
        ///////Notificação/////////
        DAO.sharedInstance.notification()
        
        NSNotificationCenter.defaultCenter().addObserver(self , selector: "delayNotification:", name: "actionOnePressed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self , selector: "showAMessage:", name: "actionTwoPressed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self , selector: "delayNotificationForOneHour:", name: "actionThirdPressed", object: nil)
        ///////////////////////////
        
        ///////Gesto para voltar para a StartViewController/////////
        var gesture = UIScreenEdgePanGestureRecognizer(target: self, action: "goToStartView:")
        gesture.edges = UIRectEdge.Left
        self.view.addGestureRecognizer(gesture)
        ///////////////////////////
    }

    ///////Notificação - Funções para as opções da Notificação/////////
    func delayNotification(notification: NSNotification){
        DAO.sharedInstance.delayNotification(0, minute: 2)
    }
    func showAMessage(notification: NSNotification){
        var message : UIAlertController = UIAlertController(title: "Vamos lá!", message: "A prática leva a perfeição", preferredStyle: UIAlertControllerStyle.Alert)
        message.addAction(UIAlertAction(title: "Vamos Praticar", style: UIAlertActionStyle.Default, handler: nil))

        self.presentViewController(message, animated: true, completion: nil)
    }
    func delayNotificationForOneHour(notification: NSNotification){
        DAO.sharedInstance.delayNotification(1, minute: 0)
    }
   
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ////////Função dos Botões das Categorias///////////
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
    
    ///////Função do Gesture/////////
    func goToStartView(gesture: UIScreenEdgePanGestureRecognizer){
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
