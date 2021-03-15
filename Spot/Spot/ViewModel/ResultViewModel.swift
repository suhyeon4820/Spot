//
//  ParseXML.swift
//  Spot
//
//  Created by suhyeon on 2021/02/09.
//

import UIKit
import SwiftyXMLParser

class ResultViewModel: NSObject, XMLParserDelegate {
    
    // MARK: Variables
    
    var posts = NSMutableArray() /// feed 데이터를 저장하는 mutable array
    
    /// data같은 feed데이터를 저장하는 mutabledictionary
    var elements = [String: String]() /// Dictionary
    var element = "" /// 현재 Element (각 태그)
    
    /// 저장 문자열 변수 : feed 데이터를 저장하는 array
    var sidoName = [String]()
    var spotName = [String]()
    var longitude = [String]()
    var latitude = [String]()
    
    // 변수
    var sido_sgg_nm = "" // 지역 정보
    var spot_nm = "" // 지역 세부 정보
    var la_crd = "" // 위도
    var lo_crd = "" // 경도

    //******************************************
    // XML Parsing
    //******************************************
    // https://shnoble.tistory.com/16
    var xmlParser = XMLParser() /// xml파일을 다운로드 및 파싱하는 오브젝트 //*********
    
    func beginParsing(yearText: String, localText: String, localNumb: String) {
        posts = []
        let Url = "http://apis.data.go.kr/B552061/frequentzoneBicycle/getRestFrequentzoneBicycle?"
        let key = "ServiceKey=IlkN0BhF6auPlxjnjQv1Mz7tLpHiqKhby5fa2SavSnfNiNVgDTvmIXSk%2FMLNUrUkc902NSk3yuuK6M8uU%2B1MGw%3D%3D"
        let url = "\(Url)"+"\(key)"+"&searchYearCd="+"\(yearText)"+"&siDo="+"\(localNumb)"+"&guGun="+"\(localText)"+"&type=xml&numOfRows=20&pageNo=1"
        print(url)
        /// URL타입의 매개변수를 넣어줘서 XMLParser 객체를 생성
        guard let xmlParser = XMLParser(contentsOf: URL(string: url)!) else { return }
        xmlParser.delegate = self //*********
        /// parse()를 통해서 넣어준 URL의 응답을 파싱
        xmlParser.parse() //*********
    }
    
    // parser가 새로운 element를 발견하면 변수를 생성
    // didStartElement(태그 시작) : XMLParserDelegate 함수 -> XML 파서가 시작 테그를 만나면 호출됨
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        element = elementName
        if (elementName == "item") {
            elements = [:]
            sido_sgg_nm = ""
            spot_nm = ""
            la_crd = ""
            lo_crd = ""
        }
    }
    // foundCharacters : 생성한 객체에 현재 테그에 담겨있는 문자열 전달
    // 주의할점 : xml태그끝에 빈칸을 인식하기때문에 데이터가 아닌 빈배열저장 되는 문제가 발생
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        if (element == "sido_sgg_nm") {
            sido_sgg_nm.append(string)
        } else if (element == "spot_nm") {
            spot_nm.append(string)
        } else if element == "lo_crd" {
            lo_crd.append(string)
        } else if element == "la_crd" {
            la_crd.append(string)
        }
    }
    // didEndElement(태그 끝) : XML 파서가 종료 테그를 만나면 호출됨 - element의 끝에서 feed 데이터를 dictionary에 저장
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName == "item") {
            elements["sido_sgg_nm"] = sido_sgg_nm
            elements["spot_nm"] = spot_nm
            elements["lo_crd"] = lo_crd
            elements["la_crd"] = la_crd
            sidoName.append(sido_sgg_nm)
            spotName.append(spot_nm)
            longitude.append(lo_crd)
            latitude.append(la_crd)
        }
        posts.add(elements)
    }


}
