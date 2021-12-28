//
//  REST.swift
//  Carangas
//
//  Created by Anderson Mendes de Almeida on 17/12/21.
//  Copyright © 2021 Eric Brito. All rights reserved.
//

import Foundation
import Alamofire

enum CarError {
    case url
    case taskError(error: Error?)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

enum RESTOperation {
    case save
    case update
    case delete
}

class REST {
    private static let basePath = "https://carangas.herokuapp.com/cars"
    
    // baseada no servico: https://deividfortuna.github.io/fipe/
    private static let urlFipe = "https://parallelum.com.br/fipe/api/v1/carros/marcas"
    
    private static let session = URLSession(configuration: configuration)
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.httpAdditionalHeaders = ["Content-Type":"application/json"]
        config.timeoutIntervalForRequest = 15
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    static func loadCars(onComplete: @escaping ([Car]) -> Void, onError: @escaping (CarError) -> Void) {
        
        guard let url = URL(string: basePath) else {
            onError(.url)
            return
        }
        
        AF.request(url).response { result in
            
            if result.error == nil {
                guard let response = result.response else {
                    onError(.noResponse)
                    return
                }
                
                if response.statusCode == 200 {
                    guard let data = result.data else {
                        onError(.noData)
                        return
                    }
                    
                    do {
                        let cars = try JSONDecoder().decode([Car].self, from: data)
                        onComplete(cars)
                    } catch {
                        print(error.localizedDescription)
                        onError(.invalidJSON)
                    }
                } else {
                    print("Algum status inválido(-> \(response.statusCode) <-) pelo servidor!! ")
                    onError(.responseStatusCode(code: response.statusCode))
                }
            } else {
                print(result.error.debugDescription)
                onError(.taskError(error: result.error))
            }
        }
        
//        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
//            if error == nil {
//                guard let response = response as? HTTPURLResponse else {
//                    onError(.noResponse)
//                    return
//                }
//                if response.statusCode == 200 {
//                    guard let data = data else {
//                        onError(.noData)
//                        return
//                    }
//
//                    do {
//                        let cars = try JSONDecoder().decode([Car].self, from: data)
//                        onComplete(cars)
//                    } catch {
//                        print(error.localizedDescription)
//                        onError(.invalidJSON)
//                    }
//                } else {
//                    print("Algum status inválido(-> \(response.statusCode) <-) pelo servidor!! ")
//                    onError(.responseStatusCode(code: response.statusCode))
//                }
//            } else {
//                print(error.debugDescription)
//                onError(.taskError(error: error))
//            }
//        }.resume()
        
    }
    
    static func loadBrands(onComplete: @escaping ([Brand]?) -> Void){
        
        guard let url = URL(string: urlFipe) else {
            onComplete(nil)
            return
        }
        
        AF.request(url).response { result in
            if result.error == nil {
                guard let response = result.response else {
                    onComplete(nil)
                    return
                }
                if response.statusCode == 200 {
                    // obter o valor de data
                    guard let data = result.data else {
                        onComplete(nil)
                        return
                    }
                    do {
                        let brands = try JSONDecoder().decode([Brand].self, from: data)
                        onComplete(brands)
                    } catch {
                        // algum erro ocorreu com os dados
                        onComplete(nil)
                    }
                } else {
                    onComplete(nil)
                }
            } else {
                onComplete(nil)
            }
        }
        
        // tarefa criada, mas nao processada
//        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
//            if error == nil {
//                guard let response = response as? HTTPURLResponse else {
//                    onComplete(nil)
//                    return
//                }
//                if response.statusCode == 200 {
//                    // obter o valor de data
//                    guard let data = data else {
//                        onComplete(nil)
//                        return
//                    }
//                    do {
//                        let brands = try JSONDecoder().decode([Brand].self, from: data)
//                        onComplete(brands)
//                    } catch {
//                        // algum erro ocorreu com os dados
//                        onComplete(nil)
//                    }
//                } else {
//                    onComplete(nil)
//                }
//            } else {
//                onComplete(nil)
//            }
//        }
//        // start request
//        dataTask.resume()
    }
    
    static func save (car: Car, onComplete: @escaping (Bool) -> Void) {
        applyOperation(car: car, operation: .save, onComplete: onComplete)
    }
    
    static func update (car: Car, onComplete: @escaping (Bool) -> Void) {
        applyOperation(car: car, operation: .update, onComplete: onComplete)
    }
    
    static func delete (car: Car, onComplete: @escaping (Bool) -> Void) {
        applyOperation(car: car, operation: .delete, onComplete: onComplete)
    }
    
    static func applyOperation(car: Car, operation: RESTOperation, onComplete: @escaping (Bool) -> Void){
        guard let url = URL(string: "\(basePath)/\(car._id ?? "")") else {
            onComplete(false)
            return
        }
        
        var request = URLRequest(url: url)
        var httpMethod: String = "GET"
        
        switch operation {
        case .delete:
            httpMethod = "DELETE"
        case .save:
            httpMethod = "POST"
        case .update:
            httpMethod = "PUT"
        }
        
        request.httpMethod = httpMethod
        
        guard let json = try? JSONEncoder().encode(car) else {
            onComplete(false)
            return
        }
        
        request.httpBody = json
        request.allHTTPHeaderFields = ["Content-Type":"application/json"]
        
        AF.request(request).response { result in
            if result.error == nil {
                guard let response = result.response, response.statusCode == 200 else {
                    onComplete(false)
                    return
                }
                onComplete(true)
            } else {
                onComplete(false)
            }
        }
        
//        session.dataTask(with: request) { (data: Data?, response: URLResponse?, erro: Error?) in
//            if erro == nil {
//                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let _ = data else {
//                    onComplete(false)
//                    return
//                }
//                onComplete(true)
//            } else {
//                onComplete(false)
//            }
//        }.resume()
    }
}
