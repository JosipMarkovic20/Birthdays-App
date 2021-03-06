//
//  HomeViewController.swift
//  Birthdays App
//
//  Created by Josip Marković on 26.06.2021..
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

public final class HomeViewController: UIViewController, UITableViewDelegate, LoaderProtocol {
    private let viewModel: HomeViewModel!
    var dataSource: RxTableViewSectionedAnimatedDataSource<HomeSectionItem>!
    
    public let tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        return view
    }()
    
    weak var homeNavigationDelegate: HomeNavigationDelegate?

    public let disposeBag = DisposeBag()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.bindDataSource()
        viewModel.input.onNext(.loadData)
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    func setupNavigationBar(){
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor.white
    }
}

extension HomeViewController {
    
    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupConstraints()
        registerCells()
        self.title = R.string.localizible.birthdays()
        let attributes = [NSAttributedString.Key.font: UIFont.robotoFontOf(size: 18, weight: .bold)]
        UINavigationBar.appearance().titleTextAttributes = attributes
    }

    
    func setupConstraints(){
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func registerCells(){
        self.tableView.register(HomeCell.self, forCellReuseIdentifier: "HomeCell")
    }
    
    func bindDataSource(){
        disposeBag.insert(viewModel.bindViewModel())
        
        dataSource = RxTableViewSectionedAnimatedDataSource<HomeSectionItem>{ (dataSource, tableView, indexPath, rowItem) -> UITableViewCell in
            let item = dataSource[indexPath.section].items[indexPath.row]
            let cell: HomeCell = tableView.dequeueCell(identifier: "HomeCell")
            if let safeItem = item as? HomeItem{
                cell.configure(item: safeItem.item)
            }
            return cell
        }
        self.dataSource.animationConfiguration = .init(insertAnimation: .top, reloadAnimation: .fade, deleteAnimation: .automatic)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.output
            .map({ $0.items })
            .bind(to: tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
        
        viewModel.output
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[unowned self] (output) in
                guard let safeEvent = output.event else { return }
                switch safeEvent{
                case .openDetails(let person):
                    homeNavigationDelegate?.navigateToDetails(person: person)
                case .error(let message):
                    showAlertWith(title: R.string.localizible.error(), message: message)
                case .reloadData:
                    tableView.reloadData()
                }
            }).disposed(by: disposeBag)
        
        viewModel.loaderPublisher
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[unowned self] (shouldShowLoader) in
                if shouldShowLoader{
                    showLoader()
                }else{
                    hideLoader()
                }
            }).disposed(by: disposeBag)
    
        
        tableView.rx.itemSelected
            .map({ HomeInput.personClicked(indexPath: $0)})
            .bind(to: viewModel.input)
            .disposed(by: disposeBag)
    }
}
