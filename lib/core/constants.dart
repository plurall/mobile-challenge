const baseUrl = 'https://api.github.com';
const apiToken = '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';

enum Status {
  idle,
  fetching,
  fetched,
  submitting,
  submitted,
  failure,
  successful
}
