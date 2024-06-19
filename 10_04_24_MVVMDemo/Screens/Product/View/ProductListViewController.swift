//
//  ProductListViewController.swift
//  10_04_24_MVVMDemo
//
//  Created by Vishal Jagtap on 19/06/24.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var productsTableView: UITableView!
    private let resuseIdentifierForProductTableViewCell = "ProductListTableViewCell"
    private let viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initProductTableView()
        registerProductTableViewWithXIB()
        initFetchProducts()
        observingEvents()
    }
    
    func initFetchProducts(){
        viewModel.fetchProducts()
    }
    
    func initProductTableView(){
        productsTableView.dataSource = self
        productsTableView.delegate = self
    }
    
    func registerProductTableViewWithXIB(){
        let uiNib = UINib(nibName: resuseIdentifierForProductTableViewCell, bundle: nil)
        self.productsTableView.register(uiNib, forCellReuseIdentifier: resuseIdentifierForProductTableViewCell)
    }
    
    func observingEvents(){
        viewModel.eventHandler = {
            event in
            switch event{
            case .loading:
                print("Loading..")
            case .stopLoading:
                print("stop loading")
            case .dataLoaded:
                print("Data is loaded...")
                DispatchQueue.main.async {
                    self.productsTableView.reloadData()
                }
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ProductListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productTableViewCell = self.productsTableView.dequeueReusableCell(withIdentifier: resuseIdentifierForProductTableViewCell, for: indexPath) as! ProductListTableViewCell
        productTableViewCell.product = viewModel.products[indexPath.row]        
        return productTableViewCell
    }
}

extension ProductListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}
