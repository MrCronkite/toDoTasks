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
        let element: [Element] = [.init(nameTasks: "Go to the shop", done: false),
                                  .init(nameTasks: "Buy Bread", done: false),
                                  .init(nameTasks: "Drink Vodka", done: true)]
        let presenter = PresenterImpl(view: view, element: element )
        view.presenter = presenter
        return view
    }
}
