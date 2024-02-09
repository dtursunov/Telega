//
//  MainAssembly.swift
//  Telega
//
//  Created by Diyor Tursunov on 08/02/24.
//

import UIKit

enum MainAssembly {
    static func assemble(
        output: MainOutput,
        networkManager: NetworkManager,
        coreDataManager: DataLayer
    ) -> UIViewController {
        let interactor = MainInteractor(
            networkManager: networkManager,
            coreDataManager: coreDataManager
        )
        let presenter = MainPresenter(interactor: interactor, output: output)
        let view = MainView(presenter: presenter)
        presenter.view = view
        return view
    }
}
