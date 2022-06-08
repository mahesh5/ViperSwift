//
//  APINetworkLayer.swift
//  Lloyds
//
//  Created by Mahesh Varadaraj on 09/06/22.
//

import Foundation

class APINetworkLayer {
    
      class func requestApi<T: Codable>(url: String, completion: @escaping (Result<T, Error>) -> ()) {
        
        guard let url = URL(string: url) else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) {
            data, response, error in
            
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "")
                return
            }

            guard response != nil, let data = data else { return }
                if let responseObject  =  try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(responseObject))
                } else {
                    let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "Failed to load data"])
                    completion(.failure(error))
                }
            
        }
        dataTask.resume()
    }
}
