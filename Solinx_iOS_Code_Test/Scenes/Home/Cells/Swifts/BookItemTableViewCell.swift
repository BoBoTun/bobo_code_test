//
//  BookItemTableViewCell.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/29/23.
//

import UIKit
import Kingfisher
class BookItemTableViewCell: BaseTableViewCell {

    @IBOutlet weak var imgForword: UIImageView!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgThumb: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setupUI() {
        super.setupUI()
        imgForword.image = UIImage(named: "ic_forword")?.imageWithColor(color: .secondary_color)
    }
    
    func updateCell(book: Book?){
        
        if let bookImg = book?.image {
            imgThumb.kf.setImage(with: URL(string: bookImg))
        }
        self.lblTitle.text = book?.title
        self.lblAuthor.text = book?.authors
    }
    
}
