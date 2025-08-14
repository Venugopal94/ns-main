class InventoryHistory {
  String? invoiceno;
  String? invoiceamount;
  String? invoicedate;

  InventoryHistory({this.invoiceno, this.invoiceamount, this.invoicedate});

  InventoryHistory.fromJson(Map<String, dynamic> json) {
    invoiceno = json['invoiceno'];
    invoiceamount = json['invoiceamount'];
    invoicedate = json['invoicedate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoiceno'] = this.invoiceno;
    data['invoiceamount'] = this.invoiceamount;
    data['invoicedate'] = this.invoicedate;
    return data;
  }
}