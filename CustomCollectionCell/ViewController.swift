//
//  ViewController.swift
//  CustomCollectionCell
//
//  Created by Mohan K on 25/11/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collection: UICollectionView!
    
    var models = [
        "Hello world",
        "Hello world",
        "Hello world",
        "Hello world",
        "Hello world"
    ]
    
    var modelsText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            collection.delegate = self
            collection.dataSource = self
        
          
        
        collection.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyCollectionViewCell")
        
        collection.register(HeaderCollectionReusableView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier:  HeaderCollectionReusableView.identifier)
        collection.register(FooterCollectionReusableView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,withReuseIdentifier:  FooterCollectionReusableView.identifier)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        
       
        cell.mylabel?.text = models[indexPath.row]
        
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let modelsSelected = models[indexPath.row]
       
        let dialogMessage=UIAlertController(title: "Edit Operation", message: "Edit and NAME The Operation ",preferredStyle: .alert)
        let update = UIAlertAction(title: "Update", style: .default) {(action) in
            
            let updatedModels = self.modelsText.text
            
            self.models[indexPath.row] = updatedModels ?? ""
            
            DispatchQueue.main.async {
                self.collection.reloadData()
                print("Data has Been Updated")
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            
            self.models.remove(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
            print("Edit operation cancelled by user")
        }
        
        dialogMessage.addAction(update)
        
        dialogMessage.addAction(cancel)
        dialogMessage.addTextField { (textfield) in
            self.modelsText = textfield
            self.modelsText.placeholder = "Update name here"
            self.modelsText.text = modelsSelected
        }
        
        self.present(dialogMessage,animated: true,completion: nil)
      
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    


    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind Kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if Kind == UICollectionView.elementKindSectionFooter {
            
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.identifier, for: indexPath) as! FooterCollectionReusableView

            footer.configure()

            return footer
        }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView

        header.configure()

        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.size.width, height: 200)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.size.width, height: 200)
  }
}
