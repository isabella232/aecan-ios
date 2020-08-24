//
//  SelectorDialogViewController.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

enum SelectorDialogMode {
    case singleSelection
    case multipleSelection
    case readOnly
}

protocol SelectorDialogOption: AnyObject {
    var textForSelector: String? { get }
}

protocol SelectorDialogDelegate: class {
    func selector(dialog: SelectorDialogViewController, didTapButtonWith selectedOptions: [SelectorDialogOption])
}

class SelectorDialogViewController: ModalViewController {
    
    // Constants
    private var maximumTableViewHeight: CGFloat = 226
    
    // Properties
    var mode: SelectorDialogMode = .multipleSelection
    var options: [SelectorDialogOption] = [] {
        didSet { reloadData() }
    }
    var preselectedOptions: [SelectorDialogOption] = [] {
        didSet { reloadData() }
    }
    private var selectedOptions: [SelectorDialogOption] {
        return (tableView?.indexPathsForSelectedRows ?? []).map { (indexPath) -> SelectorDialogOption in
            return options[indexPath.row]
        }
    }
    
    // Outlets
    @IBOutlet private var tableView: UITableView?
    @IBOutlet private var tableViewHeightConstranint: NSLayoutConstraint?
    
    // Delegate
    weak var delegate: SelectorDialogDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    private func setupTable() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UINib(nibName: "SelectorDialogCell", bundle: .main), forCellReuseIdentifier: "cell")
        tableView?.separatorColor = .clear
        tableView?.tableFooterView = UIView()
        tableView?.rowHeight = 50
        
        tableView?.allowsSelection = false
        tableView?.allowsMultipleSelection = false
        if mode == .singleSelection {
            tableView?.allowsSelection = true
        }
        if mode == .multipleSelection {
            tableView?.allowsMultipleSelection = true
        }
    }
    
    private func reloadData() {
        tableView?.reloadData()
        preselectedOptions.forEach { (option) in
            if let index = self.options.firstIndex(where: { $0 === option }) {
                let indexPath = IndexPath(row: index, section: 0)
                DispatchQueue.main.async {
                    self.tableView?.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                }
            }
        }
        resizeTable()
    }
    
    private func resizeTable() {
        var newSize = maximumTableViewHeight
        
        if let contentSize = tableView?.contentSize.height, contentSize < newSize {
            let topInset = tableView?.contentInset.top ?? 0
            let bottomInset = tableView?.contentInset.bottom ?? 0
            
            newSize = contentSize + topInset + bottomInset + 20
        }
        tableViewHeightConstranint?.constant = newSize
        view.setNeedsUpdateConstraints()
    }
    
    override func buttonTapped() {
        super.buttonTapped()
        delegate?.selector(dialog: self, didTapButtonWith: selectedOptions)
    }
}

extension SelectorDialogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        log.debug(selectedOptions)
    }
}

extension SelectorDialogViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = options[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SelectorDialogCell {
            cell.labelText = option.textForSelector
            return cell
        }
        return UITableViewCell()
    }
}
