//
//  FirstViewController.swift
//  ToDo
//
//  Created by Swift on 3/22/16.
//  Copyright © 2016 Swift. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource {
   
    var textFromStorage = ""
    
    @IBOutlet weak var myTable: UITableView!
    
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
     {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            insertedItems.removeAtIndex(indexPath.row)
            myTable.reloadData()
            if let directory: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
                
                let path: String = directory + "/test.txt"
                
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
            }        }
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return insertedItems.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let newCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "newCell")
        newCell.textLabel?.text = insertedItems[indexPath.row]
        return newCell

    }

    override func viewDidAppear(animated: Bool) {
        myTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let directory: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
        
            let path: String = directory + "/test.txt"
            
            //create file manager for checkig files
            let filemanager = NSFileManager.defaultManager()
            if (filemanager.fileExistsAtPath(path)){
        
                // Reading.
                do {
                    textFromStorage = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                    insertedItems = textFromStorage.characters.split{$0 == " " || $0 == "\r\n"}.map(String.init)
                    
                }
                    
                catch {
                    print("Reading the file form internal storage went horribly wrong!")
                }
            }
                
            else{
                print("file doesnt exist")
            }

        }
        else {
            print("Something went wrong whilst finding the directory")
        }
    }
// Do any additional setup after loading the view, typically from a nib.



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

