//
//  ArticleCell.swift
//  Sharon Talon
//
//  Created by Amelia Dasari on 12/10/20.
//

import UIKit
import Alamofire
import AlamofireImage

class ArticleCell: UITableViewCell {

    //@IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var authorNDate: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var categories: UILabel!
    @IBOutlet weak var title: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //imgView.contentMode = .scaleAspectFit;
        //self.backgroundColor = UIColor.yellow;
        //title.sizeToFit();
        imgView.layer.cornerRadius = 10;
        imgView.clipsToBounds = true
        imgView.layer.borderWidth = 1
        imgView.layer.borderColor = UIColor.white.cgColor;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
