//
//  DetailsView.swift
//  Birthdays App
//
//  Created by Josip Marković on 26.06.2021..
//

import Foundation
import UIKit

class DetailsView: UIView{
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 36, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let roundedView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 68.5
        view.backgroundColor = R.color.circle_background()
        return view
    }()
    
    let initialsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 64, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let backButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.setTitle(R.string.localizible.go_back().uppercased(), for: .normal)
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        addSubviews(views: [nameLabel, birthdayLabel, roundedView, backButton])
        roundedView.addSubview(initialsLabel)
        setupConstraints()
    }
    
    func setupConstraints(){
        roundedView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(70)
            make.width.height.equalTo(137)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(roundedView.snp.bottom).offset(27)
            make.centerX.equalToSuperview()
        }
        
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        initialsLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(birthdayLabel.snp.bottom).offset(30)
            make.height.equalTo(52)
            make.bottom.equalToSuperview()
        }
    }
    
    
    func configure(with item: PersonViewItem){
        initialsLabel.text = item.initials
        birthdayLabel.text = item.birthday
        nameLabel.text = item.name
    }
}
