class Version {
  final String appVersion;
  final String dexVersion;
  final String trackerVersion;
  final String collectionVersion;
  final String lookingForVersion;
  final String forTradeVersion;

  const Version(
      {required this.appVersion,
      required this.dexVersion,
      required this.trackerVersion,
      required this.collectionVersion,
      required this.lookingForVersion,
      required this.forTradeVersion});

  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(
      appVersion: json['appVersion'],
      dexVersion: json['dexVersion'],
      trackerVersion: json['trackerVersion'],
      collectionVersion: json['collectionVersion'],
      lookingForVersion: json['lookingForVersion'],
      forTradeVersion: json['forTradeVersion'],
    );
  }
}
