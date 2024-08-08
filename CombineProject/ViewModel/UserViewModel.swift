//
//  UserViewModel.swift
//  CombineProject
//
//  Created by Consultant on 7/31/23.
//

import Foundation
import Combine


class UserViewModel: ObservableObject {
    
    @Published var planet:Planets?
    @Published var result: [Result] = []
    @Published var filteredresult :[Result] = []
    @Published var customError: NetworkError?
    
    var networkManager:NetworkProtocol
    private var cancelable = Set<AnyCancellable>()
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
//    func getProductsFromAPI() async{
//        guard let url =  URL(string: API.UserAPI)else{
//            return
//        }
//
//        let  urlRequest = URLRequest(url: url)
//        do{
//            let data = try await self.networkManager.dataFromAPI(urlRequest: urlRequest)
//            self.planet = try JSONDecoder().decode(Planets.self, from: data)
//
//            guard let result = self.planet?.results else {
//                return
//            }
//            self.result = result
//            print(self.result)
//
//        }catch
//            let error{
//            print(error.localizedDescription)
//            switch error{
//            case is DecodingError:
//                customError = NetworkError.parsingError
//
//            case NetworkError.doNotFoundError:
//                customError = NetworkError.doNotFoundError
//
//            case NetworkError.inValidError:
//                customError = NetworkError.inValidError
//
//            default:
//                customError = NetworkError.doNotFoundError
//            }
//
//
//        }
//        }
    
    
    // This is the Combine function
    func getProductsFromAPI(urlString:String) {
        guard let url = URL(string: urlString) else {
                return
            }
            let request = URLRequest(url: url)

            self.networkManager.dataFromAPI(urlRequest: request, type: Planets.self)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Task finished")
                        print(self.result)
                    case .failure(let error):
                        print(error.localizedDescription)
                                    switch error{
                                    case is DecodingError:
                                        self.customError = NetworkError.parsingError
                        
                                    case NetworkError.doNotFoundError:
                                        self.customError = NetworkError.doNotFoundError
                        
                                    case NetworkError.inValidError:
                                        self.customError = NetworkError.inValidError
                        
                                    default:
                                        self.customError = NetworkError.doNotFoundError
                                    }
                    }
                }, receiveValue:{ val in
                    self.planet = val
                    guard let result = self.planet?.results else {
                        return
                        
                    }
                    self.result = result.sorted(by: { $0.name < $1.name })
                    self.filteredresult = result.sorted(by: { $0.name < $1.name })
                    print(self.result)
                    
                    
                    
                }).store(in: &cancelable)
                
        }
    
    func filterresult(searchText:String){
        if searchText.isEmpty{
            self.filteredresult = self.result.sorted(by: { $0.name < $1.name })
        }else{
            let list =  self.result.filter { planetResult in
                return planetResult.name.localizedCaseInsensitiveContains(searchText)
            }
            self.filteredresult = list.sorted(by: { $0.name < $1.name })
        }
    }
    
    func cancelAPICall(){
        print("Cancelled the request")
        cancelable.first?.cancel()
    }

    
    }



    
