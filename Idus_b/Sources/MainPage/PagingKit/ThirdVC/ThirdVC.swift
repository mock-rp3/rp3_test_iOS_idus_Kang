//
//  ThirdVC.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/19.
//

import UIKit

class ThirdVC: BaseViewController {
    
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(FirstVCTableCategoryCell.nib(), forCellReuseIdentifier: FirstVCTableCategoryCell.identifier)
        table.delegate = self
        table.dataSource = self
        
    }
}

extension ThirdVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: FirstVCTableBannerCell.identifier, for: indexPath) as! FirstVCTableBannerCell
        cell.configure(with: models)
        cell.delegate = self
        return cell
    }
}

// MARK: - 배너 컬렉션뷰 이미지 클릭 이벤트 델리게이트 채택
extension ThirdVC: BannerDelegate {
    func didSelectedBanner(_ index: Int) {
        print("\(index)번째 셀")
    }
}
