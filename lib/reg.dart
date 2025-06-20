import 'package:flutter/material.dart';

import 'km.dart';

class CarRegistrationScreen extends StatefulWidget {
  final String selectedCarName;
  final String selectedCarImage;
  final String selectedLocation;
  final String selectedTransmission;
  final String selectedFuelType;
  final String selectedBrandName;

  const CarRegistrationScreen({
    super.key,
    required this.selectedCarName,
    required this.selectedCarImage,
    required this.selectedLocation,
    required this.selectedTransmission,
    required this.selectedFuelType,
    required this.selectedBrandName,
  });

  @override
  State<CarRegistrationScreen> createState() => _CarRegistrationScreenState();
}

class _CarRegistrationScreenState extends State<CarRegistrationScreen> {
  final List<int> years = List.generate(25, (index) => 2024 - index);
  int? selectedYear;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Removed default selection to prevent auto-navigation on screen load
  }

  @override
  Widget build(BuildContext context) {
    final filteredYears = years.where((year) =>
        year.toString().contains(searchQuery)
    ).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.grey.shade800,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Registration Year',
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // Car Details Summary
              _buildCarDetailsSummary(),

              const SizedBox(height: 32),

              // Registration Year Selection
              _buildSectionHeader(
                'Select Registration Year',
                'Choose when your car was registered',
              ),

              const SizedBox(height: 16),

              // Search Field
              _buildSearchField(),

              const SizedBox(height: 20),

              // Year List
              _buildYearList(filteredYears),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarDetailsSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Car Configuration',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Car Image
              Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    widget.selectedCarImage,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.directions_car,
                        size: 30,
                        color: Colors.grey.shade500,
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Car Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First row of chips
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildInfoChip(widget.selectedBrandName, Icons.car_rental, Colors.blue),

                        _buildInfoChip(widget.selectedCarName, Icons.directions_car, Colors.blue),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Second row of chips
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildInfoChip(widget.selectedLocation, Icons.location_on, Colors.green),
                        _buildInfoChip(widget.selectedTransmission, Icons.settings, Colors.orange),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Third row - fuel type
                    _buildInfoChip(widget.selectedFuelType, _getFuelIcon(widget.selectedFuelType), _getFuelColor(widget.selectedFuelType)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: "Search registration year...",
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 14,
          ),
          prefixIcon: Container(
            padding: const EdgeInsets.all(12),
            child: Icon(
              Icons.search,
              color: Colors.grey.shade500,
              size: 20,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildYearList(List<int> filteredYears) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5, // Increased height since no button at bottom
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: filteredYears.length,
        itemBuilder: (context, index) {
          final year = filteredYears[index];
          final isSelected = year == selectedYear;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? Colors.blue.shade400 : Colors.grey.shade200,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected ? [
                BoxShadow(
                  color: Colors.blue.shade100,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ] : [
                BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  setState(() {
                    selectedYear = year;
                  });
                  // Auto-navigate to KM selection screen after a short delay
                  Future.delayed(const Duration(milliseconds: 300), () {
                    _proceedToNext();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue.shade50 : Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.calendar_today,
                          size: 20,
                          color: isSelected ? Colors.blue.shade600 : Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Text(
                          year.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.blue.shade700 : Colors.grey.shade800,
                          ),
                        ),
                      ),

                      if (isSelected)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade600,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getFuelIcon(String fuelType) {
    switch (fuelType.toLowerCase()) {
      case 'electric':
        return Icons.electric_bolt;
      case 'petrol':
      case 'diesel':
        return Icons.local_gas_station;
      default:
        return Icons.local_gas_station;
    }
  }

  Color _getFuelColor(String fuelType) {
    switch (fuelType.toLowerCase()) {
      case 'petrol':
        return Colors.orange;
      case 'diesel':
        return Colors.green;
      case 'electric':
        return Colors.blue;
      default:
        return Colors.blue;
    }
  }

  void _proceedToNext() {
    if (selectedYear == null) return;

    // Print all the collected data
    print('=== Complete Car Configuration ===');
    print('Car Name: ${widget.selectedCarName}');
    print('Car Image: ${widget.selectedCarImage}');
    print('Location: ${widget.selectedLocation}');
    print('Transmission: ${widget.selectedTransmission}');
    print('Fuel Type: ${widget.selectedFuelType}');
    print('Registration Year: $selectedYear');

    // Navigate to KM selection screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => KmSelectionScreen(
          selectedCarName: widget.selectedCarName,
          selectedCarImage: widget.selectedCarImage,
          selectedLocation: widget.selectedLocation,
          selectedTransmission: widget.selectedTransmission,
          selectedFuelType: widget.selectedFuelType,
          registrationYear: selectedYear!,
          selectedBrandName: widget.selectedBrandName,
        ),
      ),
    );
  }
}