//
//  ProfileViewController.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import UIKit
import RealmSwift

class ProfileViewController: BaseViewController {
    
    let tableView = UITableView()
    let repository = RealmRepository()
    let list: [String] = ["프로필 이미지 편집", "즐겨찾기 초기화"]
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        super.configureView()
        
        navigationItem.title = "Profile"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            
            cell.profileView.image = loadImageFromDocumentsDirectory() ?? UIImage(named: "defaultProfileImage")
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            cell.textLabel?.text = list[indexPath.item]
            
            return cell
        }
    }
    
    func loadImageFromDocumentsDirectory() -> UIImage? {
        let realm = try! Realm()
        if let userProfile = realm.objects(UserProfile.self).first, let imagePath = userProfile.profileImagePath {
            let filePath = getDocumentsDirectory().appendingPathComponent(imagePath).path
            return UIImage(contentsOfFile: filePath)
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == IndexPath(row: 0, section: 1) {
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            present(self.imagePicker, animated: true)
        } else if indexPath == IndexPath(row: 1, section: 1) {
            let alert = UIAlertController(title: "즐겨찾기를 초기화하시겠습니까?", message: "즐겨찾기 데이터는 삭제됩니다.", preferredStyle: .alert)
            
            let okBtn = UIAlertAction(title: "초기화", style: .default) {_ in
                self.repository.deleteAllItem(ofType: Favorite.self)
            }
            let cancelBtn = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(okBtn)
            alert.addAction(cancelBtn)
            
            present(alert, animated: true)
        }
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage // 수정된 이미지가 있을 경우
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage // 원본 이미지가 있을 경우
        }
        
        picker.dismiss(animated: true) {
            self.tableView.reloadData()
            if let selectedImage = newImage {
                self.saveImageToDocumentsDirectory(image: selectedImage)
            }
        }
    }
    
    func saveImageToDocumentsDirectory(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 1) else { return }
        let fileName = "userProfile.jpg"
        let filePath = self.getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            try imageData.write(to: filePath)
            self.saveImagePathToRealm(filePath.lastPathComponent)
            self.tableView.reloadData() // 이미지 경로를 저장한 후 테이블 뷰를 리로드하여 이미지를 표시
        } catch {
            print(error)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func saveImagePathToRealm(_ fileName: String) {
        let realm = try! Realm()
        try! realm.write {
            let userProfile = UserProfile()
            userProfile.profileImagePath = fileName
            realm.add(userProfile, update: .all)
        }
    }
}
