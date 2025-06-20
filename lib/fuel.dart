import 'package:carnest/reg.dart';
import 'package:flutter/material.dart';

class TransmissionFuelSelectionScreen extends StatefulWidget {
  final String selectedCarName;
  final String selectedCarImage;
  final String selectedLocation;
  final String selectedBrandName;


  const TransmissionFuelSelectionScreen({
    super.key,
    required this.selectedCarName,
    required this.selectedCarImage,
    required this.selectedLocation,
    required this.selectedBrandName,
  });

  @override
  State<TransmissionFuelSelectionScreen> createState() => _TransmissionFuelSelectionScreenState();
}

class _TransmissionFuelSelectionScreenState extends State<TransmissionFuelSelectionScreen> {
  String selectedTransmission = '';
  String selectedFuel = '';

  final List<Map<String, dynamic>> transmissions = [
    {
      'type': 'Automatic',
      'description': 'Smooth driving experience',
      'icon': Icons.settings_applications,
    },
    {
      'type': 'Manual',
      'description': 'Full control over gears',
      'icon': Icons.tune,
    },
  ];

  final List<Map<String, dynamic>> fuelTypes = [
    {
      'type': 'Petrol',
      'description': 'High performance engine',
      'icon': Icons.local_gas_station,
      'color': Colors.orange,
    },
    {
      'type': 'Diesel',
      'description': 'Better fuel efficiency',
      'icon': Icons.local_gas_station,
      'color': Colors.green,
    },
    {
      'type': 'Electric',
      'description': 'Eco-friendly option',
      'icon': Icons.electric_bolt,
      'color': Colors.blue,
    },
  ];

  bool get canProceed => selectedTransmission.isNotEmpty && selectedFuel.isNotEmpty;

  @override
  Widget build(BuildContext context) {
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
          'Configure Your Car',
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

                    // Selected Car & Location Info
                    _buildSelectionSummary(),

                    const SizedBox(height: 32),

                    // Transmission Selection
                    _buildSectionHeader(
                      'Select Transmission',
                      'Choose your preferred transmission type',
                    ),

                    const SizedBox(height: 16),

                    ...transmissions.map((transmission) => _buildTransmissionTile(transmission)),

                    const SizedBox(height: 32),

                    // Fuel Type Selection
                    _buildSectionHeader(
                      'Select Fuel Type',
                      'Pick the fuel type that suits you',
                    ),

                    const SizedBox(height: 16),

                    ...fuelTypes.map((fuel) => _buildFuelTile(fuel)),

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

  Widget _buildSelectionSummary() {
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
            'Your Selection',
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

              // Car Details - Fixed overflow issue
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Use Wrap widget to handle overflow
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildInfoChip(widget.selectedBrandName, Icons.car_rental),

                        _buildInfoChip(widget.selectedCarName, Icons.directions_car),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Single chip on new line
                    _buildInfoChip(widget.selectedLocation, Icons.location_on),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blue.shade200,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: Colors.blue.shade700,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade700,
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

  Widget _buildTransmissionTile(Map<String, dynamic> transmission) {
    final isSelected = selectedTransmission == transmission['type'];

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
              selectedTransmission = transmission['type'];
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
                    transmission['icon'],
                    size: 24,
                    color: isSelected ? Colors.blue.shade600 : Colors.grey.shade600,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transmission['type'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.blue.shade700 : Colors.grey.shade800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        transmission['description'],
                        style: TextStyle(
                          fontSize: 14,
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
  }

  Widget _buildFuelTile(Map<String, dynamic> fuel) {
    final isSelected = selectedFuel == fuel['type'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? fuel['color'] : Colors.grey.shade200,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: isSelected ? [
          BoxShadow(
            color: fuel['color'].withOpacity(0.2),
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
              selectedFuel = fuel['type'];
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? fuel['color'].withOpacity(0.1) : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    fuel['icon'],
                    size: 24,
                    color: isSelected ? fuel['color'] : Colors.grey.shade600,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fuel['type'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? fuel['color'] : Colors.grey.shade800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        fuel['description'],
                        style: TextStyle(
                          fontSize: 14,
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
                      color: fuel['color'],
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
            onPressed: canProceed ? () {
              // Navigate to registration screen with all selected data
              _proceedToNext();
            } : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: canProceed ? Colors.blue.shade600 : Colors.grey.shade300,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: canProceed ? 4 : 0,
              shadowColor: Colors.blue.shade200,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  canProceed ? 'Continue' : 'Select transmission & fuel type',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: canProceed ? Colors.white : Colors.grey.shade600,
                  ),
                ),
                if (canProceed) ...[
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

  void _proceedToNext() {
    // Navigate to the registration screen with all the selected data
    print('Selected Car: ${widget.selectedCarName}');
    print('Selected Location: ${widget.selectedLocation}');
    print('Selected Transmission: $selectedTransmission');
    print('Selected Fuel: $selectedFuel');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarRegistrationScreen(
          selectedCarName: widget.selectedCarName,
          selectedCarImage: widget.selectedCarImage,
          selectedLocation: widget.selectedLocation,
          selectedTransmission: selectedTransmission,
          selectedFuelType: selectedFuel,
          selectedBrandName: widget.selectedBrandName, // Fixed here
        ),
      ),
    );
  }

}