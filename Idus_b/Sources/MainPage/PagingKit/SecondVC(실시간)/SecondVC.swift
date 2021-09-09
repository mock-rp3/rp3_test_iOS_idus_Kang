//
//  SecondVC.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/19.
//

import UIKit

class SecondVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableViewNib = UINib(nibName: "NowGoodsTableViewCell", bundle: nil)
        tableView.register(tableViewNib, forCellReuseIdentifier: "NowGoodsTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}
extension SecondVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NowGoodsTableViewCell.identifier) as? NowGoodsTableViewCell else {
                return UITableViewCell()
            }
            cell.setCell()
            cell.delegate = self
            return cell
        }else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NowGoodsTableViewCell.identifier) as? NowGoodsTableViewCell else {
                return UITableViewCell()
            }
            cell.setCell()
            cell.delegate = self
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension SecondVC: CVCellDelegate {
    func selectedCVCell(_ index: Int) {
        print("\(index)번째 셀")
    }
}
