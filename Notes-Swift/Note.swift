//
//  Note.swift
//  Notes-Swift
//
//  Created by Phillip Ou on 2/21/15.
//  Copyright (c) 2015 Phillip Ou. All rights reserved.
//

import Foundation
import CoreData
@objc(Note)

class Note: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var content: String

}
