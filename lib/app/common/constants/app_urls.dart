class AppUrl {
  static String userSearchUrl(String searchTerm) =>
      'https://api.github.com/search/users?q=$searchTerm';
}
