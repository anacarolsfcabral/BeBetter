//
//  StartViewController.swift
//  BeBetter
//
//  Created by Mayara Mara Leite de Souza on 24/07/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UIPageViewControllerDataSource {
    
    var index : Int = 0

    var pageController = UIPageViewController(transitionStyle: .Scroll ,navigationOrientation: .Horizontal, options: nil)
    var pageControl = UIPageControl.appearance()
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var vc = viewController as! StartChildViewController
        self.index = vc.index as Int
        self.index++

        if(self.index == 2)
        {
            return nil
        }

//        return self.viewcontrollerAtIndex(index)
        let cat = self.viewcontrollerAtIndex(self.index)
        
        let nav = UINavigationController(nibName: "nav", bundle: nil)
        nav.viewControllers = [cat]
        nav.navigationBar.hidden = true
        
        return cat
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?{
        
        var vc = viewController as! StartChildViewController
        self.index = vc.index as Int
        
        if self.index == 0
        {
            return nil
        }
        
        self.index--
        
        return self.viewcontrollerAtIndex(index)
    }
    
    func viewcontrollerAtIndex(index: Int) -> StartChildViewController
    {
        let child = StartChildViewController(nibName: "StartChildView", bundle: nil)
        child.index=self.index
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
        
        //////PageViewController///////
        
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

    }

    override func didReceiveMemoryWarning()
    {
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
