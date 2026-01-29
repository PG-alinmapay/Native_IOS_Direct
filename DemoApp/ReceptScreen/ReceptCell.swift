//
//  ReceptCell.swift
//  
//

import UIKit

class ReceptCell: UITableViewCell {

    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet weak var labelvalue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setTitle(title: String , valuee : String) {
        self.titleLabel.text = title
        self.labelvalue.text = valuee
    }
    
}
