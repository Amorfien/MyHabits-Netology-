//
//  HabitsFirstCell.swift
//  MyHabits
//
//  Created by Pavel Grigorev on 19.11.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {

    private let gogoLabel: UILabel = {
        let label = UILabel()
        label.text = "Всё получится!"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var percentLabel: UILabel = {
        let label = UILabel()
        label.text = "50%"
        label.textAlignment = .right
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.progress = 0.734
        progress.progressTintColor = #colorLiteral(red: 0.6906365752, green: 0, blue: 0.8297687173, alpha: 1)
        progress.layer.cornerRadius = 3.5
        progress.clipsToBounds = true
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true
        setupView()
        percentLabel.text = "\(Int((progressView.progress * 100).rounded()))%"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.addSubview(gogoLabel)
        contentView.addSubview(percentLabel)
        contentView.addSubview(progressView)


        NSLayoutConstraint.activate([
//            contentView.heightAnchor.constraint(equalToConstant: 60),

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
}
