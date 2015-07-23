//
//  ActivityViewController.swift
//  BeBetter
//
//  Created by Ana Carolina Cabral on 21/07/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController, PBJVideoPlayerControllerDelegate {

    @IBOutlet var exerciseNameLabel: UILabel!
    @IBOutlet var videoTutorialView: UIView!
    @IBOutlet var recordVideoView: UIView!
    @IBAction func backButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var player = PBJVideoPlayerController()
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
        
        // Do any additional setup after loading the view.
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
