class Urls {
  static const domain = "beta2.arzan.info";
  static const api = "https://$domain/api/v1";
  static const login = "$api/account/login";

  static String queryChecer(String query, dynamic value) =>
      value != null ? "$query$value" : "";

  static String discounts(
    int limit,
    int offset, {
    int? categoryId,
    int? subCategoryId,
    int? publicationTypeId,
  }) {
    final qCategory = queryChecer("&category_id=", categoryId);
    final qSubCategoryId = queryChecer("&sub_category_id=", subCategoryId);
    final qPublicationTypeId =
        queryChecer("&publication_type_id=", publicationTypeId ?? 1);
    return '''$api/post${limit > 0 ? "?limit=$limit" : ""}${offset > 0 ? "&offset=$offset" : ""}$qCategory$qSubCategoryId$qPublicationTypeId&status=approved''';
  }

  static String disDetal(int id) => "$api/post/$id";

  static const badgePost = "$api/post/badge";
}
