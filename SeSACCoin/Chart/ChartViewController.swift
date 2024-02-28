//
//  ChartViewController.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import UIKit
import Charts
import DGCharts

class ChartViewController: BaseViewController {

    var ids: String = ""
    
    let viewModel = ChartViewModel()
    
    let image = UIImageView() // 코인 아이콘 리소스
    let name = UILabel() // 코인 이름
    let current_price = UILabel() // 코인 현재가
    let price_change_percentage_24h = UILabel() // 코인 변동폭
    let low_24h = UILabel() // 코인 저가
    let high_24h = UILabel() // 코인 고가
    let ath = UILabel() // 신고점
    let atl = UILabel() // 신저점
    let last_updated = UILabel() // 코인 시장 업데이트 시각
    
    private var coinChartView = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputID.value = ids
        viewModel.resultData.bind { value in
            guard let value = value else { return }
            self.name.text = value[0].name
            self.current_price.text = String(value[0].current_price)
            self.price_change_percentage_24h.text = String(value[0].price_change_percentage_24h)
        }
    }
    
    override func configureHierarchy() {
        view.addSubview(name)
        view.addSubview(current_price)
        view.addSubview(price_change_percentage_24h)
        view.addSubview(coinChartView)
    }
    
    override func configureView() {
        super.configureView()
        
        //name.text = "코인 이름"
        name.textColor = .mainLabel
        name.font = .systemFont(ofSize: 32, weight: .black)
        
        //current_price.text = "코인 현재가"
        current_price.textColor = .mainLabel
        current_price.font = .systemFont(ofSize: 32, weight: .black)
        
        //price_change_percentage_24h.text = "코인 변동폭"
        price_change_percentage_24h.textColor = .redLabel
        
        coinChartView.backgroundColor = .yellow
    }

    override func setConstraints() {
        name.snp.makeConstraints {
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        current_price.snp.makeConstraints {
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.top.equalTo(name.snp.bottom).offset(10)
        }
        price_change_percentage_24h.snp.makeConstraints {
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.top.equalTo(current_price.snp.bottom).offset(5)
        }
    }

}

extension ChartViewController: ChartViewDelegate {
    
    
    
}
