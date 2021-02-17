//
//  CreateViewTableDataManager.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import Foundation

public enum FormatType: String {
    case text
    case selector
}

public enum CreateTableDataType: String {
    case name
    case team
    case courage
    case rank
    case skill
    case endurance
    case firepower
    case intelligence
    case speed
    case strength
}

public struct Item {
    var id: Int
    var value: Any
    var type: FormatType
    var dataType: CreateTableDataType
}

public class CreateViewTableDataManager {

    public private(set) var items = [
        Item(id: 0, value: "", type: .text, dataType: .name),
        Item(id: 1, value: "", type: .selector, dataType: .team),
        Item(id: 2, value: AppConstants.defaultSkillValue, type: .selector, dataType: .courage),
        Item(id: 3, value: AppConstants.defaultSkillValue, type: .selector, dataType: .rank),
        Item(id: 4, value: AppConstants.defaultSkillValue, type: .selector, dataType: .skill),
        Item(id: 5, value: AppConstants.defaultSkillValue, type: .selector, dataType: .endurance),
        Item(id: 6, value: AppConstants.defaultSkillValue, type: .selector, dataType: .firepower),
        Item(id: 7, value: AppConstants.defaultSkillValue, type: .selector, dataType: .intelligence),
        Item(id: 8, value: AppConstants.defaultSkillValue, type: .selector, dataType: .speed),
        Item(id: 9, value: AppConstants.defaultSkillValue, type: .selector, dataType: .strength)
    ]

    // MARK: - Public Methods
    public var itemsCount: Int {
        return items.count
    }

    public func item(at index: Int) -> Item {
        return items[index]
    }

    public func update(dataType: CreateTableDataType, value: Any) {
        if let index = items.firstIndex(where: { $0.dataType == dataType }) {
            items[index].value = value
        }
    }

    public func update(selectedIndex: Int, value: Any) {
        if let index = items.firstIndex(where: { $0.id == selectedIndex }) {
            items[index].value = value
        }
    }

    public func getValueForItem(with dataType: CreateTableDataType) -> Any? {
        if let index = items.firstIndex(where: { $0.dataType == dataType }) {
            return items[index].value
        } else {
            return ""
        }
    }

    public func validateSkillsContainsDefaultValue() -> Bool {
        var skills = items
        if let teamIndex = items.firstIndex(where: { $0.dataType == .team}),
           let nameIndex = items.firstIndex(where: { $0.dataType == .name}) {
            skills.remove(at: teamIndex)
            skills.remove(at: nameIndex)
        }

        if let value = skills.compactMap({ $0.value }) as? [Int] {
            return value.contains(AppConstants.defaultSkillValue)
        } else {
            return false
        }
    }

}
