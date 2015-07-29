//
//  StartViewController.swift
//  BeBetter
//
//  Created by Mayara Mara Leite de Souza on 24/07/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UIPageViewControllerDataSource {

    var pageController = UIPageViewController(transitionStyle: .Scroll ,navigationOrientation: .Horizontal, options: nil)
    var pageControl = UIPageControl.appearance()
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var vc = viewController as! StartChildViewController
        
        var index = vc.index as Int

        index++
        
        if (index == 2) {
            return nil;
        }
    
        println("tela\(index)")

        return self.viewcontrollerAtIndex(index)
     
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?{
        
        var vc = viewController as! StartChildViewController
        
        var index = vc.index as Int
    
        
        if index == 0  {
            return nil
        }
        
        index--
        
        
        return self.viewcontrollerAtIndex(index)

    }
    
    func viewcontrollerAtIndex(index: Int) -> StartChildViewController{
        let child = StartChildViewController(nibName: "StartChildView", bundle: nil)
        child.index=index
        
        return child
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 2
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        /////////////////////////
        NSNotificationCenter.defaultCenter().addObserver(self , selector: "drawAShape:", name: "aactionOnePressed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self , selector: "showAMessage:", name: "actionTwoPressed", object: nil)
        
        
        var gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        var calendar: NSCalendar = NSCalendar.currentCalendar()
        var compYear = calendar.components(NSCalendarUnit.YearCalendarUnit, fromDate: NSDate())
        var compDay = calendar.components(NSCalendarUnit.DayCalendarUnit, fromDate: NSDate())
        var compMonth = calendar.components(NSCalendarUnit.MonthCalendarUnit, fromDate: NSDate())
        
//        let formatter = NSDateFormatter()
//        formatter.timeStyle = .MediumStyle
//        formatter.stringFromDate(currentDate)
//        println(formatter.stringFromDate(currentDate))
//        println(currentDate)
//        formatter.dateFormat = "yyyyMMdd"
//        formatter.dateStyle = .MediumStyle
//        formatter.stringFromDate(currentDate)
//        println(formatter.stringFromDate(currentDate))
        
        var dateComp: NSDateComponents = NSDateComponents()
        dateComp.year = compYear.year
        dateComp.month = compMonth.month
        dateComp.day = compDay.day
        dateComp.hour = 16
        dateComp.minute = 06
        dateComp.timeZone = NSTimeZone.systemTimeZone()
        
        
        var date: NSDate = calendar.dateFromComponents(dateComp)!

        var notification: UILocalNotification = UILocalNotification()
        notification.category = "FIRST_CATEGORY"
        notification.alertBody = "Você já praticou hoje?"
        notification.fireDate = date
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        //////////////////////////////////////////
        
        pageController.dataSource=self
        pageController.view.frame = self.view.bounds
        let initial :  StartChildViewController = self.viewcontrollerAtIndex(0)
        
        var viewControllers = [initial]
        self.pageController.setViewControllers(viewControllers, direction:.Forward, animated: false, completion: nil)
        self.addChildViewController(self.pageController)
        self.view.addSubview(self.pageController.view)
        self.pageController.didMoveToParentViewController(self)
        
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageControl.backgroundColor = UIColor(red: 241/255, green: 230/255, blue: 225/255, alpha: 1)

      
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func drawAShape(notification: NSNotification){
      println("oi")
        
    }
    
    func showAMessage(notification: NSNotification){
        var message : UIAlertController = UIAlertController(title: "mensagem da notifcação", message: "Lindo isso tudo", preferredStyle: UIAlertControllerStyle.Alert)
        message.addAction(UIAlertAction(title: "OIII", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(message, animated: true, completion: nil)
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
