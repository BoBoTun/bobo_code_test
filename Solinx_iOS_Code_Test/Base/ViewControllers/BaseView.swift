//
//  BaseView.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/27/23.
//


import UIKit
import Combine
import CombineCocoa

class BaseView : UIView {
    
    var view: UIView!
    var bindings = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        bindData()
        setupLanguage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        bindData()
        setupLanguage()
    }
    
    @objc func reload(){
        setupLanguage()
    }

    func setupUI() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView! {
        return UINib(nibName: String(describing: type(of: self)), bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView ?? UIView(frame: CGRect.zero)
    }
    
    func bindData() {
        
    }

    func setupLanguage() {
        
    }
    
    func setupTest() {
        
    }
}


