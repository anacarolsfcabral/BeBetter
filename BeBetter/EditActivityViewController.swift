//
//  EditActivityViewController.swift
//  BeBetter
//
//  Created by Ana Carolina Cabral on 05/08/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class EditActivityViewController: UIViewController, PBJVideoPlayerControllerDelegate {
    
    @IBOutlet var videoPlayerView: UIView!
    @IBOutlet var nameExerciseTextField: UITextField!
    @IBOutlet var weekLabel: UILabel!
    @IBOutlet var weekStepper: UIStepper!
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var dayStepper: UIStepper!
    
    @IBOutlet weak var sundayButton: UIButton!
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!

    var isSundayBege = true
    var isMondayBege = true
    var isTuesdayBege = true
    var isWednesdayBege = true
    var isThursdayBege = true
    var isFridayBege = true
    var isSaturdayBege = true
    
    var buttonImageSunday : UIImage!
    var buttonImageMonday : UIImage!
    var buttonImageTuesday : UIImage!
    var buttonImageWednesday : UIImage!
    var buttonImageThursday : UIImage!
    var buttonImageFriday : UIImage!
    var buttonImageSaturday : UIImage!
    
    var somaDias = 0
    var daysWithAmountForDay : NSMutableDictionary = [ "1" : 0, "2" : 0, "3" : 0, "4" : 0, "5" : 0, "6" : 0, "7" : 0]
    
    
    var selectedDaysCount : Int = 0
    var tempImage: NSURL!
    
    var currentActivity:Activity = DAO.sharedInstance.getCurrentAcivity()
    var currentPerformance: PerformanceForWeek = DAO.sharedInstance.getCurrentPerformance()
    var currentFrequency: FrequencyActivity = DAO.sharedInstance.getCurrentFrequency()
    

    var alreadyRecorded = false
    var player = PBJVideoPlayerController()
    var videoStatusImage = UIImageView()
    
    var screenTap : UITapGestureRecognizer!
    var videoLoop : UITapGestureRecognizer!
    var videoIsPlaying : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()


        nameExerciseTextField.text = currentActivity.name
        weekLabel.text = String(currentFrequency.amountWeeks)
        weekStepper.value = Double(currentFrequency.amountWeeks)
        
        var dictFrequency = currentFrequency.daysWithAmountForDay as NSMutableDictionary
        var daysRepetitions = 0
        
        if dictFrequency.objectForKey("1") as! Int > 0 {
            println("oi1")
            daysRepetitions = dictFrequency.objectForKey("1") as! Int
            buttonImageSunday = UIImage(named: "S")
            sundayButton.setImage(buttonImageSunday, forState: UIControlState.Normal)
            isSundayBege = false
        }
        if dictFrequency.objectForKey("2") as! Int > 0 {
             println("oi2")
            daysRepetitions = dictFrequency.objectForKey("2") as! Int
            buttonImageMonday = UIImage(named: "M")
            mondayButton.setImage(buttonImageMonday, forState: UIControlState.Normal)
            isMondayBege = false
        }
        if dictFrequency.objectForKey("3") as! Int > 0 {
             println("oi3")
            daysRepetitions = dictFrequency.objectForKey("3") as! Int
            buttonImageTuesday = UIImage(named: "T")
            tuesdayButton.setImage(buttonImageTuesday, forState: UIControlState.Normal)
            isTuesdayBege = false
        }
        if dictFrequency.objectForKey("4") as! Int > 0 {
            daysRepetitions = dictFrequency.objectForKey("4") as! Int
            buttonImageWednesday = UIImage(named: "W")
            wednesdayButton.setImage(buttonImageWednesday, forState: UIControlState.Normal)
            isWednesdayBege = false
        }
        if dictFrequency.objectForKey("5") as! Int > 0 {
            daysRepetitions = dictFrequency.objectForKey("5") as! Int
            buttonImageThursday = UIImage(named: "T")
            thursdayButton.setImage(buttonImageThursday, forState: UIControlState.Normal)
            isThursdayBege=false
        }
        if dictFrequency.objectForKey("6") as! Int > 0 {
            daysRepetitions = dictFrequency.objectForKey("6") as! Int
            buttonImageFriday = UIImage(named: "F")
            fridayButton.setImage(buttonImageFriday, forState: UIControlState.Normal)
            isFridayBege = false
        }
        if dictFrequency.objectForKey("7") as! Int > 0 {
            daysRepetitions = dictFrequency.objectForKey("7") as! Int
            buttonImageSaturday = UIImage(named: "S")
            saturdayButton.setImage(buttonImageSaturday, forState: UIControlState.Normal)
            isSaturdayBege = false
        }
        
        dayLabel.text = String(daysRepetitions)
        dayStepper.value = Double(daysRepetitions)
        
        videoPlayer()
        
        self.screenTap = UITapGestureRecognizer(target: self, action: "keyboardTap:")
        self.view.addGestureRecognizer(screenTap)
        
        weekStepper.wraps = true
        weekStepper.autorepeat = true
        weekStepper.maximumValue = 5
        
        dayStepper.wraps = true
        dayStepper.autorepeat = true
        dayStepper.maximumValue = 20
        self.videoLoop = UITapGestureRecognizer(target: self, action: "playerLoopControl:")
        self.videoPlayerView.addGestureRecognizer(videoLoop)
        
        // Do any additional setup after loading the view.
    }
    
    func videoPlayer (){
        alreadyRecorded = true
        self.dismissViewControllerAnimated(true, completion: {})
        player.delegate = self
        player.view.frame = videoPlayerView.bounds
        videoPlayerView.addSubview(player.view)
        player.videoPath = currentActivity.videoTutorial
        player.playFromBeginning()
        player.videoFillMode = "AVLayerVideoGravityResizeAspect"
        player.playbackLoops = true
        player.volume = 1
        videoStatusImage.image = UIImage(named: "pauseRegister")
        videoStatusImage.frame = player.view.frame
        videoPlayerView.addSubview(videoStatusImage)
        videoStatusImage.alpha = 0.8
        videoStatusImage.frame.size = CGSize(width: 20, height: 20)
        videoStatusImage.center = CGPointMake(videoPlayerView.bounds.midX/6, videoPlayerView.bounds.midY/4)
        
    }
    
    func playerLoopControl(tap: UITapGestureRecognizer) {
        
        if videoIsPlaying == true{
            player.stop()
            videoIsPlaying = false
            videoStatusImage.image = UIImage(named: "playRegister")
        }else if videoIsPlaying == false{
            player.playFromCurrentTime()
            videoIsPlaying = true
            videoStatusImage.image = UIImage(named: "pauseRegister")
        }
    }


    @IBAction func sundayButton(sender: AnyObject){
        if isSundayBege == true {
            buttonImageSunday = UIImage(named: "S")
            sundayButton.setImage(buttonImageSunday, forState: UIControlState.Normal)
            isSundayBege = false
        }
        else{
            buttonImageSunday = UIImage(named: "SD")
            sundayButton.setImage(buttonImageSunday, forState: UIControlState.Normal)
            isSundayBege = true
        }
    }
    
    @IBAction func mondayButton(sender: AnyObject){
        if isMondayBege == true{
            buttonImageMonday = UIImage(named: "M")
            mondayButton.setImage(buttonImageMonday, forState: UIControlState.Normal)
            isMondayBege = false
        }else{
            buttonImageMonday = UIImage(named: "MD")
            mondayButton.setImage(buttonImageMonday, forState: UIControlState.Normal)
            isMondayBege = true
        }
    }
    
    @IBAction func tuesdayButton(sender: AnyObject){
        if isTuesdayBege == true{
            buttonImageTuesday = UIImage(named: "T")
            tuesdayButton.setImage(buttonImageTuesday, forState: UIControlState.Normal)
            isTuesdayBege = false
        }else{
            buttonImageTuesday = UIImage(named: "TD")
            tuesdayButton.setImage(buttonImageTuesday, forState: UIControlState.Normal)
            isTuesdayBege = true
        }
    }
    
    @IBAction func wednesdayButton(sender: AnyObject){
        if isWednesdayBege == true{
            buttonImageWednesday = UIImage(named: "W")
            wednesdayButton.setImage(buttonImageWednesday, forState: UIControlState.Normal)
            isWednesdayBege = false
        }else{
            buttonImageWednesday = UIImage(named: "WD")
            wednesdayButton.setImage(buttonImageWednesday, forState: UIControlState.Normal)
            isWednesdayBege = true
        }
    }
    
    @IBAction func thursdayButton(sender: AnyObject){
        if isThursdayBege == true {
            buttonImageThursday = UIImage(named: "T")
            thursdayButton.setImage(buttonImageThursday, forState: UIControlState.Normal)
            isThursdayBege=false
        }else{
            buttonImageThursday = UIImage(named: "TD")
            thursdayButton.setImage(buttonImageThursday, forState: UIControlState.Normal)
            isThursdayBege=true
        }
    }
    
    @IBAction func fridayButton(sender: AnyObject){
        if isFridayBege == true{
            buttonImageFriday = UIImage(named: "F")
            fridayButton.setImage(buttonImageFriday, forState: UIControlState.Normal)
            isFridayBege = false
        }else{
            buttonImageFriday = UIImage(named: "FD")
            fridayButton.setImage(buttonImageFriday, forState: UIControlState.Normal)
            isFridayBege = true
        }
    }
    
    @IBAction func saturdayButtonPressed(sender: AnyObject){
        if isSaturdayBege == true {
            buttonImageSaturday = UIImage(named: "S")
            saturdayButton.setImage(buttonImageSaturday, forState: UIControlState.Normal)
            isSaturdayBege = false
        }else{
            buttonImageSaturday = UIImage(named: "SD")
            saturdayButton.setImage(buttonImageSaturday, forState: UIControlState.Normal)
            isSaturdayBege = true
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButton(sender: UIButton) {
        var isSaved : Bool
        var activity : Activity
        var frequency : FrequencyActivity
        
        if isSundayBege == true{
            daysWithAmountForDay.setValue(0, forKey: "1")
        }else{
            daysWithAmountForDay.setValue(dayStepper.value, forKey: "1")
            selectedDaysCount++
        }
        
        if isMondayBege == true{
            daysWithAmountForDay.setValue(0, forKey: "2")
        }else{
            daysWithAmountForDay.setValue(dayStepper.value, forKey: "2")
            selectedDaysCount++
        }
        
        if isTuesdayBege == true{
            daysWithAmountForDay.setValue(0, forKey: "3")
        }else{
            daysWithAmountForDay.setValue(dayStepper.value, forKey: "3")
            selectedDaysCount++
        }
        
        if isWednesdayBege == true{
            daysWithAmountForDay.setValue(0, forKey: "4")
        }else{
            daysWithAmountForDay.setValue(dayStepper.value, forKey: "4")
            selectedDaysCount++
        }
        
        if isThursdayBege == true{
            daysWithAmountForDay.setValue(0, forKey: "5")
        }else{
            daysWithAmountForDay.setValue(dayStepper.value, forKey: "5")
            selectedDaysCount++
        }
        
        if isFridayBege == true {
            daysWithAmountForDay.setValue(0, forKey: "6")
        }else {
            daysWithAmountForDay.setValue(dayStepper.value, forKey: "6")
            selectedDaysCount++
        }
        if isSaturdayBege == true {
            daysWithAmountForDay.setValue(0, forKey: "7")
        }else {
            daysWithAmountForDay.setValue(dayStepper.value, forKey: "7")
            selectedDaysCount++
        }
        
        var amounts = Int(weekStepper.value)
   
        activity = Activity(name: nameExerciseTextField.text, videoTutorial: currentActivity.videoTutorial, category: currentActivity.category, note:currentActivity.note)
        frequency = FrequencyActivity(amountWeeks: amounts , daysWithAmountForDay: daysWithAmountForDay as NSMutableDictionary , selectedDaysCount: selectedDaysCount)
        println(activity)
        println(frequency)
        
        if ((nameExerciseTextField == "") || ( weekStepper.value == 0 ) || ( dayStepper.value == 0 ) || (isSaturdayBege==true && isSundayBege == true && isMondayBege==true && isTuesdayBege==true && isWednesdayBege==true && isThursdayBege==true && isFridayBege==true )){
            
            var alert = UIAlertController(title: "Alert", message: "You must complete all the informations before continuing ", preferredStyle:UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            isSaved = DAO.sharedInstance.updateActivity(activity, frequency: frequency, id: currentActivity.id)
            
            if isSaved == true {
                let nextWindow = PerformanceViewController(nibName:"PerformanceView", bundle: nil)
                self.presentViewController(nextWindow, animated: true, completion: nil)
                //                NSNotificationCenter.defaultCenter().postNotificationName("insertCell", object: nil)
            }else{
                var alert = UIAlertController(title: "Ops", message: "An error occurred while saving your activity", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }

    @IBAction func cancelButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func weekStepper(sender: UIStepper) {
        
        weekLabel.text = Int(sender.value).description
    }
    
    @IBAction func dayStepper(sender: UIStepper) {
        dayLabel.text = Int(sender.value).description
    }
    
    
    func videoPlayerBufferringStateDidChange(videoPlayer: PBJVideoPlayerController!) {
    }
    
    func videoPlayerPlaybackWillStartFromBeginning(videoPlayer: PBJVideoPlayerController!) {
    }
    
    func videoPlayerPlaybackDidEnd(videoPlayer: PBJVideoPlayerController!) {
    }
    
    func videoPlayerPlaybackStateDidChange(videoPlayer: PBJVideoPlayerController!) {
    }
    
    func videoPlayerReady(videoPlayer: PBJVideoPlayerController!) {
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
