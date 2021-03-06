//
//  AlarmTableViewCell.swift
//  Clock-iOS
//
//  Created by Julien Cohard on 18/11/2021.
//

import UIKit

class UIAlarmTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var daysLabel: UILabel!
    @IBOutlet private weak var enabledSwitch: UISwitch!
    public var alarm: Alarm!
    
    /**
     Set weither the alarm is selected or not
     */
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    /**
     Set the name of the alarm
     */
    public func setName(name: String) {
        nameLabel.text = name
    }

    /**
     Set the time of the alarm from an ISO date
     */
    public func setTime(isoDate: String) {
        let dateFormatter = DateFormatter()
        // Parse date
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ";
        let date = dateFormatter.date(from: isoDate)!
        // Set text value
        dateFormatter.dateFormat = "HH:mm"
        timeLabel.text = dateFormatter.string(from: date)
    }
    
    private func updateBackground(enabled: Bool) {
        nameLabel.isEnabled = enabled
        timeLabel.isEnabled = enabled
        daysLabel.isEnabled = enabled
        contentView.backgroundColor = enabled ? UIColor.systemGray5 : UIColor.systemGray4
    }
    
    public func setEnabled(enabled: Bool) {
        enabledSwitch.setOn(enabled, animated: true)
        updateBackground(enabled: enabled)
    }
    
    /**
     Sets the color of daysLabel according to the days array
     */
    public func setDays(days: [Bool]) {
        // UIFont font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)
        let daysString = NSMutableAttributedString(string: daysLabel.text!)
        for (i, dayEnabled) in days.enumerated() {
            daysString.addAttribute(NSAttributedString.Key.foregroundColor, value: dayEnabled ? UIColor.systemBlue : UIColor.gray, range: NSRange(location: i * 2, length: 1))
        }
        daysLabel.attributedText = daysString
    }
    
    /**
     Toggle and save the state of the alarm when the toggled button changes
     */
    @IBAction func switchChanged() {
        alarm.enabled = enabledSwitch.isOn
        alarm.commit()
        updateBackground(enabled: enabledSwitch.isOn)
        print("Switch changed")
    }
    
}
