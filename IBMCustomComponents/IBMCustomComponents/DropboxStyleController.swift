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
        self.sectionTitle = self.loadSectionTitlesFromPlistFile()
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "textCell")
        self.loadRefreshControl()
        if self.tableData == nil || self.tableData?.count <= 0 {
            self.tableView.backgroundView = self.tableBackgroundViewForNoRecords()
            self.tableView.separatorStyle = .None
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "DropBoxStyle View"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if self.tableData?.count > 0 {
            self.tableView.backgroundView = nil
            return 1
        }
        
        return 0
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
        
        self.tableView.separatorStyle = .SingleLine
        self.refreshControl?.endRefreshing()
        
        return tableData
    }
    
    func loadSectionTitlesFromPlistFile() -> [String] {
        var titles: [String] = [String]()
        if let fileContents = self.TableDataContentsFromPList {
            titles = fileContents.allKeys as! [String]
        }
        return titles
    }
    
    // MARK: TableViewBackground - No records
    func tableBackgroundViewForNoRecords() -> UIView {
        let messageLabel = UILabel()
        messageLabel.textColor = UIColor.redColor()
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .Center
        messageLabel.font = UIFont(name: "Helvetica-Bold", size: 20.0)
        messageLabel.text = "No matching records found. Pull to refresh!!!"
        messageLabel.sizeToFit()
        
        return messageLabel
    }
    
    func loadRefreshControl() {
        self.refreshControl = UIRefreshControl()
        if let rfControl = self.refreshControl {
            rfControl.endRefreshing()
            rfControl.tintColor = UIColor.blackColor()
            rfControl.addTarget(self, action: "refreshTableView", forControlEvents: .ValueChanged)
        }

    }
    
    func refreshTableView() {
        let refreshText = "Refresh Data....Last refreshed at \(NSDate())"

        let title = NSAttributedString(string: refreshText, attributes: ["NSForegroundColorAttributeName": [UIColor.whiteColor()]])
        self.refreshControl?.attributedTitle = title
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC))),
            dispatch_get_main_queue()) { () -> Void in
            self.tableData = self .loadDataFromPListFile()
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
}
