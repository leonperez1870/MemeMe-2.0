//
//  MemeTableViewController.swift
//  MemeMe 2.0
//
//  Created by Leoncio Perez on 4/6/16.
//  Copyright © 2016 Leoncio Perez. All rights reserved.
//

import UIKit

class MemeTableViewController : UITableViewController {
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateMemes()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        updateMemes()
        editing = false
        tableView.reloadData()
    }
    
    // Table Views
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath)
        let meme = memes[indexPath.row]
        
        cell.imageView!.image = meme.memedImage
        cell.imageView!.contentMode = .ScaleAspectFit
        cell.textLabel?.text = "  " + meme.topText + "  :  " + meme.bottomText
        cell.detailTextLabel?.text = ""
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let memeViewController = storyboard!.instantiateViewControllerWithIdentifier("MemeViewController") as! MemeViewController
        memeViewController.meme = memes[indexPath.row]
        navigationController!.pushViewController(memeViewController, animated: true)
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let moveItem = memes[fromIndexPath.row]
        memes.removeAtIndex(fromIndexPath.row)
        memes.insert(moveItem, atIndex: toIndexPath.row)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            applicationDelegate.memes.removeAtIndex(indexPath.row)
            memes = applicationDelegate.memes
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    func edit() {
        editing = !editing
    }
    
    func updateMemes() {
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
}

