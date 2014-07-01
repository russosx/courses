
import UIKIt

class TipCalculatorModel {
    
    var total: Double
    var taxPct: Double
    var subtotal: Double {
    get {
        return total / (taxPct + 1)
    }
    }
    
    init(total:Double, taxPct:Double) {
        self.total = total
        self.taxPct = taxPct
    }
    
    func calcTipWithTipPct(tipPct:Double) -> (tipAmt:Double, total:Double) {
        let tipAmt = subtotal * tipPct
        let finalTotal = total + tipAmt
        return (tipAmt, finalTotal)
    }
    
    func returnPossibleTips() -> Dictionary<Int, (Double, Double)> {
        let possibleTipsInferred = [0.15, 0.18, 0.20]
        var retval = Dictionary<Int, (Double, Double)>()
        for possibleTip in possibleTipsInferred {
            let intPct = Int(possibleTip*100)
            retval[intPct] = calcTipWithTipPct(possibleTip)
        }
        return retval
    }
}


class TestDataSource : NSObject, UITableViewDataSource {
    
    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    var possibleTips = Dictionary<Int, (tipAmt:Double, total:Double)>()
    var sortedKeys:Int[] = []
    
    init() {
        possibleTips = tipCalc.returnPossibleTips()
        sortedKeys = sort(Array(possibleTips.keys))
        super.init()
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return sortedKeys.count
    }
    
    
}
