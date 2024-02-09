//
//  MainFlowController.swift
//  Telega
//
//  Created by Diyor Tursunov on 08/02/24.
//

import UIKit

enum MainFlowControllerFactory {
    static func make(dicontainer: AnyDIContainer) -> UIViewController {
        MainFlowController(dicontainer: dicontainer)
    }
}

final class MainFlowController: UINavigationController {
    private let dicontainer: AnyDIContainer
    
    init(dicontainer: AnyDIContainer) {
        self.dicontainer = dicontainer
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let root = MainAssembly.assemble(
            output: self,
            networkManager: dicontainer.networkManager,
            coreDataManager: dicontainer.coreDataManager
        )
        setViewControllers([root], animated: false)
    }
}

extension MainFlowController: MainOutput {
    func showDetail(book: BookItem) {
        let vc = DetailView(book: book)
        pushViewController(vc, animated: true)
    }
}
