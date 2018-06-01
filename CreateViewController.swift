//
//  CreateViewController.swift
//  Tiny Countdowns
//
//  Created by Greg Garnhart on 5/28/18.
//  Copyright © 2018 Greg Garnhart. All rights reserved.
//

import Cocoa

class CreateViewController: NSViewController {
    
    // MARK : TODOS
    /*
     
     TODO: Have tab in one text box bring cursor to the next text box
     TODO: Insert '/' in date automatically
     TODO: Reload data in table after creating a new one
     TODO: Delete items...
     
     */
    
    @IBOutlet weak var dateText: NSTextField!
    @IBOutlet weak var titleLabel: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    //will eventually need to limit characters in the date field.
    
    @IBAction func createClicked(_ sender: Any) {
        //check errors, build item, save, reset fields, and return to main screen.
        
        //build item and check erros
        if titleLabel.stringValue != "" && dateText.stringValue != ""{
            if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
                let item = TinyCountdown(context: context)
                item.title = titleLabel.stringValue
                item.date = parseDate(string: dateText.stringValue) //consider a try catch here.
                
            }
            
            titleLabel.stringValue = ""
            dateText.stringValue = ""
            
            //Assuming no issues, save
            (NSApplication.shared.delegate as? AppDelegate)?.saveAction(nil) //save the tasks :)
        }
        
        
        
        //return to main screen
        if let mainWC = view.window?.windowController as? MainWindowController{
            mainWC.moveToMainView()
        }
    }
    
    func parseDate(string: String) -> Date{
        //use DateFormatter! Nice.
        let format = DateFormatter()
        format.dateFormat = "mm/dd/yyyy"
        let returnMe = format.date(from: string)
        return returnMe! //this will inevitably throw an error at some point.
    }
    
    @IBAction func backClicked(_ sender: Any) {
        //return to main screen
        if let mainWC = view.window?.windowController as? MainWindowController{
            mainWC.moveToMainView()
        }
    }
}
