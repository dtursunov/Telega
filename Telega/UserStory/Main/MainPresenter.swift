//
//  MainPresenter.swift
//  Telega
//
//  Created by Diyor Tursunov on 08/02/24.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoad()
    func search(text: String?)
    func didSelectItem(at indexPath: IndexPath)
    func getNumberOfRows() -> Int
    func getItem(at indexPath: IndexPath) -> MainViewCell.Model
}

final class MainPresenter {
    private let interactor: MainInteractorProtocol
    private let output: MainOutput
    
    weak var view: MainViewProtocol?
    private var response: BookResponse?
    private var books = [BookItem]()
    
    private var searchingTask: Task<Void, Never>?
    private let amountsCalculationDebouncer = Debouncer(seconds: 1)
    
    init(
        interactor: MainInteractorProtocol,
        output: MainOutput
    ) {
        self.interactor = interactor
        self.output = output
    }
}

extension MainPresenter: MainPresenterProtocol {
    func viewDidLoad() {
        
    }
    
    func search(text: String?) {
        guard let text else { return }
        
        amountsCalculationDebouncer.debounce { [weak self] in
            Task.detached { [weak self] in
                guard let self else { return }
                do {
                    books = try await interactor.search(query: text.lowercased())
                    await MainActor.run {
                        self.view?.reloadData()
                    }
                } catch let error {
                    // здесь по хорошему надо обработать ошибки, но в тестовом не сказано
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getNumberOfRows() -> Int {
        return books.count
    }
    
    func getItem(at indexPath: IndexPath) -> MainViewCell.Model {
        let book = books[indexPath.row]
        
        let item = MainViewCell.Model(
            bookId: book.id,
            title: book.name,
            detail: book.detail ?? "",
            imageUrl: book.imageURL
        )
        return item
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let book = books[indexPath.row]
        output.showDetail(book: book)
        interactor.saveToLocalStore()
    }
}
