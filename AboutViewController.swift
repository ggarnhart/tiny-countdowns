//
//  AboutViewController.swift
//  Tiny Countdowns
//
//  Created by Greg Garnhart on 5/28/18.
//  Copyright © 2018 Greg Garnhart. All rights reserved.
//

import Cocoa

class AboutViewController: NSViewController {
    
    var countDownItems : [TinyCountdown] = []
    var index : Int = 0
    
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var dateLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCountdowns()
        // Do view setup here.
    }
    
    func getCountdowns(){
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            do {
                countDownItems = try context.fetch(TinyCountdown.fetchRequest()) // this works.
            }
            catch {
                print("error fethcing items")
            }
        }
    }
    
    @IBAction func backClicked(_ sender: Any) {
        if let mainWC = view.window?.windowController as? MainWindowController{
            mainWC.moveToMainView()
        }
    }
    
    @IBAction func editClicked(_ sender: Any) {
        
    }
    
    @IBAction func archiveClicked(_ sender: Any) {
        if index >= 0 {
            let selectedItem = countDownItems[index]
            
            if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
                
                context.delete(selectedItem)
                (NSApplication.shared.delegate as? AppDelegate)?.saveAction(nil)
            }
            
            if let mainWC = view.window?.windowController as? MainWindowController{
                
                mainWC.moveToMainView()
            }
        }
        else {
            print("index was found to be less than 0")
        }

    }
}


