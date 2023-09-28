//
//  BookDetailViewController.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/29/23.
//

import UIKit
import Kingfisher
class BookDetailViewController: BaseViewController {

    @IBOutlet weak var lblBookLink: UILabel!
    @IBOutlet weak var lblAuthors: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblBookTitle: UILabel!
    @IBOutlet weak var lblBookID: UILabel!
    @IBOutlet weak var imgBook: UIImageView!
    var book : Book?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupUI() {
        super.setupUI()
        showNavigationBar()
        addBackButton(color: UIColor.secondary_color, image: UIImage(named: "ic_back_arrow")?.imageWithColor(color: UIColor.secondary_color) ?? UIImage(), backgroundColor: UIColor.clear)
        setupNavigationTitle(title: "Book Detail")
        
        imgBook.kf.setImage(with: URL(string: book?.image ?? ""))
        lblBookID.text = book?.id
        lblBookTitle.text = book?.title
        lblSubTitle.text = book?.subtitle
        lblAuthors.text = book?.authors
        //lblBookLink.text = book?.url
        self.setupClickableLabel()
        
    }
    
    func setupClickableLabel(){
               lblBookLink.isUserInteractionEnabled = true
               
        let attributedText = NSMutableAttributedString(string: book?.url ?? "")
               let linkRange = NSRange(location: 0, length: attributedText.length)
               let linkAttributes: [NSAttributedString.Key: Any] = [
                   .link: URL(string: book?.url ?? "")!,
                   .foregroundColor: UIColor.blue,
                   .underlineStyle: NSUnderlineStyle.single.rawValue
               ]
               attributedText.addAttributes(linkAttributes, range: linkRange)
               
               // Set the attributed text on the label
        lblBookLink.attributedText = attributedText
               
               // Add a tap gesture recognizer
               let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        lblBookLink.addGestureRecognizer(tapGesture)
    }

    @objc func labelTapped(_ gesture: UITapGestureRecognizer) {
        UIApplication.shared.open(URL(string: book?.url ?? "")!)
        
        }

}
