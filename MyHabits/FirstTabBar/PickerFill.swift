//
//  PickerFill.swift
//  MyHabits
//
//  Created by Pavel Grigorev on 18.11.2022.
//

import Foundation

struct PickerFill {
    var hours: [Int] = []
    var minutes: [Int] = []
    let am: [String] = ["AM", "PM"]
}

var pickerFill: PickerFill = {
    var picker = PickerFill()
    for hour in 1...12 {
        picker.hours.append(hour)
    }

    for minute in 00...59 {
        picker.minutes.append(minute)
    }
    return picker
}()
