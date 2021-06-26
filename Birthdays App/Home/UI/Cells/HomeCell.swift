//
//  HomeCell.swift
//  Birthdays App
//
//  Created by Josip Marković on 26.06.2021..
//

import Foundation
import UIKit

class HomeCell: UITableViewCell{
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoFontOf(size: 13, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoFontOf(size: 13, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let roundedView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 34.5
        view.backgroundColor = R.color.circle_background()
        return view
    }()
    
    let initialsLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoFontOf(size: 32, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        addSubviews(views: [nameLabel, birthdayLabel, roundedView])
        roundedView.addSubview(initialsLabel)
        selectionStyle = .none
        setupConstraints()
    }
    
    func setupConstraints(){
        roundedView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(14)
            make.width.height.equalTo(69).priority(.high)
        }
        
        initialsLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(roundedView.snp.trailing).offset(14)
            make.top.equalTo(roundedView).offset(4)
            make.trailing.equalToSuperview().inset(16)
        }
        
        birthdayLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
        }
    }
    
    func configure(item: PersonViewItem){
        self.nameLabel.text = item.name
        self.birthdayLabel.text = item.birthday
        self.initialsLabel.text = item.initials
    }
}
