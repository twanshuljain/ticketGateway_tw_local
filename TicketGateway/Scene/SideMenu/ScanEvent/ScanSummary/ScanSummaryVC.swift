//
//  ScanSummaryVC.swift
//  TicketGateway
//
//  Created by Apple on 21/06/23.
// swiftlint: disable force_cast
// swiftlint: disable line_length
import UIKit
import Charts
import SDWebImage
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
    @IBOutlet weak var imgProfile: UIImageView!
    // MARK: - Variables
    let viewModel = ScanSummaryViewModel()
     let tblData = ["Tix to scan", "Tix Scanned", "Accepted", "Rejected", "Scanned Hard Tix", "Scanned PDF Tix", "Scanned Comps Tix"]
    override func viewDidLoad() {
        super.viewDidLoad()
        getScanOverview()
        getScanSummary()
        self.setNavigationView()
        self.setFont()
        self.setTableView()
        self.chartView.delegate = self
        self.tblScanSummaryTableView.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.tblViewHeight.constant = self.tblScanSummaryTableView.contentSize.height
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
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
        viewModel.arrOfValueChart.forEach { data in
            print("data", data)
            entries.append(ChartDataEntry(x: Double(data), y: Double(data)))
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
                    self.setChart()
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
    func getScanSummary() {
        if Reachability.isConnectedToNetwork() {
            view.showLoading(centreToView: self.view)
            viewModel.getScanSummary(completion: { isTrue, message in
                if isTrue {
                    self.view.stopLoading()
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
        lblSunburnReload.text = viewModel.getScanOverviewData.eventName ?? "-"
        lblDate.text = Date().convertToString()
        lblTotalTicketValue.text = "\(viewModel.getScanOverviewData.totalTicketInEvent ?? 0)"
        if let url = (APIHandler.shared.s3URL + (viewModel.getScanOverviewData.eventCoverImage ?? "")).getCleanedURL() {
            self.imgProfile.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
        } else {
            self.imgProfile.image = UIImage(named: "homeDas")
        }
        viewModel.arrOfValueChart = []
        viewModel.arrOfValueChart.append(viewModel.getScanOverviewData.tixToScan ?? 0)
        viewModel.arrOfValueChart.append(viewModel.getScanOverviewData.tixScanned ?? 0)
        viewModel.arrOfValueChart.append(viewModel.getScanOverviewData.tixAccepted ?? 0)
        viewModel.arrOfValueChart.append(viewModel.getScanOverviewData.tixRejected ?? 0)
        viewModel.arrOfValueChart.append(viewModel.getScanOverviewData.scannedHardTix ?? 0)
        viewModel.arrOfValueChart.append(viewModel.getScanOverviewData.scannedPdfTix ?? 0)
        viewModel.arrOfValueChart.append(viewModel.getScanOverviewData.scannedCompsTix ?? 0)
        print("viewModel.arrOfValueChart:-", viewModel.arrOfValueChart)
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
            cell.lblTitleValue.text = "\(viewModel.getScanOverviewData.tixToScan ?? 0)"
            cell.vwColorView.backgroundColor = UIColor.hexColor(hex: "#CDC8F9")
        case TicketStatusList.tixScanned.rawValue:
            cell.lblTitleValue.text = "\(viewModel.getScanOverviewData.tixScanned ?? 0)"
            cell.vwColorView.backgroundColor = UIColor.hexColor(hex: "#A0CF67")
        case TicketStatusList.accepted.rawValue:
            cell.lblTitleValue.text = "\(viewModel.getScanOverviewData.tixAccepted ?? 0)"
            cell.vwColorView.backgroundColor = UIColor.hexColor(hex: "#FB896B")
        case TicketStatusList.rejected.rawValue:
            cell.lblTitleValue.text = "\(viewModel.getScanOverviewData.tixRejected ?? 0)"
            cell.vwColorView.backgroundColor = UIColor.hexColor(hex: "#FFD467")
        case TicketStatusList.scannedHardTix.rawValue:
            cell.lblTitleValue.text = "\(0)"
            cell.vwColorView.backgroundColor = UIColor.hexColor(hex: "#C6E0FF")
        case TicketStatusList.scannedPdfTix.rawValue:
            cell.lblTitleValue.text = "\(0)"
            cell.vwColorView.backgroundColor = UIColor.hexColor(hex: "#FFBDE1")
        case TicketStatusList.scannedCompsTix.rawValue:
            cell.lblTitleValue.text = "\(0)"
            cell.vwColorView.backgroundColor = UIColor.hexColor(hex: "#FFDDC6")
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
