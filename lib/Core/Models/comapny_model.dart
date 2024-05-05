class Company {
  List<Branch>? branches;
  String? companyAddress;
  String? companyCode;
  String? companyName;
  String? tpinVatNo;

  Company(
      {this.branches,
        this.companyAddress,
        this.companyCode,
        this.companyName,
        this.tpinVatNo});

  Company.fromJson(Map<String, dynamic> json) {
    if (json['branches'] != null) {
      branches = <Branch>[];
      json['branches'].forEach((v) {
        branches!.add(Branch.fromJson(v));
      });
    }
    companyAddress = json['company_address'];
    companyCode = json['company_code'];
    companyName = json['company_name'];
    tpinVatNo = json['tpin_vat_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (branches != null) {
      data['branches'] = branches!.map((v) => v.toJson()).toList();
    }
    data['company_address'] = companyAddress;
    data['company_code'] = companyCode;
    data['company_name'] = companyName;
    data['tpin_vat_no'] = tpinVatNo;
    return data;
  }
}

class Branch {
  String? branchAddress;
  String? branchCode;
  String? branchName;

  Branch({this.branchAddress, this.branchCode, this.branchName});

  Branch.fromJson(Map<String, dynamic> json) {
    branchAddress = json['branch_address'];
    branchCode = json['branch_code'];
    branchName = json['branch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branch_address'] = branchAddress;
    data['branch_code'] = branchCode;
    data['branch_name'] = branchName;
    return data;
  }
}