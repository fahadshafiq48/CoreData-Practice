//
//  Request.swift
//  Fahad Test
//
//  Created by Mac on 15/11/2022.
//

import Foundation
import Alamofire

class Request {
    
    // MARK: Singleton Implementation
    static let sharedInstance = Request()
    private init() {}
    
    /// This function is used to handle all kind of request like get, post and put etc
    ///
    /// - Parameters:
    ///   - urlPath: that is combination of base URL + API Path
    ///   - methodType: that can be put, post, get
    ///   - parameters: that is dictionary of params
    ///   - encodingType: json
    ///   - headers: initialize with nil
    ///   - completionHandler: return the closure to their respective service manager
    func makeRequet<T: Decodable>(request: URLRequest, dataReturnType: T.Type, completionHandler: @escaping (APIResponse<[ListModel]>) -> Void) {
        
        AF.request(request)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json", "text/html"])
            .responseData {(response) in
                switch response.result {
                case .success(let value):
                    do {
                        print("----- Json Response -----")
                        print(value.prettyPrintedJSONString ?? "")
                        print("-------------------------")
                        //po print(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? “”)
                        let result = try JSONDecoder().decode([ListModel].self, from: value)
                        if response.response?.statusCode == 200 {
                            completionHandler(.success(result))
                        } else {
                            completionHandler(.failure(AppError.parseFailed(reason: ParseFailureReason(code: response.response?.statusCode ?? 400, message: "Something went wrong"))))
                        }
                    } catch let error {
                        completionHandler(.failure(AppError.internalFailed(reason: error)))
                    }
                case .failure(let error):
                    completionHandler(.failure(AppError.internalFailed(reason: error)))
                }
        }
    }
}
