//
//  ParseJsonViewModel.swift
//  Spot
//
//  Created by suhyeon on 2021/02/09.
//

import UIKit

class SearchViewModel {
    
    let title = "자전거사고 검색"
    let title2 = "지역 선택"
    
    //******************************************
    // JSON Parsing
    //******************************************
    
    var result: LocationData?

    init() {
        parseJSON()
    }

    func parseJSON() {
        // filePath : Xcode 내부 path
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            return
        }
        // filePath -> URL
        let url = URL(fileURLWithPath: path)
        //do catch in case of an error
        do {
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode(LocationData.self, from: jsonData)
        } catch {
            print("Error: \(error)")
        }
    }
}
