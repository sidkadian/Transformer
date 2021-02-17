//
//  NetworkManager.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import Foundation

protocol NetworkManagerProtocol: class {
    func getDataFromServiceApi<T: Decodable>(type: T.Type,
                                             call: ServiceType,
                                             postData: [String: Any]?,
                                             completion: @escaping ApiResponse<T>)
}

typealias ApiResponse<T> = (T?, String?) -> Void

class NetworkManager: NetworkManagerProtocol {

    func getDataFromServiceApi<T: Decodable>(type: T.Type, call: ServiceType,
                                             postData: [String: Any]?, completion: @escaping ApiResponse<T>) {

        guard let serviceData = fetchServiceRequest(call: call, postData: postData) else {
            return
        }
        var request = URLRequest(url: serviceData.baseURL)
        for headers in serviceData.headers {
            request.setValue(headers.value, forHTTPHeaderField: headers.key)
        }
        request.httpBody = serviceData.parameters
        request.httpMethod = serviceData.httpMethod.rawValue

        URLSession.shared.dataTask(with: request) { (data, _, errors) in
            if self.fetchToken() == nil {
                self.storeToken(type: type.self, data: data, call: call, postData: postData, completion: completion)
            } else {
                do {
                    let jsonObject = try JSONDecoder().decode(T.self, from: data!)
                    completion(jsonObject, nil)
                } catch let error {
                    completion(nil, nil)
                    print(errors?.localizedDescription as Any)
                    print(error.localizedDescription)
                }
            }

        }.resume()
    }

    private func storeToken<T: Decodable>(type: T.Type, data: Data?,
                                          call: ServiceType, postData: [String: Any]?,
                                          completion: @escaping ApiResponse<T>) {
        guard let data = data,
            let token = String(data: data, encoding: .utf8) else {
                self.getDataFromServiceApi(type: type.self, call: .getToken, postData: postData, completion: completion)
                return
        }
        Keychain.shared[ServiceConstants.token] = token
        self.getDataFromServiceApi(type: type.self, call: call, postData: postData, completion: completion)
    }

    private  func fetchServiceRequest(call: ServiceType, postData: [String: Any]?) -> ServiceData? {
        if let token = self.fetchToken() {
            switch call {
            case .getData:
                return self.serviceRequest(token: token, httpMethod: .get, postData: postData)
            case .addData:
                return self.serviceRequest(token: token, httpMethod: .post, postData: postData)
            case .deleteData:
                return self.serviceRequest(token: token, httpMethod: .delete, postData: postData)
            case .editData:
                return self.serviceRequest(token: token, httpMethod: .put, postData: postData)

            default:
                 return nil
            }
        } else {
            let urlStr = ServiceURL.baseUrl + ServiceURL.URLType.allspark.rawValue
            guard let url = URL(string: urlStr) else {
                return nil
            }
            let serviceData = ServiceData(baseURL: url, headers: [:], httpMethod: .get)
            return serviceData
        }

    }

    private func serviceRequest(token: String, httpMethod: HTTPMethodType, postData: [String: Any]?) -> ServiceData? {
        var urlStr = ServiceURL.baseUrl + ServiceURL.URLType.transformers.rawValue
        if httpMethod == .delete,
            let id = postData?[CreateTranformerParams.id] as? String {
            urlStr += "/" + id
        }
        guard let url = URL(string: urlStr) else {
           return nil
        }
        var headers = [String: String]()
        headers[ServiceConstants.Headers.authorization] = ServiceConstants.Headers.bearer + " " + token
        headers[ServiceConstants.Headers.contentType] = ServiceConstants.Headers.applicationJson
        let serviceData = ServiceData(baseURL: url, headers: headers, httpMethod: httpMethod, params: postData)
        return serviceData
    }

    private func fetchToken() -> String? {
        let token = Keychain.shared[ServiceConstants.token]
        return token
    }
}
