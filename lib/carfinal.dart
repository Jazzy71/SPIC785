import 'package:carnest/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'home.dart';

class CarPriceScreen extends StatefulWidget {
  final String carName;
  final String carImage;
  final String location;
  final String transmission;
  final String fuelType;
  final int registrationYear;
  final String kmDriven;
  final String selectedBrandName;

  const CarPriceScreen({
    super.key,
    required this.carName,
    required this.carImage,
    required this.location,
    required this.transmission,
    required this.fuelType,
    required this.registrationYear,
    required this.kmDriven,
    required this.selectedBrandName,
  });

  @override
  State<CarPriceScreen> createState() => _CarPriceScreenState();
}

class _CarPriceScreenState extends State<CarPriceScreen> {
  // Replace with your actual backend URL
  String baseUrl = "${Url.Urls}"; // Change this to your backend URL
  bool isSendingData = false;

  @override
  void initState() {
    super.initState();
    // Send data to backend when the page loads
    _sendEvaluationData();
  }

  Future<void> _sendEvaluationData() async {
    setState(() {
      isSendingData = true;
    });

    try {
      final priceRange = _calculatePriceRange();

      final response = await http.post(
        Uri.parse('$baseUrl/evaluate'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': '${widget.selectedBrandName} ${widget.carName}',
          'location': widget.location,
          'type': widget.transmission,
          'year': widget.registrationYear.toString(),
          'km': widget.kmDriven,
          'fuel': widget.fuelType,
          'price': priceRange,
        }),
      );

      if (response.statusCode == 201) {
        // Data sent successfully
        print('Evaluation data sent successfully');
      } else {
        // Handle error
        print('Failed to send evaluation data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network error
      print('Network error while sending evaluation data: $e');
    } finally {
      setState(() {
        isSendingData = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Header Section
              _buildHeaderSection(),

              const SizedBox(height: 32),

              // Car Details Section with Image
              _buildCarDetailsSection(),

              const SizedBox(height: 32),

              // Car Specifications Chips
              _buildSpecificationChips(),

              const SizedBox(height: 40),

              // Price Section
              _buildPriceSection(),

              const SizedBox(height: 40),

              // Book Evaluation Button
              _buildBookEvaluationButton(context),

              const SizedBox(height: 16),

              // Disclaimer
              _buildDisclaimer(),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Car Valuation',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  if (isSendingData) ...[
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Based on your car configuration',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade100,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCarDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
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
            'Your Car Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Complete configuration summary',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 20),

          // Car Image and Basic Info
          Row(
            children: [
              // Car Image Container
              Container(
                width: 100,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    widget.carImage,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.directions_car,
                        size: 40,
                        color: Colors.grey.shade500,
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Car Name and Brand
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.selectedBrandName,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.carName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Model Year ${widget.registrationYear}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
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

  Widget _buildSpecificationChips() {
    return Container(
      padding: const EdgeInsets.all(24),
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
            'Car Specifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildSpecChip(widget.carName, Icons.directions_car, Colors.blue),
              _buildSpecChip(widget.location, Icons.location_on, Colors.green),
              _buildSpecChip(widget.transmission, Icons.settings, Colors.orange),
              _buildSpecChip(widget.registrationYear.toString(), Icons.calendar_today, Colors.purple),
              _buildSpecChip(widget.kmDriven, Icons.speed, Colors.red),
              _buildSpecChip(widget.fuelType, _getFuelIcon(widget.fuelType), _getFuelColor(widget.fuelType)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecChip(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 16,
              color: color,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
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

  Widget _buildPriceSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade50,
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.blue.shade100,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.stars,
            size: 40,
            color: Colors.blue.shade600,
          ),
          const SizedBox(height: 16),
          Text(
            'Here is your',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            'car price',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.blue.shade200,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade100,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              _calculatePriceRange(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Estimated market value based on current conditions',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookEvaluationButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _showBookingConfirmation(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade700,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          shadowColor: Colors.grey.shade400,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              'Book Evaluation',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisclaimer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'No additional charges • Cancel anytime',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Professional evaluation includes physical inspection, documentation verification, and final price confirmation.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Helper method to calculate price based on car details
  // Helper method to calculate price based on car details
  String _calculatePriceRange() {
    // Basic price calculation logic based on car details
    int basePrice = _getBasePriceForBrand(widget.selectedBrandName);

    // Adjust based on registration year
    int currentYear = DateTime.now().year;
    int carAge = currentYear - widget.registrationYear;
    double depreciation = carAge * 0.08; // Reduced from 0.1 to 0.08 (8% per year)

    // Cap depreciation at maximum 60% to prevent negative prices
    if (depreciation > 0.6) {
      depreciation = 0.6;
    }

    // Adjust based on KM driven
    double kmDepreciation = 0;
    if (widget.kmDriven.contains('0 - 10,000')) {
      kmDepreciation = 0;
    } else if (widget.kmDriven.contains('10,000 - 20,000')) {
      kmDepreciation = 0.05;
    } else if (widget.kmDriven.contains('20,000 - 30,000')) {
      kmDepreciation = 0.1;
    } else if (widget.kmDriven.contains('30,000 - 40,000')) {
      kmDepreciation = 0.15;
    } else if (widget.kmDriven.contains('40,000 - 50,000')) {
      kmDepreciation = 0.2;
    } else if (widget.kmDriven.contains('50,000 - 60,000')) {
      kmDepreciation = 0.25;
    } else if (widget.kmDriven.contains('60,000 - 70,000')) {
      kmDepreciation = 0.3;
    } else {
      kmDepreciation = 0.35;
    }

    // Cap total depreciation at 80% to ensure minimum price
    double totalDepreciation = depreciation + kmDepreciation;
    if (totalDepreciation > 0.8) {
      totalDepreciation = 0.8;
    }

    // Calculate final price
    double finalPrice = basePrice * (1 - totalDepreciation);

    // Ensure minimum price (at least 15% of base price)
    double minimumPrice = basePrice * 0.15;
    if (finalPrice < minimumPrice) {
      finalPrice = minimumPrice;
    }

    int minPrice = (finalPrice * 0.95).round();
    int maxPrice = (finalPrice * 1.05).round();

    // Final safety check to ensure positive prices
    if (minPrice <= 0) minPrice = (basePrice * 0.1).round();
    if (maxPrice <= 0) maxPrice = (basePrice * 0.15).round();

    return '₹ ${_formatPrice(minPrice)} - ₹ ${_formatPrice(maxPrice)}';
  }

  // New method to get base price based on brand
  int _getBasePriceForBrand(String brandName) {
    switch (brandName.toLowerCase()) {
      case 'hyundai':
        return 1200000;
      case 'maruti suzuki':
      case 'maruti':
        return 800000;
      case 'tata':
        return 1000000;
      case 'honda':
        return 1400000;
      case 'toyota':
        return 1600000;
      case 'mahindra':
        return 1300000;
      case 'kia':
        return 1200000;
      case 'volkswagen':
        return 1500000;
      case 'skoda':
        return 1400000;
      case 'nissan':
        return 1100000;
      case 'ford':
        return 1200000;
      case 'renault':
        return 900000;
      case 'bmw':
        return 4000000;
      case 'mercedes-benz':
      case 'mercedes':
        return 4500000;
      case 'audi':
        return 4200000;
      case 'jaguar':
        return 5000000;
      case 'land rover':
        return 6000000;
      default:
        return 1200000; // Default price if brand not found
    }
  }

  String _formatPrice(int price) {
    if (price >= 10000000) {
      return '${(price / 10000000).toStringAsFixed(2)} Cr';
    } else if (price >= 100000) {
      return '${(price / 100000).toStringAsFixed(2)} L';
    } else {
      return price.toString();
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

  void _showBookingConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),

                Icon(
                  Icons.check_circle,
                  size: 64,
                  color: Colors.green.shade500,
                ),
                const SizedBox(height: 16),

                Text(
                  'Evaluation Booked!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 8),

                Text(
                  'Your car has been evaluated',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 24),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildSummaryRow('Car', '${widget.selectedBrandName} ${widget.carName}'),
                      _buildSummaryRow('Year', widget.registrationYear.toString()),
                      _buildSummaryRow('Location', widget.location),
                      _buildSummaryRow('Transmission', widget.transmission),
                      _buildSummaryRow('Fuel Type', widget.fuelType),
                      _buildSummaryRow('KM Driven', widget.kmDriven),
                      _buildSummaryRow('Estimated Price', _calculatePriceRange()),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the modal
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                            (Route<dynamic> route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Sell',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}