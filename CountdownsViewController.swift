//
//  ViewController.swift
//  Tiny Countdowns
//
//  Created by Greg Garnhart on 5/28/18.
//  Copyright © 2018 Greg Garnhart. All rights reserved.
//

import Cocoa

class CountdownsViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    var countDownItems : [TinyCountdown] = []
    
    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCountdowns() // might as well do this everytime, but consider doing it before the view loads.
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func addCountdownClicked(_ sender: Any) {
        if let mainWC = view.window?.windowController as? MainWindowController{
            mainWC.moveToCreateView()
        }
    }
    
    func getCountdowns(){
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            do {
                countDownItems = try context.fetch(TinyCountdown.fetchRequest()) // this works.
//                print(countDownItems.count)
            }
            catch {
                print("error, yo")
            }
        }
        tableView.reloadData()  
    }
    
    // MARK: Table View Things
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return countDownItems.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let item = countDownItems[row]
        
        if (tableColumn?.identifier)!.rawValue == "titleColumn" {
            
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "titleCell"), owner: self) as? NSTableCellView{
                
                cell.textField?.stringValue = item.title!
                
                
                return cell
            }
            
        } else {
            
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "dateCell"), owner: self) as? NSTableCellView{
                
                let timeLeftObject = timeLeft(date: item.date!)
                
                //should check which time value the user has designated (e.g. seconds, minutes, hours, or "smart")
                //default will be days, though.
                
                var stringValue = ""
                if(timeLeftObject.days != 1){
                    stringValue = String(timeLeftObject.days) + " Days"
                } else {
                    stringValue = String(timeLeftObject.days) + " Day"
                }
                
                cell.textField?.stringValue = stringValue
                
                return cell
            }
            
        }
        
        return nil
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        if tableView.selectedRow >= 0 {
            let item = countDownItems[tableView.selectedRow]
            
            if let mainWC = view.window?.windowController as? MainWindowController{
                mainWC.moveToAboutView(item: item, index: tableView.selectedRow)
            }
            
        }
    }
    
    func timeLeft(date: Date) -> timeRemainingInformation{
        
        //seconds in a day: 86400
        //fix this !
        
        let seconds = date.timeIntervalSinceNow
        var time = timeRemainingInformation()
        time.seconds = Int(seconds)
        
        //minutes
        time.minutes = Int(seconds/60)
        
        //hours
        time.hours = (time.minutes)/60
        
        //days
        time.days = (time.hours)/24
        
        
        return time
    }
    
    struct timeRemainingInformation {
        var seconds : Int = 0
        var minutes : Int = 0
        var hours   : Int = 0
        var days    : Int = 0
    }
}

