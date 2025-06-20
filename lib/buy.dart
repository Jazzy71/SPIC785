import 'package:carnest/buy_verna.dart';
import 'package:carnest/home.dart';
import 'package:carnest/sell.dart';
import 'package:carnest/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import 'chatbot.dart';
import 'buyer_profile.dart'; // Import the new buyer profile

void main() {
  runApp(CarApp());
}

class CarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CarHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Main Car Home Page
class CarHomePage extends StatefulWidget {
  @override
  _CarHomePageState createState() => _CarHomePageState();
}

class _CarHomePageState extends State<CarHomePage> {
  List<Map<String, dynamic>> evaluatedCars = [];
  bool isLoading = true;
  String baseUrl = "${Url.Urls}";

  @override
  void initState() {
    super.initState();
    _fetchEvaluatedCars();
  }

  Future<void> _fetchEvaluatedCars() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/evaluate'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          evaluatedCars = data.map((car) => {
            'id': car['id'],
            'name': car['name'],
            'location': car['location'],
            'type': car['type'],
            'year': car['year'],
            'km': car['km'],
            'fuel': car['fuel'],
            'price': car['price'],
            'seller_email': car['seller_email'], // Add seller email
            'seller_name': car['seller_name'],   // Add seller name
            'seller_mobile': car['seller_mobile'], // Add seller mobile
            'image': _getCarImage(car['name']),
            'details': '${car['km']} - ${car['fuel']} - ${car['type']}',
          }).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        _showErrorSnackBar('Failed to load cars');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorSnackBar('Network error: Unable to load cars');
    }
  }

  String _getCarImage(String carName) {
    String lowerName = carName.toLowerCase();

    // Map car names to their respective images
    if (lowerName.contains('verna')) {
      return 'assets/verna.png';
    } else if (lowerName.contains('wagon') || lowerName.contains('wagonr')) {
      return 'assets/wagonr.png';
    } else if (lowerName.contains('swift')) {
      return 'assets/swift.png';
    } else if (lowerName.contains('i20')) {
      return 'assets/i20.png';
    } else if (lowerName.contains('creta')) {
      return 'assets/creta.png';
    } else if (lowerName.contains('baleno')) {
      return 'assets/baleno.png';
    } else if (lowerName.contains('city')) {
      return 'assets/city.png';
    } else if (lowerName.contains('innova')) {
      return 'assets/innova.png';
    } else if (lowerName.contains('fortuner')) {
      return 'assets/fortuner.png';
    } else if (lowerName.contains('thar')) {
      return 'assets/thar.png';
    } else if (lowerName.contains('nexon')) {
      return 'assets/nexon.png';
    } else if (lowerName.contains('harrier')) {
      return 'assets/harrier.png';
    } else if (lowerName.contains('safari')) {
      return 'assets/safari.png';
    } else if (lowerName.contains('seltos')) {
      return 'assets/seltos.png';
    } else if (lowerName.contains('sonet')) {
      return 'assets/sonet.png';
    } else if (lowerName.contains('venue')) {
      return 'assets/venue.png';
    } else if (lowerName.contains('brezza') || lowerName.contains('vitara')) {
      return 'assets/brezza.png';
    } else if (lowerName.contains('dzire')) {
      return 'assets/dzire.png';
    } else if (lowerName.contains('alto')) {
      return 'assets/alto.png';
    } else {
      // Default car image for unknown cars
      return 'assets/default_car.png';
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _refreshCars() async {
    setState(() {
      isLoading = true;
    });
    await _fetchEvaluatedCars();
  }

  // Function to launch phone dialer
  Future<void> _launchPhoneDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        _showErrorSnackBar('Could not launch phone dialer');
      }
    } catch (e) {
      _showErrorSnackBar('Error launching phone dialer: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Available Cars',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SellCarScreen()));
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Switch to Sell',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshCars,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: isLoading
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                SizedBox(height: 16),
                Text(
                  'Loading available cars...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          )
              : evaluatedCars.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.car_rental,
                  size: 64,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 16),
                Text(
                  'No cars available',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Pull down to refresh',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          )
              : ListView(
            children: [
              SizedBox(height: 8),
              Text(
                'Cars available for purchase (${evaluatedCars.length})',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),

              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.65,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: evaluatedCars.length,
                itemBuilder: (context, index) {
                  final car = evaluatedCars[index];
                  return Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.grey.shade300,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Car Image
                        Container(
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              car['image'],
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.directions_car,
                                  size: 35,
                                  color: Colors.grey[400],
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 6),

                        // Car Name
                        Text(
                          car['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 3),

                        // Car Details
                        Text(
                          car['details'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 11,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 3),

                        // Location
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 11,
                              color: Colors.grey[500],
                            ),
                            SizedBox(width: 2),
                            Expanded(
                              child: Text(
                                car['location'],
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 10,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),

                        // Price
                        Text(
                          car['price'],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),

                        Spacer(),

                        // Buy Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (car['name'].toLowerCase().contains('verna')) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const CarDetailScreen(),
                                  ),
                                );
                              } else {
                                _showCarDetailsDialog(context, car);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 6),
                              minimumSize: Size(0, 32),
                            ),
                            child: Text(
                              "View Details",
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            // Buy (current screen, do nothing)
          } else if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => HomeScreen()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => CarsBotApp()));
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => BuyerProfileScreen()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Buy'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.car_rental), label: 'CarsBot'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }

  void _showCarDetailsDialog(BuildContext context, Map<String, dynamic> car) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            car['name'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    car['image'],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.directions_car,
                        size: 60,
                        color: Colors.grey[400],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              _buildDetailRow('Year:', car['year']),
              _buildDetailRow('Location:', car['location']),
              _buildDetailRow('Transmission:', car['type']),
              _buildDetailRow('Fuel Type:', car['fuel']),
              _buildDetailRow('KM Driven:', car['km']),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      car['price'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue[700],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Divider(),
              SizedBox(height: 8),
              Text(
                'Seller Information',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              // Use dynamic seller information instead of hardcoded values
              Text('Name: ${car['seller_name'] ?? 'N/A'}'),
              Text('Mobile: ${car['seller_mobile'] ?? 'N/A'}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                // Use dynamic seller mobile number
                String sellerMobile = car['seller_mobile'] ?? '';
                if (sellerMobile.isNotEmpty) {
                  await _launchPhoneDialer(sellerMobile);
                } else {
                  _showErrorSnackBar('Seller mobile number not available');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: Text('Contact Seller'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}