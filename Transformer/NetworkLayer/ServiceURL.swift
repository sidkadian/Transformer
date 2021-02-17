//
//  ServiceURL.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import Foundation

enum ServiceType {
    case getToken
    case getData
    case addData
    case editData
    case deleteData
}

enum HTTPMethodType: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "Delete"
}

struct ServiceURL {
    static var baseUrl = "https://transformers-api.firebaseapp.com/"
    enum URLType: String {
        case allspark
        case transformers
    }
}

struct ServiceData {
    var baseURL: URL
    var headers: [String: String]
    var httpMethod: HTTPMethodType
    var parameters: Data?

    init(baseURL: URL, headers: [String: String], httpMethod: HTTPMethodType = .get, params: [String: Any]? = nil) {
        self.baseURL = baseURL
        self.headers = headers
        self.httpMethod = httpMethod
        if let params = params {
            self.parameters = try? JSONSerialization.data(withJSONObject: params)
        } else {
            self.parameters = nil
        }

    }
}
