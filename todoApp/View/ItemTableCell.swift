//
//  ItemTableCell.swift
//  todoApp
//
//  Created by admin1 on 12.07.23.
//

import UIKit

final class ItemTableCell: UITableViewCell {
    let nameItem: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 30)
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureItemTableCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureItemTableCell()
    }
}

extension ItemTableCell {
    private func configureItemTableCell() {
        contentView.addSubview(nameItem)
        nameItem.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameItem.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameItem.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameItem.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
        
       
        
        //nameItem.layer.addSublayer(lineLayer)
    }
}
