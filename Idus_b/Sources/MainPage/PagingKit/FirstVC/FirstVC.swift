//
//  FirstVC.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/19.
//

import UIKit

class FirstVC: BaseViewController {
    
    @IBOutlet var table: UITableView!
    var models = [Model]()
//    var images = [UIImage]()
    var i = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배너 이미지 배열
//        while let image = UIImage(named: "main_banner\(i)") {
//            images.append(image)
//            i += 1
//        }
        while let _ = UIImage(named: "main_banner\(i)") {
            models.append(Model(imageName: "main_banner\(i)"))
            i += 1
        }
        
        table.register(FirstVCTableBannerCell.nib(), forCellReuseIdentifier: FirstVCTableBannerCell.identifier)
        table.delegate = self
        table.dataSource = self
    }
    
}

// Table
extension FirstVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        // 코드로 작성된 식별자로 테이블 배너셀 가져오기
        let cell = table.dequeueReusableCell(withIdentifier: FirstVCTableBannerCell.identifier, for: indexPath) as! FirstVCTableBannerCell
        cell.configure(with: models)
        return cell
    }
    
    // 테이블뷰 셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
}

struct Model {
    let imageName: String
    
    init(imageName: String) {
        self.imageName = imageName
    }
}
