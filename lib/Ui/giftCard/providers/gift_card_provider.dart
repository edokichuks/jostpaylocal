import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Ui/giftCard/models/gift_card_country_response/country.dart';
import 'package:jost_pay_wallet/Ui/giftCard/repository/giftcard_repository.dart';
import 'package:jost_pay_wallet/Values/Helper/logger.dart';
import 'package:jost_pay_wallet/services/local_storage.dart/local_storage_export.dart';
import 'package:jost_pay_wallet/services/navigation_service.dart';

class GiftCardProvider extends ChangeNotifier {
  final LocalStorageRepo _localStorageRepo;
  GiftCardProvider(this._localStorageRepo);
  final context = NavigationService.navigatorKey.currentContext;
  final giftCardRepository = GiftcardRepository();

  bool isFetchingCountries = false;
  bool isFetchingGiftCards = false;
  List<Country>? countries = [];
  String? error;

  Future getllCountries() async {
    debugLog('Attempting to get all countryes ');
    try {
      setError(null);
      setFetchCountry(true);

      final response = await giftCardRepository.getGiftCardCountries(
          token: _localStorageRepo.get(
        LocalStoreKeysManger.token.rawValue,
      ));
      debugLog('all country Response => ${response.toString()}');

      if (response.result == true) {
        setCountries(response.countries);
      } else {
        setError('Error');
      }

      setFetchCountry(false);
    } catch (e) {
      setFetchCountry(false);
    }
  }

  void setFetchCountry(value) {
    isFetchingCountries = value;
    notifyListeners();
  }

  void setCountries(value) {
    countries = value;
    notifyListeners();
  }

  void setgiftCards(value) {
    isFetchingGiftCards = value;
    notifyListeners();
  }

  void setError(value) {
    error = value;
    notifyListeners();
  }
}
