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
    
    @IBOutlet weak var topLeftImage: UIImageView!
    @IBOutlet weak var topRightImage: UIImageView!
    @IBOutlet weak var botLeftImage: UIImageView!
    @IBOutlet weak var botRightImage: UIImageView!
    
    let imagePickerController = UIImagePickerController()
    
    var imageInt: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridView.grid = .twoOne
        imagePickerController.delegate = self
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
        let imageViews = [topLeftImage,topRightImage,botLeftImage,botRightImage]
        let buttons = [topLeftButtonAddImage,topRightButtonAddImage,botLeftButtonAddImage,botRightButtonAddImage]
        
        let imageView = imageViews[tag]
        let button = buttons[tag]
        imageView?.image = image
        button?.isHidden = true

        picker.dismiss(animated: true, completion: nil)
        }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

