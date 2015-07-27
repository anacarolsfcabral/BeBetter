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
    
    var player = PBJVideoPlayerController()
    var previewView: UIView = UIView(frame: CGRectZero)
    var previewLayer = PBJVision.sharedInstance().previewLayer
    var pathString : String!
    var videoStatusImage = UIImageView()
    
    var screenTap : UITapGestureRecognizer!
    var videoLoop : UITapGestureRecognizer!
    var videoIsPlaying : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        player.delegate = self
        player.view.frame = videoTutorialView.bounds
        videoTutorialView.addSubview(player.view)
        player.videoPath = pathString
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
        videoTutorialView.center = CGPointMake(videoTutorialView.bounds.midX/2, videoTutorialView.bounds.midY/2)
        
        view.backgroundColor = UIColor.blackColor()

        
        setup()
        // Do any additional setup after loading the view.
    }
    
    func playerLoopControl(tap: UITapGestureRecognizer) {
        
        if videoIsPlaying == true
        {
            player.stop()
            videoIsPlaying = false
            videoStatusImage.image = UIImage(named: "playRegister")
        }
        else if videoIsPlaying == false
        {
            player.playFromCurrentTime()
            videoIsPlaying = true
            videoStatusImage.image = UIImage(named: "pauseRegister")
        }
        
    }
    
    func setup(){
        
        var vision: PBJVision = PBJVision.sharedInstance()
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
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
