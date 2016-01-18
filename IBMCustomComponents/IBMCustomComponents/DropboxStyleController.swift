//
//  DropboxStyleController.swift
//  IBMCustomComponents
//
//  Created by Krishnan Sriram Rama on 1/11/16.
//  Copyright © 2016 Krishnan Sriram Rama. All rights reserved.
//

import UIKit

class DropboxStyleController: UITableViewController {
        
    var tableData:[String]?
    var sectionTitle:[String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableData = self .loadDataFromPListFile()
        self.sectionTitle = self.loadSectionTitlesFromPlistFile()
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "textCell")
        
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
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.tableData?.count)!
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "UIViewController - DropBoxStyle"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("textCell", forIndexPath: indexPath)
        
        // Configure the cell...
        var cellText: String = (self.tableData?[indexPath.row])!
        
        if cellText.characters.count > 37 {
            let rangeIndex = cellText.startIndex.advancedBy(37)
            cellText = cellText.substringToIndex(rangeIndex)
            cellText.appendContentsOf("...")
        }
        
        cell.textLabel?.text = cellText
        return cell
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
    func loadDataFromPListFile() -> [String] {
        var tableData: [String] = [String]()
        if let fileContents = self.TableDataContentsFromPList {
            tableData = fileContents.valueForKey("UIViewController") as! [String]
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
