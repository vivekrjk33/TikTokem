//
//  ViewController.swift
//  TikTokem
//
//  Created by Vivek on 07/02/23.
//

import UIKit

class ViewController: UIViewController {

    var videoData =  [Category]()
    
    @IBOutlet weak var mycollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchingData { result in
            
                self.videoData = result
                
                DispatchQueue.main.async {
                    self.mycollectionView.reloadData()
              
        
            }
        }
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        mycollectionView.isPagingEnabled = true
        mycollectionView.setCollectionViewLayout(layout, animated: true)
    }


}

func fetchingData(completion : (_ result : [Category]) -> (Void)) {
    
    guard let fileLocation = Bundle.main.url(forResource: "simple", withExtension: "json") else {return}
    do{
        let data = try Data(contentsOf: fileLocation)
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
          //  print(json)
        
        let decoder = try JSONDecoder().decode(VideoJson.self, from: data)
        completion(decoder.categories)
        //print(decoder)
    }
    catch {
        print("errororooor")
    }
    
}




extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return videoData[section].videos.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as? VideoCollectionViewCell else {
        return UICollectionViewCell()
    }
    let videosData = videoData[indexPath.section].videos[indexPath.row]
    //Data assigning
    
    cell.videos = videosData.sources
    return cell
}
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
}

func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if let cell = cell as? VideoCollectionViewCell {
        cell.play()
    }
}
func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if let cell = cell as? VideoCollectionViewCell
    {
        return cell.pause()
    }
}

}

