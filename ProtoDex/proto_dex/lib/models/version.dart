class Data {
  final Version app;
  final Version dex;
  final Version tracker;
  final Version collection;
  final Version lookingFor;
  final Version forTrade;

  const Data(
      {required this.app,
      required this.dex,
      required this.tracker,
      required this.collection,
      required this.lookingFor,
      required this.forTrade});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      app: Version(
        major: getMajor(json['appVersion']),
        minor: getMinor((json['appVersion'])),
        build: getBuild((json['appVersion'])),
      ),
      dex: Version(
        major: getMajor(json['dexVersion']),
        minor: getMinor((json['dexVersion'])),
        build: getBuild((json['dexVersion'])),
      ),
      tracker: Version(
        major: getMajor(json['trackerVersion']),
        minor: getMinor((json['trackerVersion'])),
        build: getBuild((json['trackerVersion'])),
      ),
      collection: Version(
        major: getMajor(json['collectionVersion']),
        minor: getMinor((json['collectionVersion'])),
        build: getBuild((json['collectionVersion'])),
      ),
      lookingFor: Version(
        major: getMajor(json['lookingForVersion']),
        minor: getMinor((json['lookingForVersion'])),
        build: getBuild((json['lookingForVersion'])),
      ),
      forTrade: Version(
        major: getMajor(json['forTradeVersion']),
        minor: getMinor((json['forTradeVersion'])),
        build: getBuild((json['forTradeVersion'])),
      ),
    );
  }

  static int getMajor(String data) {
    return int.parse(data.split('.')[0]);
  }

  static int getMinor(String data) {
    return int.parse(data.split('.')[1]);
  }

  static int getBuild(String data) {
    return int.parse(data.split('.')[2]);
  }
}

class Version {
  final int major;
  final int minor;
  final int build;

  const Version({
    required this.major,
    required this.minor,
    required this.build,
  });
}
