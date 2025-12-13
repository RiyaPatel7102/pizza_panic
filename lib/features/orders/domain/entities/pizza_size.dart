/// Pizza size enum
/// Represents available pizza sizes
enum PizzaSize {
  small('Small'),
  medium('Medium'),
  large('Large'),
  extraLarge('Extra Large');

  const PizzaSize(this.displayName);

  final String displayName;

  /// Create PizzaSize from string value
  static PizzaSize fromString(String value) {
    return PizzaSize.values.firstWhere(
      (size) => size.displayName.toLowerCase() == value.toLowerCase(),
      orElse: () => PizzaSize.medium,
    );
  }
}
