//
//  MainEndPoints.swift
//  Fahad Test
//
//  Created by Mac on 15/11/2022.
//

import Foundation
import Alamofire

enum MainEndPoints: APIConfiguration {
    
    case getList(request: RemindersList.GetList.Request)
    
    // MARK: HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getList:
            return .get
        }
    }
    
    // MARK: Path
    var path: String {
        switch self {
        case .getList:
            return "rest-test"
        }
    }
    
    // MARK: Parameters
    var parameters: Parameters? {
        switch self {
        case .getList:
            return [:]
        }
    }
    
    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        let url = try ROOT_URL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                print("--------- Request --------")
                print("URL: \(url.appendingPathComponent(path))")
                print("Parmas: \(parameters)")
                print("Type: \(method.rawValue)")
                print("Headers: \(urlRequest.headers)")
                print("--------------------------")
                if method.rawValue != "GET" {
                    urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
                } else {
                    urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
                }
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}
