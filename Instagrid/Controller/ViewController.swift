//
//  ViewController.swift
//  Instagrid
//
//  Created by Thomas Bouges on 18-10-22.
//  Copyright © 2018 Thomas Bouges. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    @IBOutlet weak var gridView: GridView!
    @IBOutlet var gridPatternButtons: [UIButton]!
    
    
    
    @IBOutlet weak var topLeftButtonAddImage: UIButton!
    @IBOutlet weak var topRightButtonAddImage: UIButton!
    @IBOutlet weak var botLeftButtonAddImage: UIButton!
    @IBOutlet weak var botRightButtonAddImage: UIButton!
    
    @IBOutlet weak var topLeftImageView: UIImageView!
    @IBOutlet weak var topRightImageView: UIImageView!
    @IBOutlet weak var botLeftImageView: UIImageView!
    @IBOutlet weak var botRightImageView: UIImageView!
    
    let imagePickerController = UIImagePickerController()
    var swipeGesture: UISwipeGestureRecognizer?
  
    var imageInt: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initiate gridView form
        gridView.grid = .twoOne
        
        imagePickerController.delegate = self
        
        
        //swipe left or up
        // URL : https://www.youtube.com/watch?v=BZ_Ke0dYpdw
        
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleShareAction))
       setUpSwipeDirection()
        guard let swipeGesture = swipeGesture else {return}
        
        gridView.addGestureRecognizer(swipeGesture)
       
      ///////
        if (topLeftImageView == nil || botLeftButtonAddImage == nil ||
            gridView.grid == .oneTwo && botRightButtonAddImage == nil || gridView.grid == .twoOne && topRightImageView == nil) {}
        
        
    }
    //Swipe func to share
    @objc func handleShareAction (){
        //let screenWidth = UIScreen.main.bounds.width
       // let screenHeight = UIScreen.main.bounds.height
        
        var translationTransform: CGAffineTransform
        if swipeGesture?.direction == .up {
            print("swipe up")
            translationTransform = CGAffineTransform(translationX: 0, y: -view.frame.height)
        } else {
            print("swipe left")
            translationTransform = CGAffineTransform(translationX: -view.frame.width, y: 0)
        }
        // self uniquement dans les closure et dans les initialisation
        UIView.animate(withDuration: 0.3, animations: {
                    self.gridView.transform = translationTransform
                    }, completion: { (success) in
                        if success {
                            ///////ne marche pas///////
                            if (self.topLeftImageView.image == nil || self.botLeftImageView.image == nil ||
                                ((self.gridView.grid == .oneTwo || self.gridView.grid == .four) && self.botRightImageView.image == nil) || (self.gridView.grid == .twoOne || self.gridView.grid == .four) && self.topRightImageView.image == nil) {
                                
                                let alert = UIAlertController(title: "error Missing Image", message: "Missing picture please add one", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                                self.gridViewReturn()
                            }
                            else {self.sharingGrid()}
                        }
                    })
        
    }
    
    // function in order to share gridView
    // URL : https://www.youtube.com/watch?v=6o4PmMywIA8
    func sharingGrid(){
        /*
        //gridView appear in this place with animation
        gridView.transform = .identity
        // We reduce size of grid view in order to create after thet a zoom effect
        gridView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        //We animate grid view in order it get back to this previous form
        UIView.animate(withDuration: 0.4,  animations: {
        self.gridView.transform = .identity
        }, completion:nil)
        */
        
        guard let imageGrid = gridView.convertToImage() else {return}
        
        let activityViewController = UIActivityViewController(activityItems: [imageGrid], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
        
        // gridView appear after activity activityviewcontroller ended
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            // Return if cancelled
            if (!completed) {
                self.gridViewReturn()
            }

        }
        
        
    }
    
    func gridViewReturn () {
        //gridView appear in this place with animation
        self.gridView.transform = .identity
        // We reduce size of grid view in order to create after thet a zoom effect
        self.gridView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        //We animate grid view in order it get back to this previous form
        UIView.animate(withDuration: 0.4,  animations: {
            self.gridView.transform = .identity
        }, completion:nil)
        
    }
    
    //func portraut vs landscape
    func setUpSwipeDirection (){
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight { //UIDevice.current.orientation.isLandscape
            print("Landscape")
            swipeGesture?.direction = .left } else {
            print("Portrait")
            swipeGesture?.direction = .up
        }
    }
   

    // function to change button and grid
    @IBAction func gridButton(_ sender: UIButton) {
        
        // for each to change button form
        gridPatternButtons.forEach { $0.isSelected = false }
        sender.isSelected = true
        
        // symbolise 1 element de t bouton
        gridPatternButtons.forEach { $0.isSelected = false }
        sender.isSelected = true
        
        switch sender.tag {
        case 0:
            gridView.grid = .oneTwo
        case 1:
            gridView.grid = .twoOne
        case 2:
            gridView.grid = .four
        default:
            break
        }
    }
    
    //function to add image
    @IBAction func addImage(_ sender: UIButton) {
       imageInt = sender.tag
        addAction()
     }
    
    //function to button+ appear with tap on photo of ImageView
    @objc func tapImageView (recogniser: UITapGestureRecognizer) {
        // UiImage sous class Uiview
        imageInt = recogniser.view?.tag
        addAction()
    }
    
     private func addAction () {
        // func URL https://www.youtube.com/watch?v=4CbcMZOSmEk
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Photo Gallery", style: .default,
                                            handler: {(action:UIAlertAction) in self.imagePickerController.sourceType = .photoLibrary
                                            self.present(self.imagePickerController, animated: true, completion: nil)
                                            }))
        //bonus camera
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default,
                                            handler: {(action:UIAlertAction) in
                                                if UIImagePickerController.isSourceTypeAvailable(.camera){
                                                    self.imagePickerController.sourceType = .camera
                                                    self.present(self.imagePickerController, animated: true, completion: nil)
                                                }else{
                                                    let alertCamera = UIAlertController(title: "error Missing Image", message: "Missing picture please add one", preferredStyle: UIAlertController.Style.alert)
                                                    alertCamera.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                                    self.present(alertCamera, animated: true, completion: nil)
                                                    
                                                }
                                               
        }))
        
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
    
        self.present(actionSheet,animated: true,completion: nil)
        
    }
    
    // function pour aller chercher image dans la library
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        // a revoir
        guard let tag = imageInt else { return }
        let imageViews = [topLeftImageView,topRightImageView,botLeftImageView,botRightImageView]
        let buttons = [topLeftButtonAddImage,topRightButtonAddImage,botLeftButtonAddImage,botRightButtonAddImage]
        
        let imageView = imageViews[tag]
        let button = buttons[tag]
        //add image
        imageView?.image = image
        
        // Button +
        button?.isHidden = true
        
        // initialisation of tapGesture on ImageView
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImageView(recogniser:)))
        imageView?.addGestureRecognizer(tapGestureRecognizer)
        //////// gesture sur cette photo voir si on en créé une autre ou pas si oui evité car ce repete si on clique sur photo

        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // a voir changer par notify pblm setup swipe
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setUpSwipeDirection()
    }
    
  
}

