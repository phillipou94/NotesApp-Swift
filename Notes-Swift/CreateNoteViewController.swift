//
//  CreateNoteViewController.swift
//  Notes-Swift
//
//  Created by Phillip Ou on 2/21/15.
//  Copyright (c) 2015 Phillip Ou. All rights reserved.
//

import UIKit

class CreateNoteViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    @IBOutlet var textField: UITextField!
    var newNote = true
    var selectedNote:Note?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !newNote{
            textView.text =  selectedNote!.content
            textField.text = selectedNote!.title
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if newNote {
            CoreDataRequest.sharedManager.saveNote(textField.text,content: textView.text)
        } else {
            CoreDataRequest.sharedManager.updateNote(selectedNote!, title: textField.text, content: textView.text)
        }
        
    }
    

}
