//
//  WordBank.swift
//  Word-O-Rama
//
//  Created by Luke Schwarting on 3/1/17.
//  Copyright © 2017 Luke Schwarting. All rights reserved.
//

import Foundation
import UIKit

class WordBank //setting the model of word bank lists
{
    //ivars
    var name: String
    var value: Array<String>
    
    //init
    init(name:String,value:Array<String>) {
        self.name = name
        self.value = value
    }
}
