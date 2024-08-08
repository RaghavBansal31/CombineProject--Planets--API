//
//  NetworkProtocol.swift
//  CombineProject
//
//  Created by Consultant on 7/31/23.
//

import Foundation
import Combine
//protocol NetworkProtocol{
//    func dataFromAPI(urlRequest:URLRequest) async throws -> Data
//
//}


// This is protocol for Combine
protocol NetworkProtocol{
    func dataFromAPI<T: Decodable>(urlRequest: URLRequest, type: T.Type) -> AnyPublisher<T, Error> where T: Decodable
}
