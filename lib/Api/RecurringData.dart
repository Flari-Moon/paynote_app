class RecurringData {
  int status;
  Data data;

  RecurringData({this.status, this.data});

  RecurringData.fromJson(Map<String, dynamic> json) {
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
}

class Data {
  List<Subscriptions> subscriptions;
  String amountPerMonth;
  String amountPerYear;

  Data({this.subscriptions, this.amountPerMonth, this.amountPerYear});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['subscriptions'] != null) {
      subscriptions = new List<Subscriptions>();
      json['subscriptions'].forEach((v) {
        subscriptions.add(new Subscriptions.fromJson(v));
      });
    }
    amountPerMonth = json['amount_per_month'];
    amountPerYear = json['amount_per_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subscriptions != null) {
      data['subscriptions'] =
          this.subscriptions.map((v) => v.toJson()).toList();
    }
    data['amount_per_month'] = this.amountPerMonth;
    data['amount_per_year'] = this.amountPerYear;
    return data;
  }
}

class Subscriptions {
  String company;
  String logo;
  String latGeo;
  String longGeo;
  String website;
  String email;
  String phone;
  String address;
  Timestamp timestamp;
  String category;
  String description;
  String fromBankAccount;
  int countLinkedTransactions;
  String amountTransaction;
  String durationRecurring;
  String clientNumber;
  String amountAllLinkedTransactions;
  StatusInformation statusInformation;
  List<Linked> linked;

  Subscriptions(
      {this.company,
        this.logo,
        this.latGeo,
        this.longGeo,
        this.website,
        this.email,
        this.phone,
        this.address,
        this.timestamp,
        this.category,
        this.description,
        this.fromBankAccount,
        this.countLinkedTransactions,
        this.amountTransaction,
        this.durationRecurring,
        this.clientNumber,
        this.amountAllLinkedTransactions,
        this.statusInformation,
        this.linked});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    company = json['company'];
    logo = json['logo'];
    latGeo = json['lat_geo'];
    longGeo = json['long_geo'];
    website = json['website'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    timestamp = json['timestamp'] != null
        ? new Timestamp.fromJson(json['timestamp'])
        : null;
    category = json['category'];
    description = json['description'];
    fromBankAccount = json['from_bank_account'];
    countLinkedTransactions = json['count_linked_transactions'];
    amountTransaction = json['amount_transaction'];
    durationRecurring = json['duration_recurring'];
    clientNumber = json['client_number'];
    amountAllLinkedTransactions = json['amount_all_linked_transactions'];
    statusInformation = json['status_information'] != null
        ? new StatusInformation.fromJson(json['status_information'])
        : null;
    if (json['linked'] != null) {
      linked = new List<Linked>();
      json['linked'].forEach((v) {
        linked.add(new Linked.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company'] = this.company;
    data['logo'] = this.logo;
    data['lat_geo'] = this.latGeo;
    data['long_geo'] = this.longGeo;
    data['website'] = this.website;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    if (this.timestamp != null) {
      data['timestamp'] = this.timestamp.toJson();
    }
    data['category'] = this.category;
    data['description'] = this.description;
    data['from_bank_account'] = this.fromBankAccount;
    data['count_linked_transactions'] = this.countLinkedTransactions;
    data['amount_transaction'] = this.amountTransaction;
    data['duration_recurring'] = this.durationRecurring;
    data['client_number'] = this.clientNumber;
    data['amount_all_linked_transactions'] = this.amountAllLinkedTransactions;
    if (this.statusInformation != null) {
      data['status_information'] = this.statusInformation.toJson();
    }
    if (this.linked != null) {
      data['linked'] = this.linked.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Timestamp {
  String date;
  int timezoneType;
  String timezone;

  Timestamp({this.date, this.timezoneType, this.timezone});

  Timestamp.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['timezone_type'] = this.timezoneType;
    data['timezone'] = this.timezone;
    return data;
  }
}

class StatusInformation {
  bool stillActive;
  String typeSubscription;

  StatusInformation({this.stillActive, this.typeSubscription});

  StatusInformation.fromJson(Map<String, dynamic> json) {
    stillActive = json['still_active'];
    typeSubscription = json['type_subscription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['still_active'] = this.stillActive;
    data['type_subscription'] = this.typeSubscription;
    return data;
  }
}

class Linked {
  String name;
  Timestamp timestamp;
  String amountTransaction;
  String fromIban;
  String message;

  Linked(
      {this.name,
        this.timestamp,
        this.amountTransaction,
        this.fromIban,
        this.message});

  Linked.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    timestamp = json['timestamp'] != null
        ? new Timestamp.fromJson(json['timestamp'])
        : null;
    amountTransaction = json['amount_transaction'];
    fromIban = json['from_iban'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.timestamp != null) {
      data['timestamp'] = this.timestamp.toJson();
    }
    data['amount_transaction'] = this.amountTransaction;
    data['from_iban'] = this.fromIban;
    data['message'] = this.message;
    return data;
  }
}