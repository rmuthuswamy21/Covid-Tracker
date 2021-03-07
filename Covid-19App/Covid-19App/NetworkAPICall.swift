//
//  NetworkAPICall.swift
//  Covid-19App
//
//  Created by Rahul Muthuswamy on 1/17/21.
//

import Foundation
class NetworkAPICall {
    func makeCall(completion: @escaping ([StateCovidModel])->()){
        let url = URL(string: "https://api.covidtracking.com/v1/states/current.json")
        let dataTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let safeData = data
            else {
                return
            }
            
            do {
                let stateModels = try JSONDecoder().decode([StateCovidModel].self, from: safeData)
                completion(stateModels)
            }
            catch {
                print("Error")
            }
        }
        dataTask.resume()
      
    
        
    }
   
}
