//
//  TagViewController.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 9/18/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol TagViewControllerDelegate: class {
    func didAdd(_ tags: [String])
}

class TagViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let disposeBag = DisposeBag()
    let viewModel = TagViewModel()
    
    weak var delegate: TagViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let journal = viewModel.journal {
            viewModel.tags = journal.tags.toArray()
        }
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func binding() {
        searchBar.rx.text.orEmpty.throttle(0.3, scheduler: MainScheduler.instance).subscribe(onNext: {
            tag in
            print(tag)
        }).disposed(by: disposeBag)
    }
    
    @IBAction func onAddTap(_ sender: UIButton) {
        if let text = searchBar.text, !text.isEmpty {
            viewModel.tags.append(text)
            searchBar.text = ""
            tableView.reloadData()
        }
    }
    
    @IBAction func onDoneTap(_ sender: UIBarButtonItem) {
        delegate?.didAdd(viewModel.tags)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancelTap(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension TagViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell") as! TagCell
        cell.configCell(at: indexPath.row, tag: viewModel.tags[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40*ratio
    }
}

extension TagViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
           viewModel.tags.append(viewModel.findAndRemoveSpace(text: text.lowercased()))
            searchBar.text = ""
            tableView.reloadData()
        }
    }
}

extension TagViewController: TagCellDelegate {
    func didDeleteTagAt(_ index: Int) {
        viewModel.tags.remove(at: index)
        tableView.reloadData()
    }
}
