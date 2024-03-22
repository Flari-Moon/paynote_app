class Subscriptions {
  String company;
  Timestamp timestamp;
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
        this.timestamp,
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
    timestamp = json['timestamp'] != null
        ? new Timestamp.fromJson(json['timestamp'])
        : null;
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
    if (this.timestamp != null) {
      data['timestamp'] = this.timestamp.toJson();
    }
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
  double amountTransaction;
  String fromIban;
  String message;

  Linked({this.name,
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