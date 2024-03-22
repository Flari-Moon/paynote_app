import 'dart:io';
import 'package:paynote_app/Api/TransactionMainModel.dart';
import 'package:paynote_app/Api/TransactionSortedDateModel.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:paynote_app/services/RequestService.dart';import 'package:flutter/material.dart';

class TransactionsAllAccViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();

  File image;
  bool bankAccounts = false;
  int limit = 10;
  int skip = 0;
  List<TransactionMainModel> transactionList =
      <TransactionMainModel>[];
  List<TransactionMainModel> searchResult =
  <TransactionMainModel>[];
  List<TransactionMainModel> toDisplayTransactions =
  <TransactionMainModel>[];
  String userId;
  bool isLoading= false;

  RequestService requestService = locator<RequestService>();
  ScrollController _scrollController = new ScrollController();

  bool _isSearched = false;
  get isSearched => _isSearched;
  set isSearched(bool value) {
    _isSearched = value;
  }

  void getData(BuildContext context) {
   // toDisplayTransactions.clear();
    if (!isLoading) {
      skip += 10;
      isLoading = true;
      getTransactions(context);
    }
  }

  getTransactions(BuildContext context) async {
    //toDisplayTransactions.clear();

 //  if(!isLoading){ setBusy(true);}
    setBusy(true);
    userId = SharedPref().getString("userId");
    //userId = 'c8c777e3da3c46ba96383da24aa2a4e1';
    //getTransFromPref();
    if (userId != null ) {
      await requestService
          .getUserTransactions(userId, skip, limit, 'date',context,'')
          .then((value) { if(value!=null){toDisplayTransactions..addAll(value);}
          isLoading=false;
          });

      print('limit is $limit');
    //  limit = limit + 50;
    //  toDisplayTransactions..addAll(transactionList);
     if(!isLoading){
       setBusy(false);
     }
      notifyListeners();
    }
    else{
      setBusy(false);
    }
    setBusy(false);
    notifyListeners();
  }

  void searchOperation(String searchText) {
    searchResult.clear();
    print('in model $_isSearched');
    if (_isSearched) {
      for (int i = 0; i < toDisplayTransactions.length; i++) {
        TransactionMainModel data = toDisplayTransactions[i];
        if (data.transaction.description.toLowerCase().contains(searchText.toLowerCase())) {
          searchResult.add(data);
          print('tras found ${data.transaction.description}');
        }
      }
    }
    else
{    print('nothing found');}
    notifyListeners();
  }

  navigateToTransactionDetail(TransactionSortedDateModel transaction) {
    _navigationService.navigateTo(Routes.transactionsDetailView, arguments: TransactionsDetailViewArguments(transactionModel: transaction));
  }
}
