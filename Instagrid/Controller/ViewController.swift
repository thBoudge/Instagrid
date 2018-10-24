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
    
    var imageInt: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initiate gridView form
        gridView.grid = .twoOne
        
        imagePickerController.delegate = self
        
        //tapGesture for + button
        //-----------------------------------------------------------------------------------------
        let tapTopLeftImageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapTopLeftImage(recigniser:)))
        let tapTopRightImageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapTopRightImage(recigniser:)))
        let tapBotLeftImageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapBotLeftImage(recigniser:)))
        let tapBotRightImageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapBotRightImage(recigniser:)))
        
        tapTopLeftImageGestureRecognizer.numberOfTapsRequired = 1
        
        //.isUserInteractionEnabled = false
        topLeftImageView.isUserInteractionEnabled = false
        topRightImageView.isUserInteractionEnabled = false
        botLeftButtonAddImage.isUserInteractionEnabled = false
        botRightImageView.isUserInteractionEnabled = false
        
        topLeftImageView.addGestureRecognizer(tapTopLeftImageGestureRecognizer)
        topRightImageView.addGestureRecognizer(tapTopRightImageGestureRecognizer)
        botLeftButtonAddImage.addGestureRecognizer(tapBotLeftImageGestureRecognizer)
        botRightImageView.addGestureRecognizer(tapBotRightImageGestureRecognizer)
        //------------------------------------------------------------------------------------------
    
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
    @objc func tapTopLeftImage (recigniser: UITapGestureRecognizer) {
        
        topLeftButtonAddImage.isHidden = false
        topLeftImageView.isUserInteractionEnabled = false
    }
    
    @objc func tapTopRightImage (recigniser: UITapGestureRecognizer) {
        
        topRightButtonAddImage.isHidden = false
        topRightImageView.isUserInteractionEnabled = false
    }
    @objc func tapBotLeftImage (recigniser: UITapGestureRecognizer) {
        
        botLeftButtonAddImage.isHidden = false
        botLeftImageView.isUserInteractionEnabled = false
    }
    
    @objc func tapBotRightImage (recigniser: UITapGestureRecognizer) {
        
        botRightButtonAddImage.isHidden = false
        botRightImageView.isUserInteractionEnabled = false
    }
    
    
    private func addAction () {
        
        // func URL https://www.youtube.com/watch?v=4CbcMZOSmEk
        
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        
        actionSheet.addAction(UIAlertAction(title: "Photo Gallery", style: .default,
                                            handler: {(action:UIAlertAction) in self.imagePickerController.sourceType = .photoLibrary
                                            self.present(self.imagePickerController, animated: true, completion: nil)
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
        // isUserInteractionEnabled = true for this image
        imageView?.isUserInteractionEnabled = true
        // Button +
        button?.isHidden = true
        

        picker.dismiss(animated: true, completion: nil)
        }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}

