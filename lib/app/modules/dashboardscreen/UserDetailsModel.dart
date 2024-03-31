class UserDetailsModel {
  String? listId;
  String? state;
  String? district;
  String? assemblyConstituency;
  String? boothNo;
  String? voterName;
  String? serialNo;
  String? mobNo;
  String? pollingPoint;
  String? fullAddress;
  String? fatherName;
  String? husbandName;
  String? gender;
  String? age;
  String? color;
  String? createdDate;
  String? status;
  String? stateId;
  String? stateName;
  String? districtId;
  String? districtName;
  String? constituencyId;
  String? constituencyName;
  String? voter_id;

  UserDetailsModel(
      {this.listId,
        this.state,
        this.district,
        this.assemblyConstituency,
        this.boothNo,
        this.voterName,
        this.serialNo,
        this.mobNo,
        this.pollingPoint,
        this.fullAddress,
        this.fatherName,
        this.husbandName,
        this.gender,
        this.age,
        this.color,
        this.createdDate,
        this.status,
        this.stateId,
        this.stateName,
        this.districtId,
        this.districtName,
        this.constituencyId,
        this.voter_id,
        this.constituencyName});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    listId = json['list_id'];
    state = json['state'];
    district = json['district'];
    assemblyConstituency = json['assembly_constituency'];
    boothNo = json['booth_no'];
    voterName = json['voter_name'];
    serialNo = json['serial_no'];
    mobNo = json['mob_no'];
    pollingPoint = json['polling_point'];
    fullAddress = json['full_address'];
    fatherName = json['father_name'];
    husbandName = json['husband_name'];
    gender = json['gender'];
    age = json['age'];
    color = json['color'];
    createdDate = json['created_date'];
    status = json['status'];
    stateId = json['state_id'];
    stateName = json['state_name'];
    districtId = json['district_id'];
    districtName = json['district_name'];
    constituencyId = json['constituency_id'];
    constituencyName = json['constituency_name'];
    voter_id = json['voter_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['list_id'] = this.listId;
    data['state'] = this.state;
    data['district'] = this.district;
    data['assembly_constituency'] = this.assemblyConstituency;
    data['booth_no'] = this.boothNo;
    data['voter_name'] = this.voterName;
    data['serial_no'] = this.serialNo;
    data['mob_no'] = this.mobNo;
    data['polling_point'] = this.pollingPoint;
    data['full_address'] = this.fullAddress;
    data['father_name'] = this.fatherName;
    data['husband_name'] = this.husbandName;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['color'] = this.color;
    data['created_date'] = this.createdDate;
    data['status'] = this.status;
    data['state_id'] = this.stateId;
    data['state_name'] = this.stateName;
    data['district_id'] = this.districtId;
    data['district_name'] = this.districtName;
    data['constituency_id'] = this.constituencyId;
    data['constituency_name'] = this.constituencyName;
    data['voter_id'] = this.voter_id;
    return data;
  }
}
