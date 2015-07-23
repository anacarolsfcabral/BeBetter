//
//  RegisterCategoryViewController.swift
//  BeBetter
//
//  Created by Ana Carolina Cabral on 21/07/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices
import AVFoundation

class RegisterVideoViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate, PlayerDelegate {

    let captureSession = AVCaptureSession()
    var previewLayer : AVCaptureVideoPreviewLayer?
    var captureDevice : AVCaptureDevice?
    var alreadyRecorded = false
    var didCancel = false
    var pathString : String!
    var tempImage: NSURL!
    
    var player = Player()
    
    var screenTap : UITapGestureRecognizer!
    var videoLoop : UITapGestureRecognizer!
    var videoIsPlaying : Bool = true
    
    @IBOutlet var videoPlayerView: UIView!
    @IBOutlet var nameExerciseTextField: UITextField!
    @IBOutlet var weekLabel: UILabel!
    @IBOutlet var weekStepper: UIStepper!
   
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var dayStepper: UIStepper!
   
    @IBAction func mondayButton(sender: UIButton) {
    }
 
    @IBAction func tuesdayButton(sender: UIButton) {
    }
    
    @IBAction func wednesdayButton(sender: UIButton) {
    }
    
    @IBAction func thursdayButton(sender: UIButton) {
    }
    @IBAction func fridayButton(sender: UIButton) {
    }
    @IBAction func saturdayButton(sender: UIButton) {
    }
    
    @IBAction func sundayButton(sender: UIButton) {
    }
    
    @IBAction func cancelButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func sabeButton(sender: UIButton) {
    }
    
    @IBAction func weekStepper(sender: UIStepper) {
        
        weekLabel.text = Int(sender.value).description
    }
    
    @IBAction func dayStepper(sender: UIStepper) {
        
        dayLabel.text = Int(sender.value).description
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        if alreadyRecorded == false && didCancel == false{
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                
                
                println("captureVideoPressed and camera available.")
                
                var imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType = .Camera;
                imagePicker.mediaTypes = [kUTTypeMovie!]
                imagePicker.allowsEditing = false
                
                imagePicker.showsCameraControls = true
                
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
                
            }
                
            else {
                println("Camera not available.")
            }
        }
        
        else {
            println("ola")
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
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardTap(tap: UITapGestureRecognizer){
        nameExerciseTextField.resignFirstResponder()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject: AnyObject]) {
        
        tempImage = info[UIImagePickerControllerMediaURL] as! NSURL!
        pathString = tempImage.relativePath
        
        
        
        // Salvar no rolo da camera
        //UISaveVideoAtPathToSavedPhotosAlbum(pathString, self, nil, nil)
        
        // SALVAR NO PLIST PORRA AQUIIIII
    
        
        alreadyRecorded = true
        self.dismissViewControllerAnimated(true, completion: {})
        player.delegate = self
        player.view.frame = videoPlayerView.bounds
        videoPlayerView.addSubview(player.view)
        player.path = pathString
        player.playFromBeginning()
        player.fillMode = "AVLayerVideoGravityResizeAspect"
        player.playbackLoops = true
        

    }
    
    func playerLoopControl(tap: UITapGestureRecognizer) {
        
        if videoIsPlaying == true
        {
            player.stop()
            videoIsPlaying = false
        }
        else if videoIsPlaying == false
        {
            player.playFromCurrentTime()
            videoIsPlaying = true
        }
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.dismissViewControllerAnimated(true, completion: nil)
        didCancel=true
    }
    
    func playerReady(player: Player) {
    }
    
    func playerPlaybackStateDidChange(player: Player) {
    }
    
    func playerBufferingStateDidChange(player: Player) {
    }
    
    func playerPlaybackWillStartFromBeginning(player: Player) {
    }
    
    func playerPlaybackDidEnd(player: Player) {
    }
}

