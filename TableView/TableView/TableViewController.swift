//
//  TableViewController.swift
//  TableView
//
//  Created by 장한솔 on 2022/06/15.
//

import UIKit

var items = ["햇반 구매", "친구들과의 약속", "iOS 공부"]
var itemsImageFile = ["cart.png", "clock.png", "pencil.png"]

class TableViewController: UITableViewController {
    @IBOutlet var tvListView: UITableView!
    
    /*
     viewDidLoad : 뷰가 로드되었을 때 호출되는 함수로, 뷰가 생성될 때 한 번만 호출된다.
     viewWillAppear : 뷰가 노출될 준비가 끝났을 때 호출되는 함수로, 뷰가 노출될 때마다 호출된다.
     viewDidAppear : 뷰가 완전히 보인 후 호출되는 함수로, 뷰가 완전히 보인 후 호출된다.
     
     - 뷰가 처음 보일 때는 viewDidLoad -> viewWillAppear -> viewDidAppear 순으로 호출
     - 뷰가 전환되어 올 때는 viewWillAppear -> viewDidAppear 순으로 호출
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //바 버튼으로 목록 삭제
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tvListView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //테이블 안에 섹션이 한 개이므로 numberOfSections의 리턴 값을 1로 한다.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //섹션당 열의 갯수
        return items.count
    }
    
    /*
     테이블 뷰 컨트롤러가 주석 처리된 함수를 제공 하는 이유
     : 테이블 뷰 컨트롤러를 사용하면 어느 정도는 비슷한 동작을 추구하기 때문에
        Xcode에서 사용할 것으로 예상되는 함수를 주석 처리하여 제공한다.
     */

    //앞에서 선언한 변수의 내용을 셀에 적용하는 함수
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        //셀의 텍스트 레이블에 앞에서 선언한 items을 대입한다.
        cell.textLabel?.text = items[(indexPath as NSIndexPath).row]
        //셀의 이미지 뷰에 앞에서 선언한 itemsImageFile을 대입한다.
        cell.imageView?.image = UIImage(named: itemsImageFile[(indexPath as NSIndexPath).row])

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    //삭제 버튼 한글로 수정
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }


    // Override to support editing the table view.
    //셀의 내용을 삭제하는 함수
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: (indexPath as NSIndexPath).row)
            itemsImageFile.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    //목록 순서를 변경할 수 있는 함수
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        //이동하려고 하는 row의 정보를 변수에 저장한다.
        let itemToMove = items[(fromIndexPath as NSIndexPath).row]
        let itemImageToMove = itemsImageFile[(fromIndexPath as NSIndexPath).row]
        
        //이동할 row 삭제
        items.remove(at: (fromIndexPath as NSIndexPath).row)
        itemsImageFile.remove(at: (fromIndexPath as NSIndexPath).row)
        
        //이동할 위치로 삭제한 row 추가
        items.insert(itemToMove, at: (to as NSIndexPath).row)
        itemsImageFile.insert(itemImageToMove, at: (to as NSIndexPath).row)
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgDetail" {
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            let detailView = segue.destination as! DetailViewController
            detailView.receiveItem(items[((indexPath! as NSIndexPath).row)])
        }
    }

}
