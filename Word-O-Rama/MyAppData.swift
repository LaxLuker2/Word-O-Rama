//
//  MyAppData.swift
//  Word-O-Rama
//
//  Created by Luke Schwarting on 3/25/17.
//  Copyright © 2017 Luke Schwarting. All rights reserved.
//

import Foundation

class MyAppData //word bank saving
{
    static let shared = MyAppData()
    var wordBankUsing = ["Choose a", "Word List"]
    let wordKey = "wordKey"
    
    private init()
    {
        print("Created MyAppData instance")
        readDefaultsData()
    }
    
    private func readDefaultsData()
    {
        let defaults = UserDefaults.standard
        if let _ = defaults.object(forKey: wordKey)
        {
            wordBankUsing = defaults.stringArray(forKey: wordKey) ?? [String]()
        }
        else
        {
            wordBankUsing = ["Choose a", "Word List"]
        }
    }
    
    public func saveDefaultsData()
    {
        print("Saving to defaults")
        let defaults = UserDefaults.standard
        defaults.set(wordBankUsing, forKey: wordKey)
        defaults.synchronize()
    }
}
