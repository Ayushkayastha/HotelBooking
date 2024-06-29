import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define the custom theme
    final ThemeData theme = ThemeData(
      primaryColor: Color.fromARGB(255, 81, 212, 194),
      appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(255, 81, 212, 194),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 81, 212, 194), // Text color
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Color.fromARGB(255, 81, 212, 194)),
        bodyMedium: TextStyle(color: Color.fromARGB(255, 81, 212, 194)),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: Color.fromARGB(255, 81, 212, 194),
        thumbColor: Color.fromARGB(255, 81, 212, 194),
        overlayColor: Color.fromARGB(100, 81, 212, 194),
      ),
      switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.all(Color.fromARGB(100, 81, 212, 194)),
        thumbColor: MaterialStateProperty.all(Color.fromARGB(255, 81, 212, 194)),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(Color.fromARGB(255, 81, 212, 194)),
      ),
    );

    return MaterialApp(
      theme: theme,
      home: Filter(),
    );
  }
}

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  RangeValues _priceRange = RangeValues(100, 800);
  bool _freeBreakfast = false;
  bool _freeParking = false;
  bool _pool = false;
  bool _petFriendly = false;
  bool _freeWifi = false;
  double _distanceFromCityCentre = 5;
  bool _all = true;
  bool _apartment = false;
  bool _home = false;
  bool _villa = false;
  bool _hotel = false;
  bool _resort = false;
  String _selectedLocation = 'All'; // Default location filter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Price Range Filter
            Text('Price (for 1 night)', style: TextStyle(fontSize: 16)),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Color.fromARGB(255, 81, 212, 194),
                inactiveTrackColor: Color.fromARGB(255, 200, 200, 200),
                thumbColor: Color.fromARGB(255, 81, 212, 194),
                overlayColor: Color.fromARGB(100, 81, 212, 194),
                valueIndicatorColor: Color.fromARGB(255, 81, 212, 194), // For the value indicator
              ),
              child: RangeSlider(
                values: _priceRange,
                min: 100,
                max: 800,
                divisions: 7,
                labels: RangeLabels(
                  '\$${_priceRange.start.round()}',
                  '\$${_priceRange.end.round()}',
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _priceRange = values;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${_priceRange.start.round()}'),
                Text('\$${_priceRange.end.round()}'),
              ],
            ),
            SizedBox(height: 16),

            // Popular Filters
            Text('Popular filters', style: TextStyle(fontSize: 16)),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: [
                FilterChip(
                  label: Text('Free Breakfast'),
                  selected: _freeBreakfast,
                  onSelected: (bool selected) {
                    setState(() {
                      _freeBreakfast = selected;
                    });
                  },
                  selectedColor: Color.fromARGB(255, 81, 212, 194),
                ),
                FilterChip(
                  label: Text('Free Parking'),
                  selected: _freeParking,
                  onSelected: (bool selected) {
                    setState(() {
                      _freeParking = selected;
                    });
                  },
                  selectedColor: Color.fromARGB(255, 81, 212, 194),
                ),
                FilterChip(
                  label: Text('Pool'),
                  selected: _pool,
                  onSelected: (bool selected) {
                    setState(() {
                      _pool = selected;
                    });
                  },
                  selectedColor: Color.fromARGB(255, 81, 212, 194),
                ),
                FilterChip(
                  label: Text('Pet Friendly'),
                  selected: _petFriendly,
                  onSelected: (bool selected) {
                    setState(() {
                      _petFriendly = selected;
                    });
                  },
                  selectedColor: Color.fromARGB(255, 81, 212, 194),
                ),
                FilterChip(
                  label: Text('Free Wifi'),
                  selected: _freeWifi,
                  onSelected: (bool selected) {
                    setState(() {
                      _freeWifi = selected;
                    });
                  },
                  selectedColor: Color.fromARGB(255, 81, 212, 194),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Distance from City Centre
            Text('Distance from city centre', style: TextStyle(fontSize: 16)),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Color.fromARGB(255, 81, 212, 194),
                inactiveTrackColor: Color.fromARGB(255, 200, 200, 200),
                thumbColor: Color.fromARGB(255, 81, 212, 194),
                overlayColor: Color.fromARGB(100, 81, 212, 194),
                valueIndicatorColor: Color.fromARGB(255, 81, 212, 194), // For the value indicator
              ),
              child: Slider(
                value: _distanceFromCityCentre,
                min: 0,
                max: 20,
                divisions: 4,
                label: 'Less than ${_distanceFromCityCentre.round()}km',
                onChanged: (double value) {
                  setState(() {
                    _distanceFromCityCentre = value;
                  });
                },
              ),
            ),
            Text('Less than ${_distanceFromCityCentre.round()}km'),
            SizedBox(height: 16),

            // Type of Accommodation
            Text('Type of Accommodation', style: TextStyle(fontSize: 16)),
            SwitchListTile(
              title: Text('All'),
              value: _all,
              onChanged: (bool value) {
                setState(() {
                  _all = value;
                });
              },
              inactiveTrackColor:Color.fromARGB(100, 81, 212, 194),
              activeColor: Color.fromARGB(255, 81, 212, 194),


            ),
            SwitchListTile(
              title: Text('Single Room'),
              value: _apartment,
              onChanged: (bool value) {
                setState(() {
                  _apartment = value;
                });
              },
              inactiveTrackColor:Color.fromARGB(100, 81, 212, 194),
              activeColor: Color.fromARGB(255, 81, 212, 194),
            ),
            SwitchListTile(
              title: Text('Couple Room'),
              value: _home,
              onChanged: (bool value) {
                setState(() {
                  _home = value;
                });
              },
              inactiveTrackColor:Color.fromARGB(100, 81, 212, 194),
              activeColor: Color.fromARGB(255, 81, 212, 194),
            ),
            SwitchListTile(
              title: Text('Group Room'),
              value: _villa,
              onChanged: (bool value) {
                setState(() {
                  _villa = value;
                });
              },
              inactiveTrackColor:Color.fromARGB(100, 81, 212, 194),
              activeColor: Color.fromARGB(255, 81, 212, 194),
            ),

            SizedBox(height: 16),

            // Location Filter
            Text('Location', style: TextStyle(fontSize: 16)),
            DropdownButton<String>(
              value: _selectedLocation,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLocation = newValue!;
                });
              },
              items: <String>['All', 'City Center', 'Suburbs', 'Near Airport']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),

            // Apply Button
            ElevatedButton(
              onPressed: () {
                // Handle apply filters action
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 81, 212, 194),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text('Apply', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
