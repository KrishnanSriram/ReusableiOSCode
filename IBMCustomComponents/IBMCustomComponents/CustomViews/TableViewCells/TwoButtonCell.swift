//
//  TwoButtonCell.swift
//  IBMCustomComponents
//
//  Created by Krishnan Sriram Rama on 1/11/16.
//  Copyright © 2016 Krishnan Sriram Rama. All rights reserved.
//

import UIKit

protocol TwoButtonCellDelegate {
    func leftButtonTapped()
    func rightButtonTapped()
}

class TwoButtonCell: UITableViewCell {

    @IBOutlet var leftButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    
    private var _leftSuccessButton: Bool!
    private var _rightSuccessButton: Bool!
    private let buttonCornerRadius:CGFloat = 4.0
    var twoButtonCellDelegate: TwoButtonCellDelegate?
    
    var leftSuccessButton: Bool {
        get {
            return _leftSuccessButton
        }
        set {
            _leftSuccessButton = newValue
            if newValue == true {
                self.leftButton.backgroundColor = UIColor.blueColor()
            } else {
                self.leftButton.backgroundColor = UIColor.redColor()
            }
        }
    }
    
    var rightSuccessButton: Bool {
        get {
            return _rightSuccessButton
        }
        set {
            _rightSuccessButton = newValue
            if newValue == true {
                self.rightButton.backgroundColor = UIColor.blueColor()
            } else {
                self.rightButton.backgroundColor = UIColor.redColor()
            }
        }
    }
    
    private let titleColor = UIColor.whiteColor()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.leftSuccessButton = false
        self.rightSuccessButton = false
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Action methods
    @IBAction func leftButtonTouched(sender: UIButton) {
        self.twoButtonCellDelegate?.leftButtonTapped()
    }
    
    @IBAction func rightButtonTouched(sender: UIButton) {
        self.twoButtonCellDelegate?.rightButtonTapped()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.leftButton.setTitleColor(self.titleColor, forState: .Normal)
        self.rightButton.setTitleColor(self.titleColor, forState: .Normal)
        
        self.leftButton.layer.cornerRadius = buttonCornerRadius
        self.rightButton.layer.cornerRadius = buttonCornerRadius
    }
    
    
}
