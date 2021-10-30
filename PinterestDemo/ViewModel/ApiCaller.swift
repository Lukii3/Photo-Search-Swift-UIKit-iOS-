//
//  Api.swift
//  PinterestDemo
//
//  Created by Łukasz Jakubek on 29/06/2021.
//

import UIKit

class ApiCaller {
    
    func fetchData(query: String, completion: @escaping (_ result: [Result]) -> Void) {
        
        let link = "https://api.unsplash.com/search/photos?page=1&per_page=20&query=\(query)&client_id=3HY4bCa8yJlc2yPdxOEqUZGsZ3RNVavHImqHP0AEJB8"
        
        guard let url = URL(string: link) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonResult = try decoder.decode(ApiResponse.self, from: data)
                
                let results = jsonResult.results
                
                completion(results)
                
            } catch {
                print("The error is: \(error.localizedDescription)")
            }
          
           
            
        }
        
        task.resume()
        
    }
}
