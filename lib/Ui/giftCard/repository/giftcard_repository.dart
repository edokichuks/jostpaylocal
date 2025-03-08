import 'package:jost_pay_wallet/Ui/giftCard/models/gift_card_country_response/gift_card_country_response.dart';
import 'package:jost_pay_wallet/Ui/giftCard/models/gift_cards_response/gift_cards_response.dart';
import 'package:jost_pay_wallet/services/network_service.dart';

class GiftcardRepository {
  final NetworkService networkService = NetworkService();

  Future<GiftCardCountryResponse> getGiftCardCountries(
      {required String token}) async {
    final header = {
      "Accept": "application/x-www-form-urlencoded",
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": token,
    };
    var response = await networkService.post(
      "get-gift-countries",
      headers: header,
    );

    return GiftCardCountryResponse.fromMap(response);
  }

  Future<GiftCardsResponse> register(
      {required String countryCode, required String token}) async {
    final header = {
      "Accept": "application/x-www-form-urlencoded",
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": token,
    };
    final Map<String, dynamic> data = {'country_code': countryCode};
    var response = await networkService.post("get-gift-cards",
        headers: header, body: data);

    return GiftCardsResponse.fromMap(response);
  }
}
