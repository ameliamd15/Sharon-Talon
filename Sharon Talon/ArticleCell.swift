//
//  ArticleCell.swift
//  Sharon Talon
//
//  Created by Cyril Dasari on 12/10/20.
//

import UIKit
import Alamofire
import AlamofireImage

class ArticleCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var authorNDate: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
