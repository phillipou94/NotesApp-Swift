//
//  CoreDataRequest.swift
//  Notes-Swift
//
//  Created by Phillip Ou on 2/21/15.
//  Copyright (c) 2015 Phillip Ou. All rights reserved.
//

import UIKit
import CoreData

private let _SomeManagerSharedInstance = CoreDataRequest()

class CoreDataRequest: NSObject {
    
    class var sharedManager: CoreDataRequest {
        return _SomeManagerSharedInstance
    }
    
    func getNotes() ->Array<Note> {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Note")
        
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [Note]
        
        return fetchedResults
        
    }
    
    func saveNote(title:String, content:String) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Note", inManagedObjectContext:managedContext)
        
        let note =  NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
        
        note.setValue(title, forKey:"title")
        note.setValue(content, forKey:"Content")
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        
    }
    
    func updateNote(note:Note,title:String, content:String) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        note.title = title
        note.content = content
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }

    }
    
    func deleteNote(note:Note) {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        context.deleteObject(note as NSManagedObject)
        context.save(nil)
        
        
    }
   
}
