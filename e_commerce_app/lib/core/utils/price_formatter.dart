extension PriceFormatter on double {
  String priceFormatter() {
    if (this % 1 == 0) {
      return toInt().toString();
    } else {
      return toString();
    }
  }
}
