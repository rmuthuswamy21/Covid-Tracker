//
//  ViewController.swift
//  Covid-19App
//
//  Created by Rahul Muthuswamy on 1/3/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var covidTableView: UITableView!
    
    var data: [StateCovidModel] = []
    var filterList = [StateCovidModel]()
    var searchList:Bool = false
    var selectedCovidStateModel: StateCovidModel?
    var avgCases = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        NetworkAPICall().makeCall(completion: {list in
          DispatchQueue.main.async {
                self.data = list
                self.avgCases = self.getAverage(of: list)
                self.covidTableView.reloadData()
           }
            
        })
        
        self.covidTableView.backgroundColor = .black
        let image = UIImage(named: "image")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        self.covidTableView.backgroundView = imageView
        
        
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.delegate = self
        searchBar.searchTextField.returnKeyType = .done
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList ? filterList.count : data.count
    } //creates number of rows for any section, use if statements if you want to specify a specific section
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let covidData = searchList ? filterList[indexPath.row] : data[indexPath.row]
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.decorateCell(covidData: covidData)
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCovidStateModel = data[indexPath.row]
        performSegue(withIdentifier: "DetailVC", sender: covidTableView)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        cell.tintColor = .darkGray
        let indicator = UIImageView(image: UIImage(systemName: "chevron.right"))
        cell.accessoryView = indicator
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.searchTextField.text ?? ""
        if searchText.isEmpty {
            return
        }
        searchBar.resignFirstResponder()
        
        
        for stateCovidData in data {
            if stateCovidData.stateName == searchText.uppercased() {
                filterList.append(stateCovidData)
            }
        }
        reloadTableViewUsing(search: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            reloadTableViewUsing(search: false)
            filterList.removeAll()
        }
        else {
            filterList.removeAll()
            for stateCovidData in data {
                if stateCovidData.stateName.hasPrefix(searchText)  {
                    filterList.append(stateCovidData)
                }
            }
            reloadTableViewUsing(search: true)
        }
    }
    
    private func reloadTableViewUsing(search: Bool){
        self.searchList = search
        covidTableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.covidStateModel = selectedCovidStateModel
            destination.averageCases = avgCases
        }
        
            navigationController?.navigationBar.isHidden = false
    }
    
    private func getAverage(of data: [StateCovidModel]) -> Double {
        var sum = 0
        for covidModel in data {
            sum += covidModel.positive ?? 0
        }

        return Double(sum/data.count)
    }
    
    
}

extension UITableViewCell {
    func decorateCell(covidData: StateCovidModel) {
        textLabel?.text = covidData.stateName
        let posIncrease = covidData.positiveIncrease ?? 0
        detailTextLabel?.text = "+\(posIncrease)"
        detailTextLabel?.textColor = posIncrease > 1000 ? .systemRed : .systemGreen
        textLabel?.textColor = .white
        textLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 25)
    }
}

