//
//  ViewController.swift
//  Word-O-Rama
//
//  Created by Luke Schwarting on 2/20/17.
//  Copyright © 2017 Luke Schwarting. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    //ivars
    var words = MyAppData.shared.wordBankUsing
    var backgroundImage:UIImage?
    var fontSize: CGFloat = 18 //default font size
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        placewords()
        
        //MARK: - Notification -
        let nc = NotificationCenter.default
        
        nc.addObserver(self, selector: #selector(saveDefaultsData), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        
        //motion to add depth
        //create a motion effect x
        let leftRight = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        leftRight.minimumRelativeValue = -60.0
        leftRight.maximumRelativeValue = 60.0
        
        //y
        let topBottom = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        topBottom.minimumRelativeValue = -60.0
        topBottom.maximumRelativeValue = 60.0
        
        //put together
        let meGroup = UIMotionEffectGroup()
        meGroup.motionEffects = [leftRight,topBottom]
        //add to background view
        view.addMotionEffect(meGroup)
    }
    
    //func to place words on the screen
    func placewords()
    {
        view.backgroundColor = UIColor.darkGray //RIT orange
        
        //ivars
        let screenSize: CGRect = UIScreen.main.bounds
        var x = CGFloat(25)
        var y = CGFloat(50)
        var i = 0 //what word in the list
        var px: CGFloat! //pervious x
        var pw: CGFloat! //pervious width
        var py: CGFloat! //pervious y
        var wallpaddingNormal:CGFloat!
        
        for word in words
        {
            //loop through the words array creating a label for each and placing them on the screen
            let l = UILabel()
            l.backgroundColor = UIColor.white
            l.text = "\(word)  "
            l.font = l.font.withSize(fontSize) //font size
            l.sizeToFit()
            let width = l.frame.size.width           //grab width and height
            let height = l.frame.size.height
            let halfWidth = width/2
            let halfHeight = height/2
            l.textAlignment = NSTextAlignment.center
            if fontSize < 26
            {
                wallpaddingNormal = 65
            }
            else
            {
                wallpaddingNormal = 85
            }
        
            if i > 0
            {
                print("ss - wp: \((screenSize.width-wallpaddingNormal))")
                print("x value: \((x + width + 5))")
                //see if the point x + label width is inside the screen if not new row else print the new word
                if (x + width + 10) > (screenSize.width-wallpaddingNormal)
                {
                    //reset the x starting position and make a new row
                    x = CGFloat(25)
                    y = height + py + 5
                }
                else if (x + width + 10)  < screenSize.width-wallpaddingNormal
                {
                    //new x position is previous x + pervious width + a buffer
                    x = px + pw + 5
                }
            }
            
            l.center = CGPoint(x: x + halfWidth, y: y + halfHeight)
            //set the pervious variables
            px = x
            py = y
            pw = width
            view.addSubview(l)
            
            l.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
            l.addGestureRecognizer(panGesture)
            i += 1 //next word
        }
    }
    
    func doPanGesture(panGesture:UIPanGestureRecognizer)
    {
        let label = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        label.center = position
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Segue -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWordSegue"
        {
            let wordsVC = segue.destination.childViewControllers[0] as! WordsListTableVC
            wordsVC.title = "Choose a Word Bank"
        }
        if segue.identifier == "showEditSegue"
        {
            let editsVC = segue.destination.childViewControllers[0] as! EditTableVC
            editsVC.title = "Choose a Font Size"
        }
    }
    
    //MARK: - Image Picker -
    @IBAction func cameraButtonTapped(_ sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        //if UIImagePickerController.isSourceTypeAvailable(.camera){         
        //     imagePickerController.sourceType = .camera         
        // }else{         
        //      imagePickerController.sourceType = .savedPhotosAlbum         
        // }         
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true,completion: { imageP in })
    }
    
    // MARK: - UIIamgePickerController Delegate Methods -
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        print("finished picking")
        let image:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        //set the image as the background 3 lines V
        backgroundImage = image
        (self.view as! UIImageView).contentMode = .center
        (self.view as! UIImageView).image = backgroundImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        print("cancelled")
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - StoryBoard Actions -
    @IBAction func unwindToMain(segue:UIStoryboardSegue)
    {
        if segue.identifier == "DoneTapped"
        {
            //get rid of all the labels
            for w in view.subviews
            {
                if w is UILabel
                {
                    w.removeFromSuperview()
                }
            }
            let wordsListVC = segue.source as! WordsListTableVC
            let word = wordsListVC.selectedWordList
            
            MyAppData.shared.wordBankUsing = wordsListVC.selectedWordList
            
            //print the words to the screen
            words = word
            placewords()
        }
        if segue.identifier == "DoneTappedFont"
        {
            //get rid of all the labels
            for w in view.subviews
            {
                if w is UILabel
                {
                    w.removeFromSuperview()
                }
            }
            
            let fontSizeVC = segue.source as! EditTableVC
            let fs = fontSizeVC.selectedFontSize
            
            fontSize = CGFloat(fs)
            
            placewords()
        }
    }
    //sharing
    @IBAction func share(_ sender: AnyObject)
    {
        //snap shot
        let image = self.view.takeSnapshot()
        
        let textToShare = "I just used Word-O-Rama!\nAnd made my own funny poem!\n"
        let myWebsite = NSURL(string: "http://lukeschwarting.com")
        let objectsToShare:[AnyObject] = [textToShare as AnyObject, myWebsite!, image!]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityType.print]
        // These 3 commented out lines will help you on an iPad
        //let popoverMenuViewController = activityVC.popoverPresentationController
        //popoverMenuViewController?.permittedArrowDirections = .any
        //popoverMenuViewController?.barButtonItem = sender as? UIBarButtonItem
        self.present(activityVC, animated: true, completion: nil)
    }
    
    // MARK: - Save -
    func saveDefaultsData()
    {
        MyAppData.shared.saveDefaultsData()
    }
    
    //MARK: - Cleanup -
    deinit{
        NotificationCenter.default.removeObserver(self)
    }


}

