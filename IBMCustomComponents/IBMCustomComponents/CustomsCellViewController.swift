//
//  CustomsCellTableViewController.swift
//  IBMCustomComponents
//
//  Created by Krishnan Sriram Rama on 1/13/16.
//  Copyright © 2016 Krishnan Sriram Rama. All rights reserved.
//

import UIKit

enum CellStyleViewController{
    case CellStyleViewControllerOneDrive, CellStyleViewControllerDropBox
}

class CustomsCellViewController: UIViewController {
    
    var cellStyleViewController: CellStyleViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if cellStyleViewController == .CellStyleViewControllerOneDrive {
            self.title = "Push style cell example"
        } else if cellStyleViewController == .CellStyleViewControllerDropBox {
            self.title = "Dropbox style cell"
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let childVC = self.childViewController(self.cellStyleViewController)
        self.addChildViewController(childVC)
        let childView: UIView = childVC.view
        childView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(childView)
        
        let viewDictionary = ["childView":childView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[childView]-0-|",
            options: .AlignAllBaseline, metrics: nil, views: viewDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-1-[childView]-0-|",
            options: .AlignAllBaseline, metrics: nil, views: viewDictionary))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Private methods
    func childViewController(forCellStyle:CellStyleViewController) -> UITableViewController {
        var tableViewController: UITableViewController!
        switch(forCellStyle) {
        case .CellStyleViewControllerDropBox:
            tableViewController = DropboxStyleController()
        case .CellStyleViewControllerOneDrive:
            tableViewController = OneDriveViewController(style:.Grouped)
        }
        
        return tableViewController
    }

}
