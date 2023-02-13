class VariantProduct {
  String stock;
  String id;
  String mohprice;
  String img;
  String itemnameEn;
  String itemnameAr;
  String labelname;
  String itempack;
  String itemstrength;
  String itemproductgroupid;
  String itemmaingroupid;
  String itemgroupid;
  String itemsubgroupid;
  String itemsubgroupecommerceid;
  String type;
  String itemdosageid;
  String itemclassid;
  String manufactureid;
  String manufactureshortname;
  String seq;
  String rs;
  String ws;
  String avgprice;
  String origin;
  String companyid;
  String whichcompany;
  String allowsonapp;
  String allowsonweb;
  String allowsonecommerce;
  String status;
  String itemid;

  VariantProduct(
      {this.stock,
      this.id,
      this.mohprice,
      this.img,
      this.itemnameEn,
      this.itemnameAr,
      this.labelname,
      this.itempack,
      this.itemstrength,
      this.itemproductgroupid,
      this.itemmaingroupid,
      this.itemgroupid,
      this.itemsubgroupid,
      this.itemsubgroupecommerceid,
      this.type,
      this.itemdosageid,
      this.itemclassid,
      this.manufactureid,
      this.manufactureshortname,
      this.seq,
      this.rs,
      this.ws,
      this.avgprice,
      this.origin,
      this.companyid,
      this.whichcompany,
      this.allowsonapp,
      this.allowsonweb,
      this.allowsonecommerce,
      this.status,
      this.itemid});

  VariantProduct.fromJson(Map<String, dynamic> json) {
    stock = json['stock'];
    id = json['id'];
    mohprice = json['mohprice'];
    img = json['img'];
    itemnameEn = json['itemname_en'];
    itemnameAr = json['itemname_ar'];
    labelname = json['labelname'];
    itempack = json['itempack'];
    itemstrength = json['itemstrength'];
    itemproductgroupid = json['itemproductgroupid'];
    itemmaingroupid = json['itemmaingroupid'];
    itemgroupid = json['itemgroupid'];
    itemsubgroupid = json['itemsubgroupid'];
    itemsubgroupecommerceid = json['itemsubgroupecommerceid'];
    type = json['type'];
    itemdosageid = json['itemdosageid'];
    itemclassid = json['itemclassid'];
    manufactureid = json['manufactureid'];
    manufactureshortname = json['manufactureshortname'];
    seq = json['seq'];
    rs = json['rs'];
    ws = json['ws'];
    avgprice = json['avgprice'];
    origin = json['origin'];
    companyid = json['companyid'];
    whichcompany = json['whichcompany'];
    allowsonapp = json['allowsonapp'];
    allowsonweb = json['allowsonweb'];
    allowsonecommerce = json['allowsonecommerce'];
    status = json['status'];
    itemid = json['itemid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stock'] = this.stock;
    data['id'] = this.id;
    data['mohprice'] = this.mohprice;
    data['img'] = this.img;
    data['itemname_en'] = this.itemnameEn;
    data['itemname_ar'] = this.itemnameAr;
    data['labelname'] = this.labelname;
    data['itempack'] = this.itempack;
    data['itemstrength'] = this.itemstrength;
    data['itemproductgroupid'] = this.itemproductgroupid;
    data['itemmaingroupid'] = this.itemmaingroupid;
    data['itemgroupid'] = this.itemgroupid;
    data['itemsubgroupid'] = this.itemsubgroupid;
    data['itemsubgroupecommerceid'] = this.itemsubgroupecommerceid;
    data['type'] = this.type;
    data['itemdosageid'] = this.itemdosageid;
    data['itemclassid'] = this.itemclassid;
    data['manufactureid'] = this.manufactureid;
    data['manufactureshortname'] = this.manufactureshortname;
    data['seq'] = this.seq;
    data['rs'] = this.rs;
    data['ws'] = this.ws;
    data['avgprice'] = this.avgprice;
    data['origin'] = this.origin;
    data['companyid'] = this.companyid;
    data['whichcompany'] = this.whichcompany;
    data['allowsonapp'] = this.allowsonapp;
    data['allowsonweb'] = this.allowsonweb;
    data['allowsonecommerce'] = this.allowsonecommerce;
    data['status'] = this.status;
    data['itemid'] = this.itemid;
    return data;
  }
}
