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

class RegisterVideoViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate, PBJVideoPlayerControllerDelegate {

    let captureSession = AVCaptureSession()
    var previewLayer : AVCaptureVideoPreviewLayer?
    var captureDevice : AVCaptureDevice?
    var alreadyRecorded = false
    var didCancel = false
    var pathString : String!
    var tempImage: NSURL!
    
    var player = PBJVideoPlayerController()
    
    var screenTap : UITapGestureRecognizer!
    var videoLoop : UITapGestureRecognizer!
    var videoIsPlaying : Bool = true
    
    var isSundayBege = true
    var isMondayBege = true
    var isTuesdayBege = true
    var isWednesdayBege = true
    var isThursdayBege = true
    var isFridayBege = true
    var isSaturday = true
    
    var buttonImageSunday : UIImage!
    var buttonImageMonday : UIImage!
    var buttonImageTuesday : UIImage!
    var buttonImageWednesday : UIImage!
    var buttonImageThursday : UIImage!
    var buttonImageFriday : UIImage!
    var buttonImageSaturday : UIImage!

    
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
    
    
    @IBAction func sundayButton(sender: AnyObject)
    {
        if isSundayBege == true {
            buttonImageSunday = UIImage(named: "S")
            sundayButton.setImage(buttonImageSunday, forState: UIControlState.Normal)
            isSundayBege = false
        }
        else
        {
            buttonImageSunday = UIImage(named: "SD")
            sundayButton.setImage(buttonImageSunday, forState: UIControlState.Normal)
            isSundayBege = true
        }
        
    }
    
    @IBAction func mondayButton(sender: AnyObject)
    {
        if isMondayBege == true{
        
            buttonImageMonday = UIImage(named: "M")
            mondayButton.setImage(buttonImageMonday, forState: UIControlState.Normal)
            isMondayBege = false
        }
        else
        {
            buttonImageMonday = UIImage(named: "MD")
            mondayButton.setImage(buttonImageMonday, forState: UIControlState.Normal)
            isMondayBege = true

        }
    }

    @IBAction func tuesdayButton(sender: AnyObject)
    {
        if isTuesdayBege == true{
            buttonImageTuesday = UIImage(named: "T")
            tuesdayButton.setImage(buttonImageTuesday, forState: UIControlState.Normal)
            isTuesdayBege = false
        }
        else
        {
            buttonImageTuesday = UIImage(named: "TD")
            tuesdayButton.setImage(buttonImageTuesday, forState: UIControlState.Normal)
            isTuesdayBege = true
        }
    }
    
    @IBAction func wednesdayButton(sender: AnyObject)
    {
        if isWednesdayBege == true{
            buttonImageWednesday = UIImage(named: "W")
            wednesdayButton.setImage(buttonImageWednesday, forState: UIControlState.Normal)
            isWednesdayBege = false
        }
        else
        {
            buttonImageWednesday = UIImage(named: "WD")
            wednesdayButton.setImage(buttonImageWednesday, forState: UIControlState.Normal)
            isWednesdayBege = true

        }
    }
    
    @IBAction func thursdayButton(sender: AnyObject)
    {
        if isThursdayBege == true {
            buttonImageThursday = UIImage(named: "T")
            thursdayButton.setImage(buttonImageThursday, forState: UIControlState.Normal)
            isThursdayBege=false
        }
        else
        {
            buttonImageThursday = UIImage(named: "TD")
            thursdayButton.setImage(buttonImageThursday, forState: UIControlState.Normal)
            isThursdayBege=true
        }
    }
    
    @IBAction func fridayButton(sender: AnyObject)
    {
        if isFridayBege == true{
            buttonImageFriday = UIImage(named: "F")
            fridayButton.setImage(buttonImageFriday, forState: UIControlState.Normal)
            isFridayBege = false
        }
        else
        {
            buttonImageFriday = UIImage(named: "FD")
            fridayButton.setImage(buttonImageFriday, forState: UIControlState.Normal)
            isFridayBege = true

        }
    }
 
    @IBAction func saturdayButtonPressed(sender: AnyObject)
    {
        if isSaturday == true {
            buttonImageSaturday = UIImage(named: "S")
            saturdayButton.setImage(buttonImageSaturday, forState: UIControlState.Normal)
            isSaturday=false
        }
        else
        {
            buttonImageSaturday = UIImage(named: "SD")
            saturdayButton.setImage(buttonImageSaturday, forState: UIControlState.Normal)
            isSaturday=true
            
        }
    }
    

    
    
    @IBAction func cancelButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func sabeButton(sender: UIButton) {
        
        let nextWindow = ActivityViewController(nibName:"ActivityView", bundle: nil)
        nextWindow.pathString = pathString
        self.presentViewController(nextWindow, animated: true, completion: nil)
        
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
        player.videoPath = pathString
        player.playFromBeginning()
        player.videoFillMode = "AVLayerVideoGravityResizeAspect"
        player.playbackLoops = true
        player.volume = 1
        

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
    
}

