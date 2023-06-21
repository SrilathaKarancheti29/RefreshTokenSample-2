//
//  Endpoint.swift
//  RefreshTokenSample
//
//  Created by Srilatha on 2023-06-20.
//

import Foundation

protocol Endpoint {

    var baseURL: String { get }
    var path: String { get }
    var urlString: String { get }

    var requiresAuthToken: Bool { get }
}
