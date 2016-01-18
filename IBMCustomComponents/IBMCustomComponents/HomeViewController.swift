//
//  HomeViewController.swift
//  IBMCustomComponents
//
//  Created by Krishnan Sriram Rama on 1/11/16.
//  Copyright © 2016 Krishnan Sriram Rama. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    private var _prototypeChoices: NSDictionary?
    
    private var prototypeChoices: NSDictionary {
        get {
            if let _ = self._prototypeChoices {
                return _prototypeChoices!
            } else {
                _prototypeChoices = NSDictionary()
            }
            
            return _prototypeChoices!
        }
        set {
            _prototypeChoices = newValue
        }
    }
    
    private var prototypeChoiceArray: [String] {
        get {
            return self.prototypeChoices.allValues as! [String]
        }
    }
    
    private var prototypeChoiceDescriptionArray: [String] {
        get {
            return self.prototypeChoices.allKeys as! [String]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "TextCell")
        self.prototypeChoices = self.loadDataFromPListFile()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Home View"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.prototypeChoices.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.prototypeChoiceDescriptionArray[section]
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tableView.numberOfSections/2)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.prototypeChoiceArray[indexPath.section]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .ByWordWrapping
        
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("StylesVC", sender: self)
    }
    
    //MARK: - Segue methods
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = self.tableView.indexPathForSelectedRow!
        let targetViewController: CustomsCellViewController = segue.destinationViewController as! CustomsCellViewController
        
        switch(indexPath.section) {
        case 0:
            targetViewController.cellStyleViewController = .CellStyleViewControllerDropBox
        case 1:
            targetViewController.cellStyleViewController = .CellStyleViewControllerOneDrive
        default:
            break
        }
    }
    
    //MARK: Private methods
    private var PListFilePath: String? {
        get {
            return NSBundle.mainBundle().pathForResource("TableData", ofType: "plist")
        }
    }
    
    private var TableDataContentsFromPList: NSDictionary? {
        get {
            if let filePath = self.PListFilePath {
                return NSDictionary(contentsOfFile: filePath)
            }
            
            return nil
        }
    }
    
    
    //MARK: Load tableview data
    func loadDataFromPListFile() -> NSDictionary {
        var tableData: NSDictionary = NSDictionary()
        if let fileContents = self.TableDataContentsFromPList {
            tableData = fileContents.valueForKey("Approach") as! NSDictionary
        }
        
        return tableData
    }
    
    func loadSectionTitlesFromPlistFile() -> [String] {
        var titles: [String] = [String]()
        if let fileContents = self.TableDataContentsFromPList {
            titles = fileContents.allKeys as! [String]
        }
        return titles
    }

}
