//
//  NotesCell.swift
//  BeBetter
//
//  Created by Ana Carolina Cabral on 29/07/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell {
    @IBOutlet weak var exerciseNameLabel: UILabel!

    @IBOutlet weak var noteLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
