//
//  SearchVC.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/23.
//

import UIKit

class SearchVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableViewNib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(tableViewNib, forCellReuseIdentifier: "TableViewCell")
        
        tableView.dataSource = self
    }
    
}
extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.setCell()
        cell.delegate = self
        return cell
    }
}
extension SearchVC: SearchCVCellDelegate {
    func selectedCVCell(_ index: Int) {
        print("\(index)번째 셀")
    }
}
