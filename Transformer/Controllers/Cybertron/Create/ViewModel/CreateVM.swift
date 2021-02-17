//
//  CreateVM.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import Foundation
import ProgressHUD

class CreateVM {

    // MARK: - Variables
    var dataManager: CreateViewTableDataManager?
    var pickerArray: Array = [String]()
    var selectedPickerValue = ""
    var selectedRow: Int?

    var operation: CreateOperation?
    var transformerData: TransformerListItems?
    var networkManager: NetworkManagerProtocol = NetworkManager()

    // MARK: - Closures
    var transformerCreationStatusClosure: ((Bool, String) -> Void)?
    var validationStatusClosure: ((Bool, String) -> Void)?
    var reloadDataClosure: (() -> Void)?
    var reloadRowClosure: ((Int) -> Void)?

    // MARK: Initilisation
    init(operation: CreateOperation, transformerData: TransformerListItems?) {
        self.operation = operation
        self.transformerData = transformerData
        self.dataManager = CreateViewTableDataManager()
    }

    // MARK: Function
    func saveSkillsValue() {
        if let indexRow = selectedRow {
            if let item = dataManager?.item(at: selectedRow ?? 0),
               ((item.dataType != .team) && (item.type == .selector)) {
                dataManager?.update(selectedIndex: indexRow, value: Int(selectedPickerValue) ?? 0)
            } else {
                dataManager?.update(selectedIndex: indexRow, value: selectedPickerValue)
            }
            self.reloadRowClosure?(indexRow)
        }
    }

    func changePickerData(with data: CreateTableDataType) {
        if data == .team {
            pickerArray = AppConstants.transformersValueArray
        } else {
            pickerArray = AppConstants.skillsValueArray
        }
    }

    func checkOperation() {
        if operation == .edit {
            dataManager?.update(dataType: .name, value: transformerData?.name ?? "")
            dataManager?.update(dataType: .courage, value: transformerData?.courage ?? 0)
            dataManager?.update(dataType: .endurance, value: transformerData?.endurance ?? 0)
            dataManager?.update(dataType: .firepower, value: transformerData?.firepower ?? 0)
            dataManager?.update(dataType: .intelligence, value: transformerData?.intelligence ?? 0)
            dataManager?.update(dataType: .rank, value: transformerData?.rank ?? 0)
            dataManager?.update(dataType: .speed, value: transformerData?.speed ?? 0)
            dataManager?.update(dataType: .strength, value: transformerData?.strength ?? 0)
            dataManager?.update(dataType: .skill, value: transformerData?.skill ?? 0)

            if (transformerData?.team) == Team.autobots {
                dataManager?.update(dataType: .team, value: AppConstants.autobots)
            } else {
                dataManager?.update(dataType: .team, value: AppConstants.decepticons)
            }
            self.reloadDataClosure?()
        }
    }

    func addTransformer() {
        if !validateTransformer() {
            return
        }

        var parameters = [String: Any]()
        parameters[CreateTranformerParams.courage] = (dataManager?.getValueForItem(with: .courage) as? Int)
        parameters[CreateTranformerParams.endurance] = (dataManager?.getValueForItem(with: .endurance) as? Int)
        parameters[CreateTranformerParams.firepower] = (dataManager?.getValueForItem(with: .firepower) as? Int)
        parameters[CreateTranformerParams.intelligence] = (dataManager?.getValueForItem(with: .intelligence) as? Int)
        parameters[CreateTranformerParams.rank] = (dataManager?.getValueForItem(with: .rank) as? Int)
        parameters[CreateTranformerParams.speed] = (dataManager?.getValueForItem(with: .speed) as? Int)
        parameters[CreateTranformerParams.strength] = (dataManager?.getValueForItem(with: .strength) as? Int)
        parameters[CreateTranformerParams.skill] = (dataManager?.getValueForItem(with: .skill) as? Int)
        parameters[CreateTranformerParams.name] = (dataManager?.getValueForItem(with: .name) as? String)

        if (dataManager?.getValueForItem(with: .team) as? String) == AppConstants.autobots {
            parameters[CreateTranformerParams.team] = Team.autobots.rawValue
        } else if (dataManager?.getValueForItem(with: .team) as? String) == AppConstants.decepticons {
            parameters[CreateTranformerParams.team] = Team.decepticons.rawValue
        }

        if operation == .edit {
            parameters[CreateTranformerParams.id] = transformerData?.id
        }
        sendData(with: parameters)
    }

    // MARK: VC Function
    func validateTransformer() -> Bool {
        if let name = (dataManager?.getValueForItem(with: .name) as? String),
           name == "" {
            self.validationStatusClosure?(false, AppStrings.Alert.selectName)
            return false

        } else if let type = (dataManager?.getValueForItem(with: .team) as? String),
                 type == "" {
            self.validationStatusClosure?(false, AppStrings.Alert.selectType)
            return false

        } else if let validationFail = (dataManager?.validateSkillsContainsDefaultValue()),
                 validationFail == true {
            self.validationStatusClosure?(false, AppStrings.Alert.selectSkill)
            return false
        } else {
            return true
        }
    }

    func sendData(with parameters: [String: Any]) {
        var callType: ServiceType = .addData
        switch operation {
        case .add:
            callType = .addData
        case .edit:
            callType = .editData
        case .none:
            callType = .addData
        }
        self.handleNetWorkCall(dict: parameters, callType: callType)
    }

    func handleNetWorkCall(dict: [String: Any], callType: ServiceType) {
        ProgressHUD.show()
        networkManager.getDataFromServiceApi(type: Transformer.self,
                                      call: callType, postData: dict) { [weak self] (_, error)  in
            DispatchQueue.main.async {
                ProgressHUD.dismiss()
                if error != nil {
                    self?.transformerCreationStatusClosure?(false, AppStrings.Alert.selectSkill)
                } else {
                    self?.transformerCreationStatusClosure?(true, (self?.operation == .edit ?
                                                                    AppStrings.Alert.transformerEditedSuccesfully :
                                                                    AppStrings.Alert.transformerAddedSuccesfully))
                }

            }
        }
    }
}
