//
//  CybertronListViewController.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import UIKit

class CybertronListViewController: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var listTableView: UITableView! {
        didSet {
            listTableView.tableFooterView = UIView()
            listTableView.separatorStyle = .none
            listTableView.delegate = self
            listTableView.dataSource = self
        }
    }

    // MARK: - Variables
    var viewModel: CybertronListVM?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CybertronListVM(delegate: self)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBackgroundImage(.createBackgound)
        viewModel?.fetchTransformers()
    }

    // MARK: - Button Actions
    @IBAction func createBtnAction(_ sender: UIButton) {
        self.pushToCreateOREditTransformer(with: nil, operation: .add)
    }

    // MARK: - Private functions
    private func pushToCreateOREditTransformer(with transformerData: TransformerListItems?,
                                               operation: CreateOperation) {
        guard let viewController = UIStoryboard.init(name: Storyborad.storyboardUsed(for: .main),
                                                     bundle: Bundle.main).instantiateViewController(withIdentifier:
            CreateViewController.className) as? CreateViewController else {
            return
        }
        viewController.viewModel = CreateVM(operation: operation, transformerData: transformerData)
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}

// MARK: - TableView Delegate and DataSource
extension CybertronListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: CybertronListTableCell.self,
                                               for: indexPath) as? CybertronListTableCell
        else { return UITableViewCell() }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        let transformer = viewModel?.items[indexPath.row]
        cell.transformer = transformer
        return cell
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive,
                                                title: AppStrings.Cybertron.delete) { _, _ in
            self.viewModel?.deleteTransformer(id: self.viewModel?.items[indexPath.row].id ?? "")
        }
        let data = self.viewModel?.items[indexPath.row]
        let editAction = UITableViewRowAction(style: .normal,
                                              title: AppStrings.Cybertron.edit) { _, _ in
            self.pushToCreateOREditTransformer(with: data, operation: .edit)
        }
        editAction.backgroundColor = .appGreyColor
        return [deleteAction, editAction]
    }

}

// MARK: - Custom Delegates
extension CybertronListViewController: CybertronListVMDelegate {
    func userListApiDidFinish(success: Bool, message: String?) {
        self.listTableView.setEmptyView(with: !success, message: message ?? AppStrings.Alert.noData)
        listTableView.reloadData()
    }
}
