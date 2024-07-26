import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangeNotifier extends ChangeNotifier {
  List<DateTime?> _selectedDates = [DateTime.now(), DateTime.now().add(Duration(days: 1))];

  List<DateTime?> get selectedDates => _selectedDates;

  void updateSelectedDates(List<DateTime?> dates) {
    _selectedDates = dates;
    notifyListeners();
  }

  Map<String, String> formatDateRange() {
    String startDate = '';
    String endDate = '';

    if (_selectedDates.length == 2) {
      DateFormat dateFormat = DateFormat.yMMMMd();
      startDate = dateFormat.format(_selectedDates[0]!);
      endDate = dateFormat.format(_selectedDates[1]!);
    } else if (_selectedDates.length == 1) {
      DateFormat dateFormat = DateFormat.yMMMMd();
      startDate = endDate = dateFormat.format(_selectedDates[0]!);
    }

    return {'startDate': startDate, 'endDate': endDate};
  }
}
