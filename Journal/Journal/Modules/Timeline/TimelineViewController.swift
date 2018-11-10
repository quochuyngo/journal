//
//  TimelineViewController.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 4/23/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit
import GooglePlaces
import RealmSwift
import Agrume
import FirebaseAnalytics
class TimelineViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var locationManager: CLLocationManager = CLLocationManager()
    
    let viewModel: TimelineViewModel = TimelineViewModel(databaseManager: DBManager.default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        setupTableView()
        if let customTabBar = tabBarController?.tabBar as? CustomTabBar {
            customTabBar.customDelegate = self
        }
        handleActionSelected()

        Analytics.setScreenName(String(describing:TimelineViewController.self), screenClass: TimelineViewController.description())
    }
    
    override func didReceiveMemoryWarning() {
        print("Out of memory")
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset = UIEdgeInsetsMake(8, 0, 8, 0)
        tableView.register(UINib(nibName: String(describing: JournalMediaCell.self), bundle: nil), forCellReuseIdentifier: String(describing: JournalMediaCell.self))
        tableView.register(UINib(nibName: String(describing: JournalPlainTextCell.self), bundle: nil), forCellReuseIdentifier: String(describing: JournalPlainTextCell.self))
    }


    @IBAction func addNewJournal(_ sender: UIButton) {
        let nav = StoryboardManager.Main.getNewPostVC()
        if let vc = nav.viewControllers.first as? NewJournalViewController {
            vc.delegate = self
        }
        present(nav, animated: true, completion: nil)
    }
    
    func handleActionSelected() {
        ActionSheetManager.actionDidSelect = { action in
            switch action {
            case .edit(let journal):
                let nav = StoryboardManager.Main.getNewPostVC()
                if let vc = nav.viewControllers.first as? NewJournalViewController {
                    vc.delegate = self
                    vc.viewModel.editJournal = journal
                }
                self.present(nav, animated: true, completion: nil)
                break
            case .delete(let journal):
                self.present(AlertManager.getAlert(withType: .delete, handler: {
                    result in
                    switch result {
                    case .yes:
                        self.viewModel.delete(journal)
                        self.tableView.reloadData()
                        break
                    default:
                        break
                    }
                }), animated: true, completion: nil)
              
                break
            default:
                break
            }
        }
    }
}

extension TimelineViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.journalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let journal = viewModel.journalList[indexPath.row]
        var cell = JournalCell()
        if journal.imagesName.count > 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: JournalMediaCell.self), for: indexPath) as! JournalMediaCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: JournalPlainTextCell.self),  for: indexPath) as! JournalPlainTextCell
        }
        cell.configCell(at: indexPath.row, with: journal)
        cell.delegate = self
        return cell
    }
    
}
extension TimelineViewController: CustomBarDelegate {
    func tabBar(_ tabBar: UITabBar, didTapCenterButton: UIButton) {
        let nav = StoryboardManager.Main.getNewPostVC()
        if let vc = nav.viewControllers.first as? NewJournalViewController {
            vc.delegate = self
        }
        present(nav, animated: true, completion: nil)
    }
}

extension TimelineViewController: NewJournalViewControllerDelegate {
    func didAddJournal(_ journal: Journal?) {
        tableView.reloadData()
    }
}

extension TimelineViewController: JournalCellDelegate {
    func moreButtonDidTap(_ journal: Journal) {
        present(ActionSheetManager.getActionSheet(withType: .more, journal), animated: true, completion: nil)
    }
    
    func photoDidTapAt(_ index: Int) {
        viewModel.selectedIndex = index
        
        let barButton = UIBarButtonItem(image:  UIImage(named: "ic_cancel_x"), style: .plain, target: self, action: nil)
        barButton.tintColor = UIColor.white
        let agrume = Agrume(images: viewModel.journalList[index].photos, startIndex: 0, background: .colored(UIColor(red: 0, green: 0, blue: 0, alpha: 0.96)), dismissal: .withButton(barButton))
        agrume.show(from: self)
    }
}
