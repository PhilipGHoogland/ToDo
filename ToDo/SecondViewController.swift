//
//  SecondViewController.swift
//  ToDo
//
//  Created by Swift on 3/22/16.
//  Copyright © 2016 Swift. All rights reserved.
//

import UIKit

// array with items passable globally
var insertedItems = ["Empty"]

class SecondViewController: UIViewController {

    @IBOutlet weak var insertTextField: UITextField!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        // check if value is usable
        if insertTextField.text?.characters.count > 0{
            // add value to array with items
            insertedItems.append(insertTextField.text!)
            //reset text field
            insertTextField.text = ""
            // tell the progam that we ended editing
            self.view.endEditing(true)
            if let directory: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
                
                let path: String = directory + "test.txt"
                
                // initializing file that will be stored
                print(insertedItems)
                
                let textToStorage = insertedItems.joinWithSeparator(" ")
                
                
                
                // Writing.
                do {
                    try textToStorage.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding)
                }
                catch {
                    print("Something went wrong whilst writing to the storage!")
                }
                
            }
            else {
                print("something went wrong whilst accesing the directory!")
                 }
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

