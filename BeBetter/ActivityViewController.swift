//
//  ActivityViewController.swift
//  BeBetter
//
//  Created by Ana Carolina Cabral on 21/07/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController, PBJVideoPlayerControllerDelegate, PBJVisionDelegate {

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
        
        setup()
        // Do any additional setup after loading the view.
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
