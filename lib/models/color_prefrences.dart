class ColorPreferences {
  List<String> favouriteColors;
  List<String> avoidedColors;

  ColorPreferences(
      {required this.favouriteColors, required this.avoidedColors});

  Map<String, dynamic> toJson() {
    return {
      "colours": favouriteColors,
      "avoidedColours": avoidedColors,
    };
  }
}
