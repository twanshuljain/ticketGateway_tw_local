//
//  ScanSummaryVC.swift
//  TicketGateway
//
//  Created by Apple on 21/06/23.
// swiftlint: disable force_cast
// swiftlint: disable line_length
import UIKit
import Charts
class ScanSummaryVC: UIViewController, ChartViewDelegate {
    // MARK: - Outlets
    @IBOutlet weak var chartView: PieChartView!
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    @IBOutlet weak var lblSunburnReload: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var lblTotalTickets: UILabel!
    @IBOutlet weak var lblTotalTicketValue: UILabel!
    @IBOutlet weak var tblScanSummaryTableView: UITableView!
    @IBOutlet weak var btnDownloadReport: CustomButtonNormal!
    @IBOutlet weak var btnUpdateLiveOnServer: UIButton!
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btnDownloadReportWidth: NSLayoutConstraint!
    // MARK: - Variables
    let viewModel = ScanSummaryViewModel()
     let tblData = ["Tix to scan", "Tix Scanned", "Accepted", "Rejected", "Scanned Hard Tix", "Scanned PDF Tix", "Scanned Comps Tix"]
    override func viewDidLoad() {
        super.viewDidLoad()
        getScanOverview()
        self.setNavigationView()
        self.setFont()
        self.setTableView()
        self.setChart()
        self.chartView.delegate = self
        self.tblScanSummaryTableView.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.tblViewHeight.constant = self.tblScanSummaryTableView.contentSize.height
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.tblViewHeight.constant = tblScanSummaryTableView.contentSize.height
    }
}
// MARK: -
extension ScanSummaryVC {
    func setTableView() {
        self.tblScanSummaryTableView.delegate = self
        self.tblScanSummaryTableView.dataSource = self
    }
    func setNavigationView() {
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.lblTitle.text = SCAN_SUMMARY
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.vwNavigationView.vwBorder.isHidden = false
    }
    func setChart() {
        var entries = [ChartDataEntry]()
        for num in 0...7 {
            entries.append(ChartDataEntry(x: Double(num), y: Double(num)))
        }
        let set = PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.chartColor()
        set.drawValuesEnabled = false
        let data = PieChartData(dataSet: set)
        chartView.data = data
        chartView.holeColor = UIColor.clear
        self.chartView.legend.enabled = false
        chartView.holeRadiusPercent = 0.7
    }
    func setFont() {
        if viewModel.isOnline == true {
            btnDownloadReportWidth.constant = self.view.bounds.width - 32
        } else {
            btnDownloadReportWidth.constant = (self.view.bounds.width - 32)/2
            btnUpdateLiveOnServer.isHidden = true
        }
        self.lblSunburnReload.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblSunburnReload.textColor = UIColor.setColor(colorType: .tgBlack)
        self.lblDate.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblDate.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblTotalTickets.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblTotalTickets.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblTotalTicketValue.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
        self.lblTotalTicketValue.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnDownloadReport.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnDownloadReport.titleLabel?.textColor = UIColor.setColor(colorType: .white)
        self.btnDownloadReport.setImage(UIImage(named: ""), for: .normal)
        self.btnDownloadReport.addRightIcon(image: UIImage(named: DOWNLOAD_WHITE_ICON))
        self.btnUpdateLiveOnServer.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnUpdateLiveOnServer.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
    }
    func getScanOverview() {
        if Reachability.isConnectedToNetwork() {
            view.showLoading(centreToView: self.view)
            viewModel.getScanOverview(completion: { isTrue, message in
                if isTrue {
                    self.dataSettingAfterScanOverview()
                    self.view.stopLoading()
                    self.tblScanSummaryTableView.reloadData()
                } else {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.showToast(message: message)
                    }
                }
            })
        } else {
            DispatchQueue.main.async {
                self.view.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
    func dataSettingAfterScanOverview() {
        lblSunburnReload.text = viewModel.getScanSummaryData.eventName ?? "-"
        lblDate.text = Date().convertToString()
        lblTotalTicketValue.text = "\(viewModel.getScanSummaryData.totalTicketInEvent ?? 0)"
    }
}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension ScanSummaryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tblData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScanSummaryTableViewCell", for: indexPath) as! ScanSummaryTableViewCell
        let data = tblData[indexPath.row]
        switch data {
        case TicketStatusList.tixToScan.rawValue:
            cell.lblTitleValue.text = "\(viewModel.getScanSummaryData.tixToScan ?? 0)"
        case TicketStatusList.tixScanned.rawValue:
            cell.lblTitleValue.text = "\(viewModel.getScanSummaryData.tixScanned ?? 0)"
        case TicketStatusList.accepted.rawValue:
            cell.lblTitleValue.text = "\(viewModel.getScanSummaryData.tixAccepted ?? 0)"
        case TicketStatusList.rejected.rawValue:
            cell.lblTitleValue.text = "\(viewModel.getScanSummaryData.tixRejected ?? 0)"
        case TicketStatusList.scannedHardTix.rawValue:
            cell.lblTitleValue.text = "\(0)"
        case TicketStatusList.scannedPdfTix.rawValue:
            cell.lblTitleValue.text = "\(0)"
        case TicketStatusList.scannedCompsTix.rawValue:
            cell.lblTitleValue.text = "\(0)"
        default:
            break
        }
        cell.selectionStyle = .none
        cell.lblSummaryTitle.text = data
        return cell
    }
}
// MARK: - NavigationBarViewDelegate
extension ScanSummaryVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
