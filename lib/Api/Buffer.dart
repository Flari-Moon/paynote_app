class Buffer {
  int status;
  Data data;

  Buffer({this.status, this.data});

  Buffer.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Buffer{status: $status, data: $data}';
  }
}

class Data {
  String currentBalance;
  String recurringCost;
  String spendableIncome;
  Weekly weekly;

  @override
  String toString() {
    return 'Data{currentBalance: $currentBalance, recurringCost: $recurringCost, spendableIncome: $spendableIncome, weekly: $weekly}';
  }

  Data(
      {this.currentBalance,
        this.recurringCost,
        this.spendableIncome,
        this.weekly});

  Data.fromJson(Map<String, dynamic> json) {
    currentBalance = json['current_balance'];
    recurringCost = json['recurring_cost'];
    spendableIncome = json['spendable_income'];
    weekly =
    json['weekly'] != null ? new Weekly.fromJson(json['weekly']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_balance'] = this.currentBalance;
    data['recurring_cost'] = this.recurringCost;
    data['spendable_income'] = this.spendableIncome;
    if (this.weekly != null) {
      data['weekly'] = this.weekly.toJson();
    }
    return data;
  }
}

class Weekly {
  String monday;
  String tuesday;
  String wednesday;
  String thursday;
  String friday;
  String saturday;
  String sunday;

  Weekly(
      {this.monday,
        this.tuesday,
        this.wednesday,
        this.thursday,
        this.friday,
        this.saturday,
        this.sunday});

  Weekly.fromJson(Map<String, dynamic> json) {
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednesday'];
    thursday = json['thursday'];
    friday = json['friday'];
    saturday = json['saturday'];
    sunday = json['sunday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monday'] = this.monday;
    data['tuesday'] = this.tuesday;
    data['wednesday'] = this.wednesday;
    data['thursday'] = this.thursday;
    data['friday'] = this.friday;
    data['saturday'] = this.saturday;
    data['sunday'] = this.sunday;
    return data;
  }
}