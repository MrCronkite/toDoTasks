//
//  Presenter.swift
//  todoApp
//
//  Created by admin1 on 13.07.23.
//

import UIKit

protocol ViewControllerProtocol: AnyObject {
    func showTasks()
    func showAlert()
}

protocol Presenter: AnyObject {
    var element: [Element] {get set}
    
    init (view: ViewControllerProtocol, element: [Element])
    func setTasks(textTask: String)
}

final class PresenterImpl: Presenter {
    weak var view: ViewControllerProtocol?
    var element: [Element]
    
    required init(view: ViewControllerProtocol, element: [Element]) {
        self.view = view
        self.element = element
        
        setTasks(textTask: "New Task")
    }
    
    func setTasks(textTask: String) {
        if textTask != "" {
            let task = Element(nameTasks: textTask, done: false)
            element.append(task)
            self.view?.showTasks()
        } else {
            self.view?.showAlert()
        }
        self.view?.showTasks()
    }
}
