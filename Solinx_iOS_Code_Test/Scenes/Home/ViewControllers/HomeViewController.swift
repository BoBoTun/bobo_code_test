//
//  HomeViewController.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/27/23.
//

import UIKit
import NVActivityIndicatorView
class HomeViewController: BaseViewController {
    
    @IBOutlet weak var loadingView: NVActivityIndicatorView!
    @IBOutlet weak var searchBgView: UIStackView!
    @IBOutlet weak var tblBook: UITableView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    var btnLogout = RoundedCornerUIButton(type: .custom)
    var userName : String?
    let viewModel = HomeViewModel()
    var bookList = [Book]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.getBooks(searchKeyword: "all")
        self.setupTableView()
    }

    override func setupUI() {
        super.setupUI()
        showNavigationBar()
        setNavigationColor()
        btnLogout.setImage(UIImage(named: "ic_logout")?.imageWithColor(color: .secondary_color), for: .normal)
        setupRightBarButton(buttonList: [btnLogout])
        setupNavigationTitle(title: "Welcome \(self.userName ?? "")")
        
        searchBgView.addBorder(borderWidth: 1, borderColor: .lightGray, bgColor: .clear, isRounded: true, cornerRadius: 0)
        
        btnSearch.setImage(UIImage(named: "ic_search")?.imageWithColor(color: UIColor.white), for: .normal)
        
        loadingView.type = .ballClipRotatePulse
        if bookList.count == 0 {
            self.loadingView.startAnimating()
            self.loadingView.isHidden = false
        }
        }
        
    
    override func bindData() {
        super.bindData()
        btnLogout.tapPublisher.sink {
            AlertManager.showAlert("Logout", message: "Hello \(self.userName ?? "")! Are you sure to Logout?", confirmTitle: "OK", confirmAction: {[unowned self] in
                HomeScreen.HomeVC.navigateToLoginVC.show()
            }, cancelButtonTitle: "Cancel", cancelAction: nil, inViewController: self)
        }.store(in: &bindings)
        
        viewModel.booksResultPublisher.sink {
            self.bookList.removeAll()
            if let books = $0 {
                self.bookList = books
                self.tblBook.reloadData()
            }
            
        }.store(in: &bindings)
        
        viewModel.loadingPublishSubject.sink {
            if $0 {
                self.loadingView.startAnimating()
                self.loadingView.isHidden = false
            }else{
                self.loadingView.stopAnimating()
                self.loadingView.isHidden = true
            }
        }.store(in: &bindings)
        
        viewModel.nodataFound.sink {
            if $0 {
                self.bookList.removeAll()
                self.showToast(message: "No Data Found")
                self.tblBook.reloadData()
            }
        }.store(in: &bindings)
    }
    
    func setupTableView() {
        tblBook.registerForCells(cells: [BookItemTableViewCell.self])
        self.tblBook.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: UIScreen.main.bounds.height * 0.1,right: 0)
        tblBook.backgroundColor = .clear
        tblBook.separatorStyle = .none
        tblBook.showsVerticalScrollIndicator = false
        tblBook.showsHorizontalScrollIndicator = false
        tblBook.dataSource = self
        tblBook.delegate = self
        tblBook.reloadData()
        tblBook.bounces = false
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
    
        if let searchKey = self.txtSearch.text {
            if searchKey.isEmpty || searchKey == "" {
                viewModel.getBooks(searchKeyword: "all")
            }else{
                viewModel.getBooks(searchKeyword: searchKey)
            }
        }else{
            viewModel.getBooks(searchKeyword: "all")
        }
        
        self.txtSearch.resignFirstResponder()
    }
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getBookItemCell(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HomeScreen.HomeVC.navigateToBookDetailVC(self.bookList[indexPath.row]).show()
    }
    
    private func getBookItemCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = tblBook.dequeReuseCell(type: BookItemTableViewCell.self, indexPath: indexPath)
        cell.updateCell(book: self.bookList[indexPath.row])
        return cell
    }
    
    
}
