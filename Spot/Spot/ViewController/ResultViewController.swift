//
//  ResultViewController.swift
//  Spot
//
//  Created by suhyeon on 2021/02/07.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Variables
    let viewModel = ResultViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    // 제목 + url 변수
    var yearText: String?
    var localText: String?
    var localNumb: String?
    var localNameText: String?
    
    var districtText: NSMutableArray?
    var spotName = [String]() // 테이블 뷰 목록
    var latitudeData = [String]() // 경도 정보
    var longitudeData = [String]() // 위도 정보

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(nilValueTableViewCell.nib(), forCellReuseIdentifier: nilValueTableViewCell.identifier)
        searchController.searchResultsUpdater = self
      
        setUpView()
        connectViewModel()
    }
    
    
    private func connectViewModel() {
        viewModel.beginParsing(yearText: yearText!, localText: localText!, localNumb: localNumb!)
        spotName = viewModel.spotName
        latitudeData = viewModel.latitude
        longitudeData = viewModel.longitude
    }
    
    private func setUpView() {
        self.navigationItem.title = "\(yearText!)년 \(localNameText!)"
        // searchController
        searchController.searchBar.placeholder = "지역을 검색하세요"
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        // tableview 끝에 셀이 뷰로 대체됨
        tableView.tableFooterView = UIView()
    }

    // passing data to MapViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? MapViewController else { return }
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        nextViewController.longitudeData = longitudeData[indexPath!.row]
        nextViewController.latitudeData = latitudeData[indexPath!.row]
    }
    
    //******************************************
    // tableView
    //******************************************

    
    var filteredData = [String]()
    var filter = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filter {
            return filteredData.count
        } else {
            return spotName == [""] ? 1 : spotName.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch spotName {
        case [""]:
            let nilCell = tableView.dequeueReusableCell(withIdentifier: nilValueTableViewCell.identifier, for: indexPath) as! nilValueTableViewCell
            return nilCell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            if filter {
                cell.textLabel?.text = filteredData[indexPath.row]
                cell.textLabel?.numberOfLines = 0
            } else {
                cell.textLabel?.text = spotName[indexPath.row]
                cell.textLabel?.numberOfLines = 0
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return spotName == [""] ? view.frame.size.height - 250 : 65
    }
    
    // header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return spotName == [""] ? "발생한 사고가 없습니다." : "사고 발생 건수 : \(spotName.count)건"
    }

}

extension ResultViewController: UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        self.filteredData = self.spotName.filter { $0.contains(text) }
        if(filteredData.count == 0){
            filter = false;
        } else {
            filter = true;
        }
        tableView.reloadData()
    }
    
    
}
