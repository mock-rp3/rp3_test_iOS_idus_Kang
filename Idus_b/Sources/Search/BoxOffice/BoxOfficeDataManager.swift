//
//  BoxOfficeDataManager.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import Alamofire

class BoxOfficeDataManager {
    func searchDailyBoxOfficeList(targetDt: String, delegate: BoxOfficeViewController) {
        let url = "\(Constant.KOBIS_BASE_URL)/boxoffice/searchDailyBoxOfficeList.json"
            + "?key=\(KobisKey.DAILY_BOXOFFICE_KEY)"
            + "&targetDt=\(targetDt)"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: BoxOfficeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didRetrieveBoxOffice(result: response.boxOfficeResult)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
