//
//  ChartViewController.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import UIKit
import Kingfisher
import Charts
import DGCharts
import Toast

class CircleMarker: MarkerView {
    var color: UIColor = .accent
    var radius: CGFloat = 5

    override func draw(context: CGContext, point: CGPoint) {
        super.draw(context: context, point: point)

        // 마커의 배경 원 그리기
        context.setFillColor(color.cgColor)
        context.beginPath()
        context.addArc(center: point, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        context.fillPath()
    }
}

class ChartViewController: BaseViewController {
    
    // 데이터를 불러오기 위한 id 받기
    var ids: String = ""
    
    let viewModel = ChartViewModel()
    let repository = RealmRepository()
    
    // 화면 그리기 요소들
    let image = UIImageView() // 코인 아이콘 리소스
    let name = UILabel() // 코인 이름
    let current_price = UILabel() // 코인 현재가
    let price_change_percentage_24h = UILabel() // 코인 변동폭
    let updateLabel = UILabel() // 업데이트 시간
    
    // collectionView
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
    
    // Data -> collectionView
    var marketData: [(name: String, value: String)] = [
        (name: "고가", value: "dummy"),
        (name: "저가", value: "dummy"),
        (name: "신고점", value: "dummy"),
        (name: "신저점", value: "dummy")
    ]
    
    // DG 차트
    private var coinChartView = LineChartView()
    var chartValue: [Double] = []
    
    private var stopLoadingData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAndScheduleData()
    }
    
    func loadAndScheduleData() {
        viewModel.fetchData(id: ids)
        viewModel.resultData.bind { value in
            guard let value = value else { return }
            self.image.kf.setImage(with: URL(string: value[0].image))
            self.name.text = value[0].name
            self.current_price.text = value[0].current_price.formattedWon()
            self.price_change_percentage_24h.text = value[0].price_change_percentage_24h.formattedPercent()
            self.price_change_percentage_24h.textColor = value[0].price_change_percentage_24h.isPositive() ? .redLabel : .blueLabel
            self.chartValue = value[0].sparkline_in_7d.price
            self.updateLabel.text = value[0].last_updated.formattedDateString() + " 업데이트"
            self.marketData[0].value = value[0].high_24h.formattedWon()
            self.marketData[1].value = value[0].low_24h.formattedWon()
            self.marketData[2].value = value[0].ath.formattedWon()
            self.marketData[3].value = value[0].atl.formattedWon()
            self.collectionView.reloadData()
            self.setData()
        }
        guard !self.stopLoadingData else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.loadAndScheduleData()
            print("!!!")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopLoadingData = true
    }
    
    override func configureHierarchy() {
        view.addSubview(image)
        view.addSubview(name)
        view.addSubview(current_price)
        view.addSubview(price_change_percentage_24h)
        view.addSubview(collectionView)
        view.addSubview(coinChartView)
        view.addSubview(updateLabel)
    }
    
    override func configureView() {
        super.configureView()
        navigationController?.navigationBar.prefersLargeTitles = false
        let rightBarBtnItem = UIBarButtonItem(image: repository.isFavorite(coinID: ids) ? .btnStar : .btnStarFill,
                                              style: .plain,
                                              target: self,
                                              action: #selector(tapRightNavBtn))
        navigationItem.rightBarButtonItem = rightBarBtnItem
        
        // CoinName
        name.text = "코인 이름"
        name.textColor = .mainLabel
        name.font = .systemFont(ofSize: 32, weight: .black)
        
        current_price.text = "코인 현재가"
        current_price.textColor = .mainLabel
        current_price.font = .systemFont(ofSize: 32, weight: .black)
        
        price_change_percentage_24h.text = "코인 변동폭"
        
        // collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChartsInfoCollectionViewCell.self, forCellWithReuseIdentifier: "ChartsInfoCollectionViewCell")
        
        // 차트 뷰
        coinChartView.backgroundColor = .clear
        coinChartView.extraLeftOffset = 0
        coinChartView.extraTopOffset = 0
        coinChartView.extraRightOffset = 0
        coinChartView.extraBottomOffset = 0
        coinChartView.rightAxis.enabled = false
        coinChartView.leftAxis.enabled = false
        coinChartView.chartDescription.enabled = false
        coinChartView.xAxis.enabled = false
        coinChartView.legend.enabled = false
        coinChartView.pinchZoomEnabled = false
        coinChartView.doubleTapToZoomEnabled = false
        coinChartView.delegate = self
        
        //
        updateLabel.textColor = .subLabel
        
    }
    
    @objc private func tapRightNavBtn() {
        if repository.isFavorite(coinID: ids) { if repository.canAddFavorite(){
            view.makeToast("즐겨찾기에 추가 됐습니다.")
            navigationItem.rightBarButtonItem?.image = UIImage(resource: .btnStarFill)
        } else {
            view.makeToast("즐겨찾기는 최대 10개까지 가능합니다")
        }
        } else {
            view.makeToast("즐겨찾기가 해제 됐습니다.")
            navigationItem.rightBarButtonItem?.image = UIImage(resource:.btnStar)
        }
        
        repository.toggleFavorite(coinID: ids)
    }
    
    override func setConstraints() {
        image.snp.makeConstraints {
            $0.left.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.size.equalTo(40)
        }
        name.snp.makeConstraints {
            $0.left.equalTo(image.snp.right).offset(10)
            $0.centerY.equalTo(image)
        }
        current_price.snp.makeConstraints {
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.top.equalTo(name.snp.bottom).offset(10)
        }
        price_change_percentage_24h.snp.makeConstraints {
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.top.equalTo(current_price.snp.bottom).offset(5)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(price_change_percentage_24h.snp.bottom).offset(20)
            $0.height.equalTo(130)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        coinChartView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(-10)
            $0.bottom.equalTo(updateLabel.snp.top)
            $0.height.equalTo(coinChartView.snp.width)
        }
        updateLabel.snp.makeConstraints {
            $0.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(coinChartView.snp.bottom)
        }
    }
    
    static func setCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width/2 - 20, height: 120 / 2)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        return layout
    }
    
}

// MARK: - CollectionView Delegate & Datasource
extension ChartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return marketData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartsInfoCollectionViewCell", for: indexPath) as! ChartsInfoCollectionViewCell
        
        cell.titleLabel.textColor = indexPath.item % 2 == 0 ? .redLabel : .blueLabel
        cell.titleLabel.text = marketData[indexPath.item].name
        cell.descriptionLabel.text = marketData[indexPath.item].value
        
        return cell
    }
}

// MARK: - ChartViewDelegate
extension ChartViewController: ChartViewDelegate {
    
    func setData() {
        var datas: [ChartDataEntry] = []
        
        for (index, value) in chartValue.enumerated() {
            let entry = ChartDataEntry(x: Double(index), y: value)
            datas.append(entry)
        }
        
        // LineChartDataSet
        let dataSet = LineChartDataSet(entries: datas, label: "Your Label Here")
        dataSet.drawCirclesEnabled = false
        dataSet.mode = .cubicBezier
        let gradientColors = [UIColor.accent.cgColor, UIColor.background.cgColor] as CFArray
        let colorLocations:[CGFloat] = [1.0, 0.0]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: colorLocations)!
        dataSet.fill = LinearGradientFill(gradient: gradient, angle: 90)
        dataSet.fillAlpha = 1
        dataSet.lineWidth = 2
        dataSet.setColor(.accent)
        dataSet.drawFilledEnabled = true
        dataSet.setDrawHighlightIndicators(true)
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.drawVerticalHighlightIndicatorEnabled = false
        dataSet.highlightColor = .accent
        
        let marker = CircleMarker()
        marker.chartView = coinChartView
        coinChartView.marker = marker
        
        // 차트에 데이터 세트를 추가
        let data = LineChartData(dataSet: dataSet)
        data.setDrawValues(false)
        coinChartView.data = data
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
        coinChartView.marker?.refreshContent(entry: entry, highlight: highlight)
    }
}
