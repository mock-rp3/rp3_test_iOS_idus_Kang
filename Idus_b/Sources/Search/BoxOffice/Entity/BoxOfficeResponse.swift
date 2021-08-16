//
//  BoxOfficeResponse.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import Foundation

struct BoxOfficeResponse: Decodable {
    var boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    var boxofficeType: String
    var showRange: String
    var dailyBoxOfficeList: [Movie]
}

struct Movie: Decodable {
    var rnum: String            // 순번을 출력합니다.
    var rank: String            // 해당일자의 박스오피스 순위를 출력합니다.
    var rankInten: String       // 전일대비 순위의 증감분을 출력합니다.
    var rankOldAndNew: String   // 랭킹에 신규진입여부를 출력합니다. (“OLD” : 기존 , “NEW” : 신규)
    var movieCd: String         // 영화의 대표코드를 출력합니다.
    var movieNm: String         // 영화명(국문)을 출력합니다.
    var openDt: String          // 영화의 개봉일을 출력합니다.
    var salesAmt: String        // 해당일의 매출액을 출력합니다.
    var salesShare: String      // 해당일자 상영작의 매출총액 대비 해당 영화의 매출비율을 출력합니다.
    var salesInten: String      // 전일 대비 매출액 증감분을 출력합니다.
    var salesChange: String     // 전일 대비 매출액 증감 비율을 출력합니다.
    var salesAcc: String        // 누적매출액을 출력합니다.
    var audiCnt: String         // 해당일의 관객수를 출력합니다.
    var audiInten: String       // 전일 대비 관객수 증감분을 출력합니다.
    var audiChange: String      // 전일 대비 관객수 증감 비율을 출력합니다.
    var audiAcc: String         // 누적관객수를 출력합니다.
    var scrnCnt: String         // 해당일자에 상영한 스크린수를 출력합니다.
    var showCnt: String         // 해당일자에 상영된 횟수를 출력합니다.
}
