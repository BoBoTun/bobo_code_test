//
//  BaseTableViewCell.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/27/23.
//

import UIKit
import Combine

class BaseTableViewCell : UITableViewCell {
    
    var bindings = Set<AnyCancellable>()

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupUI()
        bindData()
        setupLanguage()
    }
    
    @objc func reload(){
        setupLanguage()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupUI() {
        
    }
    
    func bindData() {
        
    }
    
    func setupLanguage(){
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bindData()
    }
    
    func setupTest() {

    }
}
