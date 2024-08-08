//
//  NetworkManager.swift
//  CombineProject
//
//  Created by Consultant on 7/31/23.
//

import Foundation
import Combine

//- Conforming protocol in NetworkProtocol File
class NetworkManager:NetworkProtocol{
//    //- Using function below to parse the urlRequest and get it returned in Data
//    func dataFromAPI(urlRequest: URLRequest) async throws -> Data {
//
//        //- do/catch to  to get the urlRequest in data variable and return to Data else catch
//        //- a error and return error if no urlRequest
//        do{
//            let (data,_) =  try await URLSession.shared.data(for: urlRequest)
//            return data
//        }catch{
//
//            print(error.localizedDescription)
//            throw NetworkError.inValidError
//        }
//    }
//
    
    // This is the Combine method To be used when using Combine
    func dataFromAPI<T>(urlRequest: URLRequest, type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
            return URLSession.shared.dataTaskPublisher(for: urlRequest)
                .tryMap({ (data: Data, response: URLResponse) in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.inValidError
                    }
                    return data
                })
                .delay(for: .seconds(3), scheduler: DispatchQueue.main)
                .decode(type: type.self, decoder: JSONDecoder()) // - Parsing
                .eraseToAnyPublisher()
        }
}

