class CoinDisplay {
  static void updateCoinDisplay(
      double coinCount, Function(String) updateString) {
    List<String> unity = ["", "K", "M", "B", "T", "Q"];
    int index = 0;

    while (coinCount >= 1000 && index < unity.length - 1) {
      coinCount /= 1000;
      index++;
      if (index >= unity.length - 1 && coinCount >= 1000) {
        break;
      }
    }

    late String formattedText;
    if (index == 0) {
      formattedText = coinCount.toStringAsFixed(0);
    } else {
      formattedText = coinCount.toStringAsFixed(1) + unity[index];
    }

    updateString(formattedText);
  }
}
