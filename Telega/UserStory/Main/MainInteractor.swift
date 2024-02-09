//
//  MainInteractor.swift
//  Telega
//
//  Created by Diyor Tursunov on 08/02/24.
//

import Foundation
import Network


protocol MainInteractorProtocol: AnyObject {
    func search(query: String) async throws -> [BookItem]
    func saveToLocalStore()
}

final class MainInteractor: MainInteractorProtocol {
    private let networkManager: NetworkManagerProtocol
    private let coreDataManager: DataLayer
    
    private var response: BookResponse?
    
    private lazy var currentData = coreDataManager.getAll(entity: BookEntityModel.self)
    
    init (networkManager: NetworkManagerProtocol, coreDataManager: DataLayer) {
        self.networkManager = networkManager
        self.coreDataManager = coreDataManager
    }
    
    func search(query: String) async throws -> [BookItem] {
        let path = BaseRequest(query: query)
        if networkManager.isConnectedToNetwork() {
            let result: BookResponse = try await networkManager.fetch(path: path)
            response = result
            guard let items = result.items else {
                throw CustomError.smthnWentWrong
            }
            
            return items.map{ BookItem(book: $0) }
        } else {
            let result: [BookEntityModel] = coreDataManager.getAll(entity: BookEntityModel.self)
            return result.map{ BookItem(book: $0)}
        }
    }
    
    func saveToLocalStore() {
        guard let response, let items = response.items else { return }
        items.forEach { item in
            if let existingElement = currentData.first(where: { $0.id == item.id }) {
                existingElement.name = item.volumeInfo?.title
                existingElement.authors = item.volumeInfo?.authors?.joined(separator: "\n")
                existingElement.detail = item.volumeInfo?.subtitle
                existingElement.imageURL = item.volumeInfo?.imageLinks?.medium
                existingElement.publishedYear = item.volumeInfo?.publishedDate
            } else {
                let book = BookEntityModel(context: coreDataManager.mainContext)
                book.name = item.volumeInfo?.title
                book.id = item.id
                book.authors = item.volumeInfo?.authors?.joined(separator: "\n")
                book.detail = item.volumeInfo?.subtitle
                book.imageURL = item.volumeInfo?.imageLinks?.medium
                book.publishedYear = item.volumeInfo?.publishedDate
            }
        }
        coreDataManager.saveContext()
    }
}
