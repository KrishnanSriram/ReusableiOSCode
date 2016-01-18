//
//  LogonViewController.swift
//  IBMCustomComponents
//
//  Created by Krishnan Sriram Rama on 1/11/16.
//  Copyright © 2016 Krishnan Sriram Rama. All rights reserved.
//

import UIKit

class LogonViewController: UITableViewController, TwoButtonCellDelegate {
    
    enum LogonViewCellEnum: Int {
        case LogonViewCellUserName = 0, LogonViewCellPassword = 1, LogonViewCellButtons = 2
        
        static let labelTexts = ["UserName", "Password", ["Login", "Clear"]]
        static let placeholderTexts = ["Enter username", "Enter password"]
        
        func cellData() -> (String, String) {
            let lblText: String!
            let plText: String!
            
            switch self {
            case LogonViewCellUserName:
                lblText = LogonViewCellEnum.labelTexts[0] as! String
                plText = LogonViewCellEnum.placeholderTexts[0]
            case .LogonViewCellPassword:
                lblText = LogonViewCellEnum.labelTexts[1] as! String
                plText = LogonViewCellEnum.placeholderTexts[1]
            case LogonViewCellButtons:
                let buttonCaptionArray = LogonViewCellEnum.labelTexts[2] as! Array<String>
                lblText = buttonCaptionArray[0]
                plText = buttonCaptionArray[1]
            }
            
            return (lblText, plText)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableHeaderView = self.createTableHeaderview()
        let textFieldCellNib = UINib(nibName: "TextFieldCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(textFieldCellNib, forCellReuseIdentifier: "TextFieldCell")
        
        let twoButtonCellNib = UINib(nibName: "TwoButtonCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(twoButtonCellNib, forCellReuseIdentifier: "TwoButtonCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextFieldCell") as! TextFieldCell
        
        switch(indexPath.row) {
        case LogonViewCellEnum.LogonViewCellUserName.rawValue:
            return self.textFieldCellFor(tableView: tableView, atIndex: indexPath.row)
        case LogonViewCellEnum.LogonViewCellPassword.rawValue:
            return self.textFieldCellFor(tableView: tableView, atIndex: indexPath.row)
        case LogonViewCellEnum.LogonViewCellButtons.rawValue:
            return self.twoButtonCell(tableView: tableView, atIndex: indexPath.row)
            
        default:
           break
        }

        
        return cell
    }
    
    //MARK: TableheaderView
    func createTableHeaderview() -> UIView {
        let headerView = UIView(frame: CGRectMake(0,0, 0, 130))
        headerView.backgroundColor = UIColor.whiteColor()
        
        let label = UILabel()
        label.text = "IBM Navigator"
        label.textAlignment = .Center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica-Bold", size: 42.0)
        headerView.addSubview(label)
        
        let headerViewDictionary = ["label":label]
        headerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[label]-|",
            options: .AlignAllBaseline, metrics: nil, views: headerViewDictionary))
        headerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[label(50)]",
            options: .AlignAllBaseline, metrics: nil, views: headerViewDictionary))
        
        return headerView
    }
    
    
    //MARK: Tableview Cell customization
    func textFieldCellFor(tableView tableView:UITableView, atIndex:Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextFieldCell") as! TextFieldCell
        let (lblText, plText) = LogonViewCellEnum(rawValue: atIndex)!.cellData()
        
        cell.label.text = lblText
        cell.textField.placeholder = plText
        
        return cell
    }
    
    func twoButtonCell(tableView tableView:UITableView, atIndex:Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TwoButtonCell") as! TwoButtonCell
        let (btn1Text, btn2Text) = LogonViewCellEnum(rawValue: atIndex)!.cellData()
        
        cell.leftButton.setTitle(btn1Text, forState: .Normal)
        cell.leftSuccessButton = true
        cell.rightButton.setTitle(btn2Text, forState: .Normal)
        cell.twoButtonCellDelegate = self
        return cell
    }
    
    // MARK: Button delegates
    func leftButtonTapped() {
        self.performSegueWithIdentifier("home", sender: self)
    }
    
    func rightButtonTapped() {
        
    }
    
    //MARK: UIKit dynamics for UITableView on successful Login

}
