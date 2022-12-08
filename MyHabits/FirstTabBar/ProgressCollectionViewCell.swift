//
//  HabitsFirstCell.swift
//  MyHabits
//
//  Created by Pavel Grigorev on 19.11.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {

    // MARK: - UI elements

    private let gogoLabel: UILabel = {
        let label = UILabel()
        label.text = "Всё получится!"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var percentLabel: UILabel = {
        let label = UILabel()
        label.text = "0%"
        label.textAlignment = .right
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.progress = 0
        progress.progressTintColor = #colorLiteral(red: 0.6906365752, green: 0, blue: 0.8297687173, alpha: 1)
        progress.layer.cornerRadius = 3.5
        progress.clipsToBounds = true
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true

        contentView.addSubview(gogoLabel)
        contentView.addSubview(percentLabel)
        contentView.addSubview(progressView)

        NSLayoutConstraint.activate([
            gogoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            gogoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),

            percentLabel.topAnchor.constraint(equalTo: gogoLabel.topAnchor),
            percentLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),

            progressView.topAnchor.constraint(equalTo: gogoLabel.bottomAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: gogoLabel.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: percentLabel.trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 7)
        ])
    }

    // MARK: - Public methods

    func setProgress(percent: Float?) {

        progressView.setProgress(percent ?? 0.999, animated: true)
        percentLabel.text = (percent == nil) ? "Добавьте первую привычку" : "\(Int((percent! * 100).rounded()))%"
        gogoLabel.text = (percent == 1) ? "На сегодня всё!": "Всё получится!"
        
    }

}
