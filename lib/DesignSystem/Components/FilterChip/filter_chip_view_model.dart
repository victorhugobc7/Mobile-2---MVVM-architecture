class FilterChipViewModel {
  final String label;
  final bool isSelected;
  final Function(bool) onSelected;
  final bool showCheckmark;

  FilterChipViewModel({
    required this.label,
    required this.onSelected,
    this.isSelected = false,
    this.showCheckmark = true,
  });
}
