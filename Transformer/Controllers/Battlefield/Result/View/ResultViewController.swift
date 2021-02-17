//
//  ResultViewController.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import UIKit

class ResultViewController: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView! {
        didSet {
            listTableView.tableFooterView = UIView()
            listTableView.separatorStyle = .none
            listTableView.delegate = self
            listTableView.dataSource = self
        }
    }

    // MARK: - Variables
    var viewModel: ResultVM?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModalResponseHandler()
        viewModel?.calculateFinalResults()
    }

    // MARK: - Button Actions
    @IBAction func createBtnAction(_ sender: UIButton) {
        guard let viewController = UIStoryboard.init(name: Storyborad.storyboardUsed(for: .main),
                                                     bundle: Bundle.main).instantiateViewController(withIdentifier:
            CreateViewController.className) as? CreateViewController else {
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}

// MARK: - TableView Delegate and DataSource
extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.battleModel.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: ResultTableCell.self, for: indexPath) as? ResultTableCell
        else { return UITableViewCell() }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        let transformer = viewModel?.battleModel[indexPath.row]
        cell.transformer = transformer

        return cell
    }

}

// MARK: - ViewModal Response Handler
extension ResultViewController {

    func viewModalResponseHandler() {
        viewModel?.userResultListClosure = { (message: String, winner: TransformerResultEnum) in
            DispatchQueue.main.async {
                self.titleLabel.text = message
                if winner == .autobot {
                    self.setBackgroundImage(.autobotBackgrond)
                } else if winner == .decepticon {
                    self.setBackgroundImage(.decepticonBackground)
                } else {
                    self.setBackgroundImage(.warBackground)
                }
                self.listTableView.reloadData()
            }
        }
    }
}
