//
//  MemeViewController.swift
//  MemeMe 2.0
//
//  Created by Leoncio Perez on 4/6/16.
//  Copyright © 2016 Leoncio Perez. All rights reserved.
//

import UIKit

class MemeViewController : UIViewController {
    var meme: Meme!
    @IBOutlet weak var memeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeImage.image = meme.memedImage
    }
    
    //Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "edit" {
            if let _ = segue.destinationViewController as? MemeEditorViewController {
                let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
                applicationDelegate.editMeme = meme
            }
        }
    }
    
    func editMeme() {
        dismissViewControllerAnimated(true, completion: nil)
        performSegueWithIdentifier("edit", sender: self)
    }
    
    func deleteMeme() {
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        applicationDelegate.memes.removeLast()
        navigationController?.popViewControllerAnimated(true)
    }
}
