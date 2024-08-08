//
//  FakeNetworkManager.swift
//  CombineProjectTests
//
//  Created by Consultant on 8/1/23.
//

import Foundation
import Combine
@testable import CombineProject

class FakeNetworkManager:NetworkProtocol{
    func dataFromAPI<T>(urlRequest: URLRequest, type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        let bundle = Bundle(for: NetworkManager.self)
        let urlString = urlRequest.url?.absoluteString
        guard let url = bundle.url(forResource: urlString, withExtension: "json") else{
            return Fail(error: NetworkError.inValidError).eraseToAnyPublisher()
            
        }
        do{
            let data = try Data(contentsOf: url)
            let planetList = try JSONDecoder().decode(type.self, from: data)
            print(planetList)
            return  Just(planetList)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
            
        }catch{
            print(error.localizedDescription)
            return Fail(error: error).eraseToAnyPublisher()
            
        }
        
    }
    
}
    
    


