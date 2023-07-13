//
//  ViewController.swift
//  todoApp
//
//  Created by admin1 on 12.07.23.
//

import UIKit

final class ViewController: UIViewController {
    
    var presenter: Presenter!
    
    let addButton: UIButton = {
        let view = UIButton()
        view.setTitle("Add", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 0.1
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    let textField: UITextField = {
        let view = UITextField()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.1
        view.layer.cornerRadius = 5
        view.placeholder = "What do you do?"
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.separatorStyle = .singleLine
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 5
        view.separatorStyle = .singleLine
        view.rowHeight = UITableView.automaticDimension
        view.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureViewController()
    }
}

extension ViewController {
   private func configureViewController() {
       [
        tableView,
        textField,
        addButton
       ].forEach {
           view.addSubview($0)
           $0.translatesAutoresizingMaskIntoConstraints = false
       }
       
       NSLayoutConstraint.activate([
        textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
        textField.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -2),
        textField.heightAnchor.constraint(equalToConstant: 50),
        
        addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
        addButton.heightAnchor.constraint(equalToConstant: 50),
        addButton.widthAnchor.constraint(equalToConstant: 60),
        
        tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
       ])
       
       tableView.dataSource = self
       tableView.delegate = self
       tableView.register(ItemTableCell.self, forCellReuseIdentifier: "\(ItemTableCell.self)")
       addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
    }
    
   private func alert() {
        let alert = UIAlertController(title: "", message: "Plase create a task", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @IBAction private func addTask() {
        guard let text = textField.text else { return }
        presenter.setTasks(textTask: text)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.element.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ItemTableCell.self)", for: indexPath) as? ItemTableCell else { return UITableViewCell() }
        let attributedText = NSMutableAttributedString(string: presenter.element[indexPath.row].nameTasks)
        
        if presenter.element[indexPath.row].done == false {
            cell.nameItem.attributedText = attributedText
        } else {
            let range = NSRange(location: 0, length: attributedText.length)
            attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue , range: range)
            
            cell.nameItem.attributedText = attributedText
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        presenter.element.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
        
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? ItemTableCell else { return }
        let attributedText = NSMutableAttributedString(string: presenter.element[indexPath.row].nameTasks)
        
        if presenter.element[indexPath.row].done == false {
            presenter.element[indexPath.row].done = true
            
            let range = NSRange(location: 0, length: attributedText.length)
            attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue , range: range)
            
            selectedCell.nameItem.attributedText = attributedText
        } else {
            presenter.element[indexPath.row].done = false
            selectedCell.nameItem.attributedText = attributedText
        }
    }
}

extension ViewController: ViewControllerProtocol {
    func showTasks() {
        tableView.reloadData()
    }
    
    func showAlert() {
        alert()
    }
}
