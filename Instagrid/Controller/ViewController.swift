//
//  ViewController.swift
//  Instagrid
//
//  Created by Thomas Bouges on 18-10-22.
//  Copyright © 2018 Thomas Bouges. All rights reserved.
//

import UIKit

class ViewController: UIViewController/*, UIImagePickerControllerDelegate, UINavigationControllerDelegate */{
 
    @IBOutlet weak var gridView: GridView!
    @IBOutlet var gridPatternButtons: [UIButton]!
    //nom func puis terminer type
    @IBOutlet weak var topLeftAddButton: UIButton!
    @IBOutlet weak var topRightAddButton: UIButton!
    @IBOutlet weak var botLeftAddButton: UIButton!
    @IBOutlet weak var botRightAddButton: UIButton!
    
    @IBOutlet weak var topLeftUIImageView: UIImageView!
    @IBOutlet weak var topRightUIImageView: UIImageView!
    @IBOutlet weak var botLeftUIImageView: UIImageView!
    @IBOutlet weak var botRightUIImageView: UIImageView!
    
    let imagePickerController = UIImagePickerController()
    var swipeGesture: UISwipeGestureRecognizer?
    var imageInt: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initiate gridView form
        gridView.grid = .twoOne
        imagePickerController.delegate = self
        //swipe left or up
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleShareAction))
        guard let swipeGesture = swipeGesture else {return}
        gridView.addGestureRecognizer(swipeGesture)
       // observer for orientation
        NotificationCenter.default.addObserver(self, selector: #selector(setUpSwipeDirection), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    //func portrait vs landscape
    @objc func setUpSwipeDirection (){
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            print("Landscape")// a enlever
            swipeGesture?.direction = .left } else {
            print("Portrait")
            swipeGesture?.direction = .up
        }
    }
    
    //func Swipe to share
    @objc func handleShareAction (){
        var translationTransform: CGAffineTransform
        if swipeGesture?.direction == .up {
            print("swipe up")
            translationTransform = CGAffineTransform(translationX: 0, y: -view.frame.height)
        } else {
            print("swipe left")
            translationTransform = CGAffineTransform(translationX: -view.frame.width, y: 0)
        }
        // self uniquement dans les closures et dans les initialisations
        UIView.animate(withDuration: 0.3, animations: {
                    self.gridView.transform = translationTransform
                    }, completion: { (success) in
                        if success { // faire fonction
                            
                            // si is ... return true
                            if self.gridView.isAvailableToShare() {
                                self.sharingGrid()
                            }else {
                                let alert = UIAlertController(title: "Error Missing Image", message: "Missing picture please add one", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                                self.gridViewReturn()
                            }
                        }
                    })
    }
    
    // function in order to share gridView
    // URL : https://www.youtube.com/watch?v=6o4PmMywIA8
    func sharingGrid(){
        guard let imageGrid = gridView.convertToImage() else {return}
        let activityViewController = UIActivityViewController(activityItems: [imageGrid], applicationActivities: nil)
        present(activityViewController, animated: true, completion: {})
        // gridView appear after activity activityviewcontroller ended
        // _ permet de ne pas utiliser les variables demandées
        activityViewController.completionWithItemsHandler = {_, _, _, _ in
            // Return if cancelled
           self.gridViewReturn()
        }
     }
    
    // function for animate gridView return after a swipe
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
    
    
    /*Correct mais le view willtransfert ne prends pas en compte le mode landscape en mode landscape , mieux vaux utiliser notice Observer
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setUpSwipeDirection()
    }*/
    }

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
                                                    //error alert message
                                                    let alertCamera = UIAlertController(title: "Error No Camera available", message: "Camera not found", preferredStyle: UIAlertController.Style.alert)
                                                    alertCamera.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                                    self.present(alertCamera, animated: true, completion: nil)
                                                }
        }))
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        self.present(actionSheet,animated: true,completion: nil)
    }
    
    // function to add picture from Library
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        // a revoir
        guard let tag = imageInt else { return }
        let imageViews = [topLeftUIImageView,topRightUIImageView,botLeftUIImageView,botRightUIImageView]
        let buttons = [topLeftAddButton,topRightAddButton,botLeftAddButton,botRightAddButton]
        let imageView = imageViews[tag]
        guard let button = buttons[tag] else { return } //****
        imageView?.image = image
        //If in order to do not have multiple tapGesture on image
        //!button ! avant ca veut dure le contraire *****
        if !button.isHidden {
            // Button +
            button.isHidden = true
            // initialisation of tapGesture on ImageView
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImageView(recogniser:)))
            imageView?.addGestureRecognizer(tapGestureRecognizer)
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}


