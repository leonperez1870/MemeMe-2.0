//
//  MemeCollectionViewController.swift
//  MemeMe 2.0
//
//  Created by Leoncio Perez on 4/6/16.
//  Copyright © 2016 Leoncio Perez. All rights reserved.
//

import UIKit

class MemeCollectionViewController : UICollectionViewController {
    var memes: [Meme]!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var editButton: UIButton!
    @IBAction func editButton(sender: AnyObject) {
        edit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space: CGFloat = 5.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(100, 100)
        updateMemes()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        updateMemes()
        collectionView?.reloadData()
        if (memes.count == 0) {
            editButton.hidden = true
        } else {
            editButton.hidden = false
        }
    }
    
    //Begin Collections
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        if (editing) {
            cell.deleteLabel.hidden = false
        } else {
            cell.deleteLabel.hidden = true
        }
        cell.memeImageView?.image = meme.memedImage
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath) {
        if (editing) {
            let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            applicationDelegate.memes.removeAtIndex(indexPath.item)
            memes.removeAtIndex(indexPath.item)
            applicationDelegate.memes = memes
            self.collectionView?.reloadData()
        } else if (!editing) {
            let memeViewController = storyboard!.instantiateViewControllerWithIdentifier("MemeViewController") as! MemeViewController
            memeViewController.meme = memes[indexPath.row]
            navigationController!.pushViewController(memeViewController, animated: true)
        }
    }
    
    func edit() {
        editing = !editing
        collectionView?.reloadData()
    }
    
    func updateMemes() {
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
}
