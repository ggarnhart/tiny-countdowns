//
//  MainWindowController.swift
//  Tiny Countdowns
//
//  Created by Greg Garnhart on 5/28/18.
//  Copyright © 2018 Greg Garnhart. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    var mainVC : CountdownsViewController?
    var createVC : CreateViewController?
    var aboutVC : AboutViewController?

    override func windowDidLoad() {
        super.windowDidLoad()
        
        window?.appearance = NSAppearance(named:NSAppearance.Name.vibrantDark) //makes window black themed ;)
        
        mainVC = contentViewController as? CountdownsViewController
    
    }
    
    func moveToCreateView(){
        if createVC == nil{
            createVC = storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "createVC")) as? CreateViewController
        }
        window?.contentView = createVC?.view
    }
    
    func moveToAboutView(){
        if aboutVC == nil{
            aboutVC = storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "aboutVC")) as? AboutViewController
        }
        window?.contentView = aboutVC?.view
    }
    
    func moveToAboutView(item: TinyCountdown, index: Int){
        if aboutVC == nil{
            aboutVC = storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "aboutVC")) as? AboutViewController
        }
        
        window?.contentView = aboutVC?.view
        
        if item.title != nil{
            aboutVC?.titleLabel.stringValue = item.title!
        }
        
        if item.date != nil{
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            dateFormatter.locale = Locale(identifier: "en_US")
            aboutVC?.dateLabel.stringValue = dateFormatter.string(from: item.date!)
        }
        
        if index > -1 {
            aboutVC?.index = index
        }
    }
    
    func moveToMainView(){
        mainVC?.getCountdowns()
        mainVC?.tableView.reloadData()     //reloads table 
        window?.contentView = mainVC?.view
    }

}
