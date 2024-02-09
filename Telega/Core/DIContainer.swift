//
//  DIContainer.swift
//  Telega
//
//  Created by Diyor Tursunov on 09/02/24.
//

import Foundation

protocol AnyDIContainer: AnyObject {
    var networkManager: NetworkManager { get }
    var coreDataManager: DataLayer { get }
}

final class DIContainer: AnyDIContainer {
    var networkManager: NetworkManager
    var coreDataManager: DataLayer
    
    static let shared = DIContainer()
    private init() {
        networkManager = NetworkManager(baseURL: URL(string: "https://www.googleapis.com"))
        coreDataManager = CoreDataStack()
    }
    
}
