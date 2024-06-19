//
//  ProductListTableViewCell.swift
//  10_04_24_MVVMDemo
//
//  Created by Vishal Jagtap on 19/06/24.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var product : Product?{
        didSet{
            productConfiguration()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func productConfiguration(){
        self.idLabel.text = product?.id.codingKey.stringValue
        self.titleLabel.text = product?.title
    }
}
