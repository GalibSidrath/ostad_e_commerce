class Urls {
  static const String _baseUrl = 'https://ecommerce-api.codesilicon.com/api';

  static const String homeSliderListUrl = '$_baseUrl/ListProductSlider';
  static const String categoryListUrl = '$_baseUrl/CategoryList';
  static String productListByRemark({required String remark}) =>
      '$_baseUrl/ListProductByRemark/$remark';

  static String categoryListById({required int id}) =>
      '$_baseUrl/ListProductByCategory/$id';
}
