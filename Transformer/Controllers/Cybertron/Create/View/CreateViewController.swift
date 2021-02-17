//
//  CreateViewController.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import UIKit

class CreateViewController: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var pickerDoneBtn: UIButton!
    @IBOutlet weak var picker: UIPickerView! {
        didSet {
            picker.showsSelectionIndicator = true
            picker.delegate = self
            picker.dataSource = self
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    // MARK: - Variables
    var viewModel: CreateVM?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage(.createBackgound)
        pickerView.isHidden = true
        tableView.reloadData()
        viewModalResponseHandler()
        viewModel?.checkOperation()
    }

    // MARK: - Button Actions
    @IBAction func saveBtnAction(_ sender: UIButton) {
        self.view.endEditing(true)
        viewModel?.addTransformer()
    }

    @IBAction func pickerDoneBtnAction(_ sender: UIButton) {
        showPickerView(false)
        viewModel?.saveSkillsValue()
    }

    func showPickerView(_ show: Bool) {
        pickerView.isHidden = !show
    }

}

// MARK: - TableView Delegate and DataSource
extension CreateViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataManager?.itemsCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let itemscount = viewModel?.dataManager?.itemsCount,
              itemscount > 0,
              let item = viewModel?.dataManager?.item(at: indexPath.row) else { return UITableViewCell() }

        switch item.type {
        case .text:
            guard let cell = tableView.dequeueCell(withType: CreateTextTableCell.self,
                                                   for: indexPath) as? CreateTextTableCell
            else { return UITableViewCell() }
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.item = item
            cell.delegate = self

            return cell

        case .selector:
            guard let cell = tableView.dequeueCell(withType: CreateSelectTableCell.self,
                                                   for: indexPath) as? CreateSelectTableCell
            else { return UITableViewCell() }
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.item = item

            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if pickerView.isHidden == false {
            self.showAlert(title: AppStrings.Alert.alertTitle, message: AppStrings.Alert.selectValue, completion: nil)
            return
        }
        guard let item = viewModel?.dataManager?.item(at: indexPath.row),
              item.type == .selector else { return }
        viewModel?.selectedRow = indexPath.row
        self.view.endEditing(true)
        viewModel?.changePickerData(with: item.dataType)
        picker.selectRow(0, inComponent: 0, animated: false)
        picker.reloadAllComponents()
        showPickerView(true)
    }

}

// MARK: - PickerView Delegates
extension CreateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.pickerArray.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel?.selectedPickerValue = viewModel?.pickerArray[0] ?? ""
        return viewModel?.pickerArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel?.selectedPickerValue = viewModel?.pickerArray[row] ?? ""
    }
}

// MARK: - ViewModal Response Handler
extension CreateViewController {
    func viewModalResponseHandler() {

        viewModel?.transformerCreationStatusClosure = { (success: Bool, message: String) in
            DispatchQueue.main.async {
                self.showAlert(title: (success == true ? AppStrings.Alert.success : AppStrings.Alert.fail),
                               message: message) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }

        viewModel?.validationStatusClosure = { (_: Bool, message: String) in
            DispatchQueue.main.async {
                self.showAlert(title: "", message: message, completion: nil)
            }
        }

        viewModel?.reloadDataClosure = { () in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        viewModel?.reloadRowClosure = { (row: Int) in
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: row, section: 0)
                self.tableView.reloadRows(at: [indexPath], with: .none)
            }
        }

    }
}

// MARK: - CreateTextTableCell Delegate
extension CreateViewController: CreateTextTableCellDelegate {
    func saveTransformerName(with name: String) {
        self.view.endEditing(true)
        viewModel?.dataManager?.update(dataType: .name, value: name)
    }
}
