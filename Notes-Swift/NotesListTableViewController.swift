//
//  NotesListTableViewController.swift
//  Notes-Swift
//
//  Created by Phillip Ou on 2/21/15.
//  Copyright (c) 2015 Phillip Ou. All rights reserved.
//

import UIKit
import CoreData


class NotesListTableViewController: UITableViewController {

    var notes :[Note] = [];
    var selectedNote:Note?;
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        notes = CoreDataRequest.sharedManager.getNotes().reverse()
        self.tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return notes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let note = notes[indexPath.row]
        cell.textLabel!.text = note.title

        return cell
    }
    
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("createNotes", sender: self)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedNote = notes[indexPath.row]
        
        self.performSegueWithIdentifier("showNote", sender: self)
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let noteToDelete = notes[indexPath.row]
            notes.removeAtIndex(indexPath.row)
            CoreDataRequest.sharedManager.deleteNote(noteToDelete)
            //tableView.reloadData()
            // remove the deleted item from the `UITableView`
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            
            
           // CoreDataRequest.sharedManager.deleteNote(noteToDelete)
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } 
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = self.tableView.indexPathForSelectedRow()
        
        if(segue.identifier=="showNote") {
            let other:CreateNoteViewController = segue.destinationViewController as CreateNoteViewController
            other.selectedNote=selectedNote
            other.newNote = false
            
            
        }
        
        
    }
    

}
