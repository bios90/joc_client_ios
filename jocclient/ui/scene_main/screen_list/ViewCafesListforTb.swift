import UIKit

class ViewCafesListForTb:UIViewController
{
    private var cafes:[ModelCafe] = []
    
    let tb_cafes:UITableView =
    {
        let tb = UITableView()
        tb.backgroundColor = MyColors.gi.transparent
        tb.showsVerticalScrollIndicator = false
        tb.tableFooterView = UIView()
        tb.register(CellCafe.self, forCellReuseIdentifier: CellCafe.reuse_id)
        tb.rowHeight = UITableView.automaticDimension
        tb.estimatedRowHeight = 1000
        tb.separatorInset = UIEdgeInsets.zero
        tb.separatorStyle = UITableViewCell.SeparatorStyle.none
        tb.bounces = false
        return tb
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.addSubview(tb_cafes)
        tb_cafes.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        tb_cafes.delegate = self
        tb_cafes.dataSource = self
    }
    
    func setCafes(cafes:[ModelCafe])
    {
        self.cafes = cafes
        tb_cafes.reloadData()
    }
}

extension ViewCafesListForTb:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return cafes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cafe = cafes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CellCafe.reuse_id) as! CellCafe
        cell.bindCafe(cafe: cafe)
        
        return cell
    }
    
    
}
