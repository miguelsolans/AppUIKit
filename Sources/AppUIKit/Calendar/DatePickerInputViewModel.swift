//
//  DatePickerInputViewModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 29/03/2026.
//

import Foundation

/// ViewModel for the DatePicker input
public final class DatePickerInputViewModel: BaseInputViewModel {

    /// Currently selected date
    public var selectedDate: Date {
        didSet {
            onDateChanged?(selectedDate)
        }
    }

    /// Optional minimum date
    public var minDate: Date?

    /// Optional maximum date
    public var maxDate: Date?

    /// Enable/disable interaction
    public var isEditable: Bool

    /// Closure called when date changes
    public var onDateChanged: ((Date) -> Void)?

    public init(
        title: String,
        selectedDate: Date = Date(),
        minDate: Date? = nil,
        maxDate: Date? = nil,
        isEditable: Bool = true,
        placeholder: String? = nil,
        subtitle: String? = nil,
        isMandatory: Bool = false
    ) {
        self.selectedDate = selectedDate
        self.minDate = minDate
        self.maxDate = maxDate
        self.isEditable = isEditable

        super.init(title: title, placeholder: placeholder, subtitle: subtitle, isMandatory: isMandatory)
    }

    /// Format the selected date for display
    public func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: selectedDate)
    }
}
