//
//  SampleAPI.swift
//  RefreshTokenSample
//
//  Created by Srilatha Karancheti on 2023-06-20.
//

import Foundation
import OktaIdx

enum SampleAPI: Endpoint {
    var path: String {
        return "anyPath"
    }
    
    var urlString: String {
        return "anyURLString"
    }
    
    var requiresAuthToken: Bool {
        switch self {
        case .login, .register, .agreements:
            return false
        default:
            return true
        }
    }
    
    public var httpHeaderFields: [String: String]? {
        var headers = ["AppToken": "Some app token"]
        
        if requiresAuthToken {
            if let token = token {
                headers["AuthToken"] = token
            } else {
                print("Attempting to generate http headers without auth token when auth token is required.")
            }
        }
        
        return headers
    }
    
    var token: String? {
        return DBCredentialsStore.shared.authToken
    }
    
    /**How I am planning to change**/
//    var token: String? {
//        if isSSOLogin {
//            refreshToken(withCredential: credential)
//        }
//
//        return DBCredentialsStore.shared().authToken()
//    }
    
    func refreshToken(withCredential credential: Credential) {
        let semaphore = DispatchSemaphore(value: 1)
        
        semaphore.wait()
        credential.refreshIfNeeded { result in
            switch result {
            case .success():
                DBCredentialsStore.shared.setAuthToken(credential.token.accessToken)
                semaphore.signal()
            case .failure(let error):
                print(error)
                semaphore.signal()
            }
        }
    }
    
    enum HeaderFields {
        static let contentType = "Content-Type"
        static let authToken = "X-Auth-Token"
        static let appToken = "X-App-Token"
        static let per  = "x-per"
        static let page = "x-page"
        static let requestID = "X-Request-ID"
    }
    
    var baseURL: String {
        return "anyURL"
    }
    
    case login
    case logout
    case deleteAccount
    case register
    case agreements
}


class AppServices {
    static let shared: AppServices = AppServices()
    var apiProvider = Provider<SampleAPI>()
}

class Provider<E> where E: Endpoint {
    func request(_ endpoint: E, completionHandler: (Result<Any, Error>) -> Void) {
        completionHandler(.success(""))
    }
}

class DBCredentialsStore {
    static let shared: DBCredentialsStore = DBCredentialsStore()
    var authToken = "Some token"
    
    func setAuthToken(_ token: String) {
        authToken = token
    }
}

