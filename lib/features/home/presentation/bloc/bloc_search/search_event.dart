abstract class SearchEvent {
  const SearchEvent();
}

// Event when the search text changes (user types or chips selected)
class SearchTextChanged extends SearchEvent {
  final String text;

  const SearchTextChanged(this.text);
}

// Event when the clear icon/button is pressed to clear search input
class SearchClearPressed extends SearchEvent {
  const SearchClearPressed();
}
