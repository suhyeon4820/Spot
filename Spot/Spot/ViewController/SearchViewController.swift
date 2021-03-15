//
//  SearchViewController.swift
//  Spot
//
//  Created by suhyeon on 2021/02/06.
//

import UIKit

class SearchViewController: UIViewController, DataSendingDelegateProtocol {
    
    // MARK: Variables
    let viewModel = SearchViewModel()
    let locationData = SearchViewModel().result!.Result
    
    var indexNumb: Int = 0
    var sidoName: String?
    var sidoNumb: String?
    
    var yearText: String?
    var sigunguText: String?
    var localNameText: String?
    
    @IBOutlet weak var yearSegment: UISegmentedControl!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var regionTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
    
        setUpView()
    }
    
    private func setUpView() {
        //navigation Item & Bar
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1764705882, green: 0.6470588235, blue: 0.4078431373, alpha: 1)
        navigationItem.largeTitleDisplayMode = .always
        // segment font
        let font = UIFont.boldSystemFont(ofSize: 17)
        yearSegment.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        // searchbutton enable
        searchButton.applyButtonStyle(color: #colorLiteral(red: 0.1764705882, green: 0.6470588235, blue: 0.4078431373, alpha: 1), textColor: .white, state: .normal)
    }
    
    // Segment
    @IBAction func tapYearSegment(_ sender: UISegmentedControl) {
        sender.selectedSegmentTintColor = #colorLiteral(red: 0.5568627451, green: 0.8196078431, blue: 0.7058823529, alpha: 1)
        if sender.selectedSegmentIndex == 0 {
            yearTextField.text = "2018"
        } else if sender.selectedSegmentIndex == 1 {
            yearTextField.text = "2019"
        }
        yearText = yearTextField.text
    }
    
    @IBAction func tapSearchButton(_ sender: Any) {
        if (yearTextField.text?.isEmpty == false) && (regionTextField.text?.isEmpty == false) {
            let vc = storyboard?.instantiateViewController(identifier: "ResultViewController") as! ResultViewController
            navigationController?.pushViewController(vc, animated: true)
            vc.yearText = yearText!
            vc.localText = sigunguText!
            vc.localNameText = localNameText!
            vc.localNumb = sidoNumb!
        }
    }
    
    // Delegate Method
    func sendDataToFirstViewController(myData: String) {
        self.indexNumb = Int(myData)!
        self.pickerView.reloadAllComponents()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? ChoiceRegionViewController else { return }
        nextViewController.delegate = self
    }

}

//******************************************
// PickerView
//******************************************

extension SearchViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // pickerView의 컴포넌트 개수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    // pickerView의 각 컴포넌트에 대한 row의 개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 1
        } else {
            return locationData[indexNumb].sigunguName.count
        }
    }
    // pickerView의 각 컴포넌트에 대한 내용
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return locationData[indexNumb].sidoName
        } else {
            return locationData[indexNumb].sigunguName[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Reloads a particular component of the picker view
        pickerView.reloadComponent(1) // 인덱스 1 번의 변화되는 데이터를 reload
        let selectDistrict = pickerView.selectedRow(inComponent: 1) // 구이름 pickerView
        
        regionTextField.text = "\(locationData[indexNumb].sidoName)" + " " + "\(locationData[indexNumb].sigunguName[selectDistrict])"
        sigunguText = "\(locationData[indexNumb].sigunguNumb[selectDistrict])"
    
        localNameText = "\(locationData[indexNumb].sidoName)" + " " + "\(locationData[indexNumb].sigunguName[selectDistrict])"
        
        sidoNumb = "\(locationData[indexNumb].sidoNumb)"
    }
   
    
}

