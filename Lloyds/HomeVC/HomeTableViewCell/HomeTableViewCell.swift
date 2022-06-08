//
//  HomeTableViewCell.swift
//  Lloyds
//
//  Created by Mahesh Varadaraj on 09/06/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var labelSource: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateTableViewCell(data: NewsVM) {
        labelSource.text = data.source
        labelDate.text = data.date
        labelDescription.text = data.subTitle
        labelTitle.text = data.title

    }
}
