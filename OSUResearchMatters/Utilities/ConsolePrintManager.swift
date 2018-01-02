//
//  ConsolePrintManager.swift
//  OSUResearchMatters
//
//  Created by App Center on 12/28/17.
//  Copyright © 2017 Oklahoma State University. All rights reserved.
//

import Foundation

class CPM {
    func write(text: String) {
        print("*-------------------------*")
        print("> ", text)
        print("*-------------------------*")
    }
    
    func write(text1: String, text2: String) {
        print("*-------------------------*")
        print("> ", text1)
        print("> ", text2)
        print("*-------------------------*")
    }
}
