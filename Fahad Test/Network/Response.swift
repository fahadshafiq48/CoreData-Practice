//
//  Response.swift
//  Fahad Test
//
//  Created by Mac on 15/11/2022.
//

import Foundation

// MARK: Response type handling
public typealias JSON = [String: Any]
public typealias JSONArray = [JSON]

enum APIResponse<T> {
    case success(T)
    case failure(AppError)
}
