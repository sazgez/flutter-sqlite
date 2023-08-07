mixin class ProductValidation {
  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Specify the name of the product';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value!.isEmpty) {
      return 'Specify the description of the product';
    }
    return null;
  }

  String? validateUnitPrice(String? value) {
    if (value!.isEmpty) {
      return 'Specify the unit price of the product';
    } else if (double.parse(value) <= 0.0) {
      return 'The unit price must be greater than 0 (exclusive)';
    }
    return null;
  }
}
