//
//  ChoiceRegionViewController.swift
//  Spot
//
//  Created by suhyeon on 2021/02/07.


import UIKit

protocol DataSendingDelegateProtocol {
    func sendDataToFirstViewController(myData: String)
}

class ChoiceRegionViewController: UIViewController {
    
    // MARK: Variables
    @IBOutlet weak var tableView: UITableView!
    var chooseIndexNumb: Int = 0
    
    let viewModel = SearchViewModel()
    let locationData = SearchViewModel().result!.Result
    var result: LocationData?
    var delegate: DataSendingDelegateProtocol? = nil
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        setUpView()
    }
    
    private func setUpView() {
        self.navigationItem.title = viewModel.title2
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    
    @IBAction func tapCancelButton(_ sender: Any) {
        // data passing
        if self.delegate != nil {
            self.delegate?.sendDataToFirstViewController(myData: "\(chooseIndexNumb)")
            navigationController?.popViewController(animated: true)
        }
    }
    
}

//******************************************
// tableView
//******************************************

extension ChoiceRegionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationData.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "regionChoiceCell", for: indexPath)
        // text
        cell.textLabel?.text = locationData[indexPath.row].sidoName
        cell.textLabel?.font = .systemFont(ofSize: 19)
        // cell color
        cell.selectedBackgroundView = UIView(frame: cell.frame)
        cell.selectedBackgroundView?.backgroundColor = #colorLiteral(red: 0.5568627451, green: 0.8196078431, blue: 0.7058823529, alpha: 1)
        
        return cell
    }
    // passing choosen region index to SearchViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chooseIndexNumb = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
