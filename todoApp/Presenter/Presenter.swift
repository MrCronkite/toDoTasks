//
//  Presenter.swift
//  todoApp
//
//  Created by admin1 on 13.07.23.
//

import UIKit

protocol ViewControllerProtocol: AnyObject {
    func showTasks()
}

protocol Presenter: AnyObject {
    var element: [Element] { get set }
    init (view: ViewControllerProtocol, store: StorageManager)
    
    func setTasks(textTask: String)
    func getTask()
}

final class PresenterImpl: Presenter {
    weak var view: ViewControllerProtocol?
    var store: StorageManager
    var element: [Element] = []
    
    required init(view: ViewControllerProtocol, store: StorageManager) {
        self.view = view
        self.store = store
        
        getTask()
    }
    
    func getTask() {
        element = store.getElement(forKey: .keysTask) ?? [.init(nameTasks: "Set a task", done: true)]
        view?.showTasks()
    }
    
    func setTasks(textTask: String) {
        let task = Element(nameTasks: textTask, done: false)
        element = store.getElement(forKey: .keysTask) ?? [.init(nameTasks: "hello", done: true)]
        element.append(task)
        view?.showTasks()
    }
}
