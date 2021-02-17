//
//  CybertronListVM.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import UIKit
import ProgressHUD

protocol CybertronListVMDelegate: class {
    func userListApiDidFinish(success: Bool, message: String?)
}

enum CreateOperation {
    case add
    case edit
}

class CybertronListVM {

    // MARK: - Variables
    var items = [TransformerListItems]()
    var networkManager: NetworkManagerProtocol = NetworkManager()
    weak var delegate: CybertronListVMDelegate?

    // MARK: Initilisation
    init(delegate: CybertronListVMDelegate) {
        self.delegate = delegate
    }

    // MARK: - API calls
    func fetchTransformers() {
        ProgressHUD.show()
        networkManager.getDataFromServiceApi(type: TransformerModel.self,
                                      call: .getData, postData: nil) { [weak self] (jsonData, error)  in
            DispatchQueue.main.async {

            ProgressHUD.dismiss()
            self?.items.removeAll()
            guard error == nil else {
                self?.delegate?.userListApiDidFinish(success: false, message: AppStrings.Alert.somethingWentWrong)
                return
            }
            guard let jsonData = jsonData, jsonData.transformers.count > 0 else {
                self?.delegate?.userListApiDidFinish(success: false, message: AppStrings.Alert.noData)
                return
            }
            self?.items = jsonData.transformers.map({return TransformerListItems(transformer: $0)})

            self?.delegate?.userListApiDidFinish(success: true, message: "")
            }
        }
    }

    func deleteTransformer(id: String) {
        ProgressHUD.show()
        networkManager.getDataFromServiceApi(type: EmptyTransformerModel.self, call: .deleteData,
                                      postData: [CreateTranformerParams.id: id]) { [weak self] (_, _)  in
        self?.fetchTransformers()
        }
    }
}
