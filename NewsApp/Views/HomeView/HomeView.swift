//
//  HomeView.swift
//  NewsApp
//
//  Created by Mert Karahan on 28.06.2022.
//

import UIKit
import ActionSheetPicker_3_0


protocol AnyHomeView {
    var presenter: AnyHomePeresenter? {get set}
    
    func update()
    func update(with error: String)
}


class HomeView: UIViewController, AnyHomeView {
    
    
    var presenter : AnyHomePeresenter?
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        presenter?.getGeneralNewsTr()
        self.homeCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        setNavigationController()
    }
    
    private func setNavigationController() {
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.grid.2x2"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(viewChange))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(setActionSheet))
    }
    
    @objc func viewChange() {
        presenter?.changeView()
        homeCollectionView.reloadData()
    }
    
    @objc func setActionSheet(_ sender: UIBarButtonItem) {
        ActionSheetMultipleStringPicker.show(
            withTitle: "Settings",
            rows: [
                presenter?.countryList ?? [],
                presenter?.categoryList ?? []
            ],
            initialSelection: [2, 2],
            doneBlock: { picker, indexes, values in
                let selections = values as? [String]
                self.presenter?.selectedCountry = selections?[0] ?? ""
                self.presenter?.selectedCategory = selections?[1] ?? ""
                self.presenter?.refreshList()
                
                
            },
            cancel: { ActionMultipleStringCancelBlock in return
                
            },
            origin: sender)
    }
    
    func update() {
        print(#function)
        DispatchQueue.main.async {
            self.homeCollectionView.reloadData()
        }
    }
    
    func update(with error: String) {
        print(error)
    }
}



extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        if let newsItem = presenter?.item(at: indexPath){
            
            cell.configure(newsItem: newsItem)
        }
        //        guard let data = presenter?.item(at: indexPath) else { return UITableViewCell() }
        //        var config = cell?.defaultContentConfiguration()
        //        config.text = data.title
        //        cell?.contentConfiguration = config
        //        return cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.getDetailsFromHomeRouter(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch presenter?.viewType ?? .tableView {
        case.collectionView:
            //        Her bir cellin boyutunu belirleme
            let cellWidth = (UIScreen.main.bounds.width - 10) / 2
            return CGSize(width: cellWidth, height: cellWidth * 1.3)
            
        case.tableView:
            //        Her bir cellin boyutunu belirleme
            let cellWidth = (UIScreen.main.bounds.width)
            return CGSize(width: cellWidth, height: cellWidth * 0.6)
        }
        
    }
}


