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
    
    var blurView: UIVisualEffectView!
    var tela: UIView!
    var blur: UIBlurEffect!
    var cancelButton : UIButton!
    var dismissButton : UIButton!
    var saveButton : UIButton!
    var nomeText : UITextField!
    var titulo : UILabel!

    var noteText  = ""
    
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
                player.playFromBeginning()
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
        
    }
    
    func vision(vision: PBJVision, capturedVideo videoDict: [NSObject : AnyObject]?, error: NSError?) {
        
        videoPath = videoDict!["PBJVisionVideoPathKey"] as! String
        
        println(videoPath)
        
        if (videoPath != "") {
            changeBut.enabled = true
        }
        
    }
    
    @IBAction func addNote(sender: UIButton) {
        
        let altura:CGFloat = view.frame.height*0.08;
        let alturaLabel:CGFloat = view.frame.height*0.09
        
        // Blur Effect
        blur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        blurView = UIVisualEffectView(effect: blur)
        blurView.frame = view.bounds
        
        //declaracao da area e definicao do tamanho//
        var area:CGRect = CGRectMake(view.frame.width*0.05, view.frame.height*0.2, view.frame.width*0.90
            , altura*6);
        
        //definindo que eh a view eh a tela//
        tela = UIView(frame: area)
        //acessando uma propriedade da tela(UIView) alterando as bordas//
        tela.layer.cornerRadius = 5
        tela.backgroundColor = UIColor(red: 51/255, green: 151/255, blue: 150/255, alpha: 1)
        dismissButton = UIButton(frame: CGRectMake(0,0, view.frame.width, view.frame.height))
        
        
        //adicionando uma subview(tela) dentro da tela principal//
        view.addSubview(blurView)
        view.addSubview(dismissButton)
        view.addSubview(tela)
        
        //criando campos de texto//
        let spacing:CGFloat = area.width*0.05;
        let spacingLabel: CGFloat = (blurView.frame).width*0.18
        
        titulo = UILabel(frame: CGRectMake(spacingLabel, alturaLabel, area.width*0.7, alturaLabel/2))
        titulo.textAlignment = NSTextAlignment.Center
        titulo.text = "New Note"
        titulo.textColor = UIColor(red: 241/255, green: 230/255, blue: 225/255, alpha: 1)
        titulo.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        
        //botao pra cancelar
        cancelButton = UIButton(frame: CGRectMake(spacing, altura/4, area.width*0.22, altura/2))
        cancelButton.setTitle("Cancel", forState: UIControlState.Normal)
        cancelButton.titleLabel!.font = UIFont(name: "AvenirNext-Medium", size: 20)
        cancelButton.addTarget(self, action: "backToActivity:", forControlEvents: UIControlEvents.TouchUpInside)
        cancelButton.setTitleColor(UIColor(red: 241/255, green: 230/255, blue: 225/255, alpha: 1), forState: UIControlState.Normal)
        
        //botao pra salver
        saveButton = UIButton(frame: CGRectMake(area.width - spacing - area.width*0.18, altura/4, area.width*0.2, altura/2))
        saveButton.setTitle("Save", forState: UIControlState.Normal)
        saveButton.titleLabel!.font = UIFont(name: "AvenirNext-Medium", size: 20)
        saveButton.addTarget(self, action: "saveNote:", forControlEvents: UIControlEvents.TouchUpInside)
        saveButton.setTitleColor(UIColor(red: 241/255, green: 230/255, blue: 225/255, alpha: 1), forState: UIControlState.Normal)
        
        // Name Text Field
        
        nomeText = UITextField(frame: CGRectMake(spacing, cancelButton.frame.origin.y + altura/1.4, area.width, altura))
        nomeText.font = UIFont(name: "AvenirNext-Regular", size: 18)
        nomeText.autocorrectionType = UITextAutocorrectionType.No;
        nomeText.placeholder = "Write a note for this exercise"
    
        blurView.addSubview(titulo)
        tela.addSubview(nomeText)
        tela.addSubview(cancelButton)
        tela.addSubview(saveButton)

        
    }
    
    func backToActivity(sender: UIButton){
    
        blurView.removeFromSuperview()
        tela.removeFromSuperview()
        dismissButton.removeFromSuperview()
    
    }
    
    func saveNote(sender: UIButton){
        noteText = nomeText.text
        DAO.sharedInstance.uptadeActivityNotas(noteText, activity: currentActivity)
        blurView.removeFromSuperview()
        tela.removeFromSuperview()
        dismissButton.removeFromSuperview()
        
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
