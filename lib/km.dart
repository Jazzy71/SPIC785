import 'package:flutter/material.dart';

import 'carfinal.dart';

class KmSelectionScreen extends StatefulWidget {
  final String selectedCarName;
  final String selectedCarImage;
  final String selectedLocation;
  final String selectedTransmission;
  final String selectedFuelType;
  final int registrationYear;
  final String selectedBrandName;

  const KmSelectionScreen({
    super.key,
    required this.selectedCarName,
    required this.selectedCarImage,
    required this.selectedLocation,
    required this.selectedTransmission,
    required this.selectedFuelType,
    required this.registrationYear,
    required this.selectedBrandName,
  });

  @override
  State<KmSelectionScreen> createState() => _KmSelectionScreenState();
}

class _KmSelectionScreenState extends State<KmSelectionScreen> {
  int? selectedRangeIndex;
  String searchQuery = '';

  final List<Map<String, dynamic>> kmRanges = [
    {"range": "0 - 10,000 km", "icon": Icons.new_releases, "color": Colors.green},
    {"range": "10,000 - 20,000 km", "icon": Icons.directions_car, "color": Colors.blue},
    {"range": "20,000 - 30,000 km", "icon": Icons.speed, "color": Colors.orange},
    {"range": "30,000 - 40,000 km", "icon": Icons.timeline, "color": Colors.purple},
    {"range": "40,000 - 50,000 km", "icon": Icons.trending_up, "color": Colors.red},
    {"range": "50,000 - 60,000 km", "icon": Icons.show_chart, "color": Colors.teal},
    {"range": "60,000 - 70,000 km", "icon": Icons.analytics, "color": Colors.indigo},
    {"range": "70,000+ km", "icon": Icons.motorcycle, "color": Colors.brown},
  ];

  @override
  void initState() {
    super.initState();
    selectedRangeIndex = 1; // Default selection
  }

  @override
  Widget build(BuildContext context) {
    final filteredRanges = kmRanges.where((range) =>
        range["range"].toString().toLowerCase().contains(searchQuery.toLowerCase())
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
          'Kilometers Driven',
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Car Details Summary
                    _buildCarDetailsSummary(),

                    const SizedBox(height: 32),

                    // KM Selection Header
                    _buildSectionHeader(
                      'Select Kilometers Driven',
                      'Choose the total distance your car has traveled',
                    ),

                    const SizedBox(height: 16),

                    // Search Field
                    _buildSearchField(),

                    const SizedBox(height: 20),

                    // KM Range List
                    _buildKmRangeList(filteredRanges),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Continue Button
            _buildContinueButton(),
          ],
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
                    // Third row - fuel type and year
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildInfoChip(widget.selectedFuelType, _getFuelIcon(widget.selectedFuelType), _getFuelColor(widget.selectedFuelType)),
                        _buildInfoChip(widget.registrationYear.toString(), Icons.calendar_today, Colors.purple),
                      ],
                    ),
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
          hintText: "Search kilometer range...",
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

  Widget _buildKmRangeList(List<Map<String, dynamic>> filteredRanges) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.4,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: filteredRanges.length,
        itemBuilder: (context, index) {
          final rangeData = filteredRanges[index];
          final originalIndex = kmRanges.indexOf(rangeData);
          final isSelected = originalIndex == selectedRangeIndex;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? rangeData["color"].withOpacity(0.5) : Colors.grey.shade200,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected ? [
                BoxShadow(
                  color: rangeData["color"].withOpacity(0.2),
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
                    selectedRangeIndex = originalIndex;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? rangeData["color"].withOpacity(0.1)
                              : Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          rangeData["icon"],
                          size: 24,
                          color: isSelected
                              ? rangeData["color"]
                              : Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              rangeData["range"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? rangeData["color"]
                                    : Colors.grey.shade800,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _getKmDescription(originalIndex),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (isSelected)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: rangeData["color"],
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

  Widget _buildContinueButton() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: selectedRangeIndex != null ? () {
              _proceedToNext();
            } : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedRangeIndex != null
                  ? Colors.blue.shade600
                  : Colors.grey.shade300,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: selectedRangeIndex != null ? 4 : 0,
              shadowColor: Colors.blue.shade200,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedRangeIndex != null
                      ? 'Continue'
                      : 'Select kilometer range',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: selectedRangeIndex != null
                        ? Colors.white
                        : Colors.grey.shade600,
                  ),
                ),
                if (selectedRangeIndex != null) ...[
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 20),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getKmDescription(int index) {
    switch (index) {
      case 0:
        return "Like new condition";
      case 1:
        return "Excellent condition";
      case 2:
        return "Very good condition";
      case 3:
        return "Good condition";
      case 4:
        return "Fair condition";
      case 5:
        return "Well maintained";
      case 6:
        return "Regular maintenance needed";
      case 7:
        return "High mileage vehicle";
      default:
        return "Standard condition";
    }
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
    final selectedRange = selectedRangeIndex != null
        ? kmRanges[selectedRangeIndex!]["range"]
        : null;

    // Navigate to CarPriceScreen with all details
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarPriceScreen(
          carName: widget.selectedCarName,
          carImage: widget.selectedCarImage,
          location: widget.selectedLocation,
          transmission: widget.selectedTransmission,
          fuelType: widget.selectedFuelType,
          registrationYear: widget.registrationYear,
          kmDriven: selectedRange!,
          selectedBrandName: widget.selectedBrandName,
        ),
      ),
    );
  }
}