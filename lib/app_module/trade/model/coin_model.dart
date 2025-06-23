class CoinModel {
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentPrice;
  double? marketCap;
  double? marketCapRank;
  double? fullyDilutedValuation;
  double? totalVolume;

  double? high24h;
  double? low24h;
  double? priceChange24h;
  double? priceChangePercentage24h;
  double? marketCapChange24h;
  double? marketCapChangePercentage24h;
  double? circulatingSupply;
  double? totalSupply;
  double? maxSupply;
  double? ath;
  double? athChangePercentage;
  String? athDate;
  double? atl;
  double? atlChangePercentage;
  String? atlDate;
  Roi? roi;
  String? lastUpdated;

  CoinModel(
      {this.id,
        this.symbol,
        this.name,
        this.image,
        this.currentPrice,
        this.marketCap,
        this.marketCapRank,
        this.fullyDilutedValuation,
        this.totalVolume,
        this.high24h,
        this.low24h,
        this.priceChange24h,
        this.priceChangePercentage24h,
        this.marketCapChange24h,
        this.marketCapChangePercentage24h,
        this.circulatingSupply,
        this.totalSupply,
        this.maxSupply,
        this.ath,
        this.athChangePercentage,
        this.athDate,
        this.atl,
        this.atlChangePercentage,
        this.atlDate,
        this.roi,
        this.lastUpdated});

  CoinModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'];
    currentPrice = (json['current_price'] as num?)?.toDouble();
    marketCap = (json['market_cap'] as num?)?.toDouble();
    marketCapRank = (json['market_cap_rank'] as num?)?.toDouble();
    fullyDilutedValuation = (json['fully_diluted_valuation'] as num?)?.toDouble();
    totalVolume = (json['total_volume'] as num?)?.toDouble();

    high24h = (json['high_24h'] as num?)?.toDouble();
    low24h = (json['low_24h'] as num?)?.toDouble();
    priceChange24h = (json['price_change_24h'] as num?)?.toDouble();
    priceChangePercentage24h = (json['price_change_percentage_24h'] as num?)?.toDouble();
    marketCapChange24h = (json['market_cap_change_24h'] as num?)?.toDouble();
    marketCapChangePercentage24h = (json['market_cap_change_percentage_24h'] as num?)?.toDouble();
    circulatingSupply = (json['circulating_supply'] as num?)?.toDouble();
    totalSupply = (json['total_supply'] as num?)?.toDouble();
    maxSupply = (json['max_supply'] as num?)?.toDouble();
    ath = (json['ath'] as num?)?.toDouble();
    athChangePercentage = (json['ath_change_percentage'] as num?)?.toDouble();
    athDate = json['ath_date'];
    atl = (json['atl'] as num?)?.toDouble();
    atlChangePercentage = (json['atl_change_percentage'] as num?)?.toDouble();
    atlDate = json['atl_date'];
    roi = json['roi'] != null ? new Roi.fromJson(json['roi']) : null;
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    data['image'] = this.image;
    data['current_price'] = this.currentPrice;
    data['market_cap'] = this.marketCap;
    data['market_cap_rank'] = this.marketCapRank;
    data['fully_diluted_valuation'] = this.fullyDilutedValuation;
    data['total_volume'] = this.totalVolume;
    data['high_24h'] = this.high24h;
    data['low_24h'] = this.low24h;
    data['price_change_24h'] = this.priceChange24h;
    data['price_change_percentage_24h'] = this.priceChangePercentage24h;
    data['market_cap_change_24h'] = this.marketCapChange24h;
    data['market_cap_change_percentage_24h'] =
        this.marketCapChangePercentage24h;
    data['circulating_supply'] = this.circulatingSupply;
    data['total_supply'] = this.totalSupply;
    data['max_supply'] = this.maxSupply;
    data['ath'] = this.ath;
    data['ath_change_percentage'] = this.athChangePercentage;
    data['ath_date'] = this.athDate;
    data['atl'] = this.atl;
    data['atl_change_percentage'] = this.atlChangePercentage;
    data['atl_date'] = this.atlDate;
    if (this.roi != null) {
      data['roi'] = this.roi!.toJson();
    }
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}

class Roi {
  double? times;
  String? currency;
  double? percentage;

  Roi({this.times, this.currency, this.percentage});

  Roi.fromJson(Map<String, dynamic> json) {
    times = (json['times'] as num?)?.toDouble();
    currency = json['currency'];
    percentage = (json['percentage'] as num?)?.toDouble();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['times'] = this.times;
    data['currency'] = this.currency;
    data['percentage'] = this.percentage;
    return data;
  }
}
