//
//  StorageManager.swift
//  todoApp
//
//  Created by admin1 on 15.07.23.
//

import UIKit

protocol StorageManager {
    func set(_ object: [Element], forKey key: StorageManagerImpl.Keys)
    func getElement(forKey key: StorageManagerImpl.Keys) -> [Element]?
}

final class StorageManagerImpl {
    public enum Keys: String {
        case keysTask
    }
    
    private let userDefault = UserDefaults.standard
    
    private func store(_ object: Any?, key: String) {
        userDefault.set(object, forKey: key)
    }
    
    private func restore(forKey key: String) -> Any? {
        userDefault.object(forKey: key)
    }
}

extension StorageManagerImpl: StorageManager {
    func set(_ object: [Element], forKey key: Keys) {
        var jsonData: [Data] = []
        object.forEach { i in
            let data = try! PropertyListEncoder().encode(i)
            jsonData.append(data)
        }
        store(jsonData, key: key.rawValue)
    }
    
    func getElement(forKey key: Keys) -> [Element]? {
        guard let data = restore(forKey: key.rawValue) as? [Data] else { return nil }
        var element: [Element] = []
        data.forEach { i in
            let decoded = try! PropertyListDecoder().decode(Element.self, from: i)
            element.append(decoded)
        }
        return element
    }
}
