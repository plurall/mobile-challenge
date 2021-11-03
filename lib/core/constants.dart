const baseUrl = 'https://api.github.com';

enum Status {
  idle,
  fetching,
  fetched,
  submitting,
  submitted,
  failure,
  successful
}
