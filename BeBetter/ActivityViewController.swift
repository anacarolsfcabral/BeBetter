//
//  ActivityViewController.swift
//  BeBetter
//
//  Created by Ana Carolina Cabral on 21/07/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController, PBJVideoPlayerControllerDelegate, PBJVisionDelegate, UIGestureRecognizerDelegate {

    @IBOutlet var exerciseNameLabel: UILabel!
    @IBOutlet var videoTutorialView: UIView!
    @IBOutlet var recordVideoView: UIView!
    @IBAction func backButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    //@IBOutlet var playVideoBut: UIButton!
    @IBOutlet var pauseVideoBut: UIButton!
    @IBOutlet var restartVideoBut: UIButton!
    @IBOutlet var changeBut: UIButton!
    
    var buttonImagePlay: UIImage!
    var buttonImagepause: UIImage!
    var buttonImageChange:UIImage!
    var videoPath: String!
    
    
    var player = PBJVideoPlayerController()
    var playNew = PBJVideoPlayerController()
    var previewView: UIView = UIView(frame: CGRectZero)
    var previewLayer = PBJVision.sharedInstance().previewLayer
    var pathString : String!
    var videoStatusImage = UIImageView()
    var videoJustRecordedStatusImage = UIImageView()
    
    var vision: PBJVision = PBJVision.sharedInstance()
    
    var videoIsPlaying : Bool = true
    var isRecordingNewVideo = true
    var gonnaStartRecording = true
    var isPractsingExercise = true
    var isPlaying = true
    
    var currentActivity:Activity = DAO.sharedInstance.getCurrentAcivity()
    var currentPerformance: PerformanceForWeek = DAO.sharedInstance.getCurrentPerformance()
    var currentFrequency: FrequencyActivity = DAO.sharedInstance.getCurrentFrequency()
    
//    @IBAction func playVideo(sender: UIButton) {
//        
//        if isPlaying==true{
//            
//            playNew.stop()
//            isPlaying = false
//            buttonImagePlay = UIImage(named: "play")
//            playVideoBut.setImage(buttonImagePlay, forState: UIControlState.Normal)
//
//            
//        }
//        else
//        {
//            playNew.playFromCurrentTime()
//            isPlaying = true
//            buttonImagePlay = UIImage(named: "pause")
//            playVideoBut.setImage(buttonImagePlay, forState: UIControlState.Normal)
//            
//        }
//    }
    
    
    
    
    @IBAction func finished(sender: UIButton) {
        
    
        var gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        var comps = gregorian?.components(NSCalendarUnit.WeekdayCalendarUnit, fromDate: NSDate())
        var weekday: Int =  comps!.weekday as Int
        
        currentPerformance = DAO.sharedInstance.updatePerformance(currentPerformance, weekDay: weekday)
        
        var dayRepetitionDone = currentPerformance.daysWithAmountForDay.objectForKey("\(weekday)") as! Int
        var dayRepetitionToDo = currentFrequency.daysWithAmountForDay.objectForKey("\(weekday)") as! Int
        
        if dayRepetitionDone >= dayRepetitionToDo{
            
            currentPerformance = DAO.sharedInstance.updatePerformanceCompleted(currentPerformance)
            
        }
        
        let nextWindow = PerformanceViewController(nibName:"PerformanceView", bundle: nil)
        self.presentViewController(nextWindow, animated: true, completion: nil)

    }
    
    @IBAction func pauseVideo(sender: UIButton) {
        
            
            if gonnaStartRecording == true{
                vision.startVideoCapture()
                gonnaStartRecording = false
                buttonImagepause = UIImage(named: "isRecording")
                pauseVideoBut.setImage(buttonImagepause, forState: UIControlState.Normal)
            }
            
            else if isRecordingNewVideo == true && gonnaStartRecording == false{
            
                vision.pauseVideoCapture()
                isRecordingNewVideo = false
                buttonImagepause = UIImage(named: "notRecording")
                pauseVideoBut.setImage(buttonImagepause, forState: UIControlState.Normal)
                
            }
            else if isRecordingNewVideo == false && gonnaStartRecording==false
            {
                vision.resumeVideoCapture()
                isRecordingNewVideo = true
                buttonImagepause = UIImage(named: "isRecording")
                pauseVideoBut.setImage(buttonImagepause, forState: UIControlState.Normal)
            }
    }
    
    
    @IBAction func restartVideo(sender: UIButton) {
        
        vision.endVideoCapture()
        gonnaStartRecording = true
        buttonImagepause = UIImage(named: "notRecording")
        pauseVideoBut.setImage(buttonImagepause, forState: UIControlState.Normal)
    }
    @IBAction func changeMode(sender: UIButton) {
        if isPractsingExercise == true {
        
            //previewView.hidden=true
            //playNew.view.hidden = false
        
            playNew.view.frame = recordVideoView.bounds
            recordVideoView.addSubview(playNew.view)
            playNew.videoPath = videoPath
            playNew.playFromBeginning()
            playNew.videoFillMode = "AVLayerVideoGravityResizeAspect"
            playNew.playbackLoops = true
            playNew.volume = 1
            
//            playVideoBut.enabled = true
//            playVideoBut.alpha = 1.0
            pauseVideoBut.enabled = false
            pauseVideoBut.alpha = 0.6
            restartVideoBut.enabled = false
            restartVideoBut.alpha = 0.6

            buttonImageChange = UIImage(named: "recordActivity")
            changeBut.setImage(buttonImageChange, forState: UIControlState.Normal)
            isPractsingExercise = false
            
        }
        else
        {
            playNew.view.removeFromSuperview()
            isPractsingExercise = true
//            playVideoBut.alpha = 0.6
//            playVideoBut.enabled = false
            pauseVideoBut.enabled = true
            pauseVideoBut.alpha = 1.0
            restartVideoBut.enabled = true
            restartVideoBut.alpha = 1.0
            changeBut.enabled = false
            
            buttonImageChange = UIImage(named: "seeActivity")
            changeBut.setImage(buttonImageChange, forState: UIControlState.Normal)
            
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        println(currentActivity.videoTutorial)
        
        videoPath = currentActivity.videoTutorial
        exerciseNameLabel.text = currentActivity.name
        
        if isPractsingExercise == true {
            
//            playVideoBut.alpha = 0.6
//            playVideoBut.enabled = false
            changeBut.enabled = false
        }
        
        playNew.delegate = self
        player.delegate = self
        player.view.frame = videoTutorialView.bounds
        videoTutorialView.addSubview(player.view)
        player.videoPath = videoPath
        player.playFromBeginning()
        player.videoFillMode = "AVLayerVideoGravityResizeAspect"
        player.playbackLoops = true
        player.volume = 1
        
        
        previewView.backgroundColor = UIColor.blackColor()
        previewView.frame = recordVideoView.bounds
        
        previewLayer.frame = previewView.bounds
        previewLayer.videoGravity = "AVLayerVideoGravityResizeAspect"
        previewView.layer.addSublayer(previewLayer)
        
        recordVideoView.addSubview(previewView)
        
        
        videoStatusImage.image = UIImage(named: "pauseRegister")
        videoStatusImage.frame = player.view.frame
        videoTutorialView.addSubview(videoStatusImage)
        videoStatusImage.alpha = 0.8
        videoStatusImage.frame.size = CGSize(width: 20, height: 20)
        videoStatusImage.center = CGPointMake(videoTutorialView.bounds.midX/4, videoTutorialView.bounds.midY/6)
        
        
        videoJustRecordedStatusImage.image = UIImage(named: "pauseRegister")
        videoJustRecordedStatusImage.frame = player.view.frame
        playNew.view.addSubview(videoJustRecordedStatusImage)
        videoJustRecordedStatusImage.alpha = 0.8
        videoJustRecordedStatusImage.frame.size = CGSize(width: 20, height: 20)
        videoJustRecordedStatusImage.center = CGPointMake(recordVideoView.bounds.midX/4, recordVideoView.bounds.midY/6)

        view.backgroundColor = UIColor.blackColor()

        
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        
       
        vision.delegate = self
        vision.cameraMode = PBJCameraMode.Video
        vision.cameraDevice = PBJCameraDevice.Front
        vision.cameraOrientation = PBJCameraOrientation.Portrait
        vision.focusMode = PBJFocusMode.ContinuousAutoFocus
        vision.outputFormat = PBJOutputFormat.Square
        
        vision.startPreview()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func videoPlayerBufferringStateDidChange(videoPlayer: PBJVideoPlayerController!) {
        
    }
    
    func videoPlayerPlaybackWillStartFromBeginning(videoPlayer: PBJVideoPlayerController!) {
    
    }
    
    func videoPlayerPlaybackDidEnd(videoPlayer: PBJVideoPlayerController!) {
    
    }
    
    func videoPlayerPlaybackStateDidChange(videoPlayer: PBJVideoPlayerController!) {
        
        if player.playbackState == PBJVideoPlayerPlaybackState.Paused {
            
            println("ta pausado")
            videoStatusImage.image = UIImage(named: "playRegister")
            //PBJVideoPlayerPlaybackStatePlaying
        }
        else
        {
            println("ta rodando")
            videoStatusImage.image = UIImage(named: "pauseRegister")
            
        }

        if playNew.playbackState == PBJVideoPlayerPlaybackState.Paused {
            
            println("ta pausado")
            videoJustRecordedStatusImage.image = UIImage(named: "playRegister")
            //PBJVideoPlayerPlaybackStatePlaying
        }
        else
        {
            println("ta rodando")
            videoJustRecordedStatusImage.image = UIImage(named: "pauseRegister")
            
        }

    }
    
    func videoPlayerReady(videoPlayer: PBJVideoPlayerController!) {
        
    }
    
    
    @IBAction func goToPerformance(sender: AnyObject)
    {
        let nextWindow = PerformanceViewController(nibName:"PerformanceView", bundle: nil)
        self.presentViewController(nextWindow, animated: true, completion: nil)
    }
    
    @IBAction func moveVideos(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(self.view)
        if let view = sender.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
        }
        sender.setTranslation(CGPointZero, inView: self.view)
    }
    
    @IBAction func changeSize(sender: UIPinchGestureRecognizer) {
        
        if let view = sender.view {
            view.transform = CGAffineTransformScale(view.transform,
                sender.scale, sender.scale)
            sender.scale = 1
        }
    }
    
    func visionDidEndVideoCapture(vision: PBJVision) {
        
//        println("ended")
//        
//        NSString *videoPath = [_currentVideo  objectForKey:PBJVisionVideoPathKey];
//        
//        
        
//        [_assetLibrary writeVideoAtPathToSavedPhotosAlbum:[NSURL URLWithString:videoPath] completionBlock:^(NSURL *assetURL, NSError *error1) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Saved!" message: @"Saved to the camera roll."
//            delegate:self
//            cancelButtonTitle:nil
//            otherButtonTitles:@"OK", nil];
//            [alert show];
//            }];
    }
    
    func vision(vision: PBJVision, capturedVideo videoDict: [NSObject : AnyObject]?, error: NSError?) {
        
        videoPath = videoDict!["PBJVisionVideoPathKey"] as! String
        
        println(videoPath)
        
        if (videoPath != "") {
            changeBut.enabled = true
        }
        
    
//        println(videoDict?.keys)
//        println(videoDict?.values)


        
//        for (key, value) in videoDict! {
//            
////            println(key)
//            if value is String {
//                println(value)
//
//            }
//        }
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
