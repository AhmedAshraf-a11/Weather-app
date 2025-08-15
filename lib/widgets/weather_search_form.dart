import 'package:flutter/material.dart';

class WeatherSearchForm extends StatefulWidget {
  final Function(String) onSearch;
  final bool isLoading;

  const WeatherSearchForm({
    super.key,
    required this.onSearch,
    required this.isLoading,
  });

  @override
  State<WeatherSearchForm> createState() => _WeatherSearchFormState();
}

class _WeatherSearchFormState extends State<WeatherSearchForm> {
  final TextEditingController _cityController = TextEditingController();

  void _handleSearch() {
    if (_cityController.text.trim().isNotEmpty) {
      widget.onSearch(_cityController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _cityController,
            decoration: InputDecoration(
              labelText: 'Enter city name',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _handleSearch(),
            enabled: !widget.isLoading,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: widget.isLoading ? null : _handleSearch,
            child: widget.isLoading
                ? CircularProgressIndicator()
                : Text('Search Weather'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }
}
