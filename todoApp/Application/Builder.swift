//
//  Builder.swift
//  todoApp
//
//  Created by admin1 on 12.07.23.
//

import UIKit

protocol Builder {
    static func createViewModule() -> UIViewController
}

final class BuilderImpl: Builder {
    static func createViewModule() -> UIViewController {
        let view = ViewController()
        let storage = StorageManagerImpl()
        let presenter = PresenterImpl(view: view, store: storage)
        view.presenter = presenter
        return view
    }
}
