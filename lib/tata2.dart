import 'package:flutter/material.dart';
import 'carlocation.dart'; // Adjust as needed
import 'fuel.dart'; // Adjust as needed

class TataSelectionScreen extends StatefulWidget {
  final String brandName;
  final String brandAsset;

  const TataSelectionScreen({
    super.key,
    required this.brandName,
    required this.brandAsset,
  });

  @override
  State<TataSelectionScreen> createState() => _CarModelSelectionScreenState();
}

class _CarModelSelectionScreenState extends State<TataSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> models = const [
    {'name': 'Nexon', 'image': 'assets/nexon.png'},
    {'name': 'Altroz', 'image': 'assets/altroz.png'},
    {'name': 'Punch', 'image': 'assets/punch.png'},
    {'name': 'Tigor', 'image': 'assets/tigor.png'},
  ];

  List<Map<String, String>> filteredModels = [];

  @override
  void initState() {
    super.initState();
    filteredModels = models;
    _searchController.addListener(_filterModels);
  }

  void _filterModels() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredModels = models
          .where((model) => model['name']!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
    'Select Model',
    style: TextStyle(
    color: Colors.grey.shade800,
    fontWeight: FontWeight.bold,
    fontSize: 20,
    ),
    ),
    centerTitle: true,
    actions: [
    Container(
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
    ),
    ],
    ),
    body: SafeArea(
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    const SizedBox(height: 8),
    Container(
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
    child: Row(
    children: [
    Container(
    height: 60,
    width: 100,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
    color: Colors.grey.shade50,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
    color: Colors.grey.shade200,
    width: 1,
    ),
    ),
    child: Image.asset(
    widget.brandAsset,
    fit: BoxFit.contain,
    errorBuilder: (context, error, stackTrace) {
    return Icon(
    Icons.directions_car,
    size: 30,
    color: Colors.grey.shade600,
    );
    },
    ),
    ),
    const SizedBox(width: 16),
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    widget.brandName,
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.grey.shade800,
    letterSpacing: 1,
    ),
    ),
    const SizedBox(height: 4),
    Text(
    'Select your car model',
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
    ),
    const SizedBox(height: 32),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'Find your model',
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.grey.shade800,
    ),
    ),
    const SizedBox(height: 12),
    Container(
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
    BoxShadow(
    color: Colors.grey.shade200,
    blurRadius: 10,
    offset: const Offset(0, 4),
    ),
    ],
    ),
    child: TextField(
    controller: _searchController,
    decoration: InputDecoration(
    hintText: 'Search your car model...',
    hintStyle: TextStyle(
    color: Colors.grey.shade500,
    fontSize: 16,
    ),
    prefixIcon: Icon(
    Icons.search,
    color: Colors.grey.shade500,
    size: 22,
    ),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 16,
    ),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.blue.shade400,
    width: 2,
    ),
    ),
    ),
    ),
    ),
    ],
    ),
    const SizedBox(height: 32),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    'Popular Models',
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.grey.shade800,
    ),
    ),
    Text(
    '${filteredModels.length} models',
    style: TextStyle(
    fontSize: 14,
    color: Colors.grey.shade600,
    ),
    ),
    ],
    ),
    const SizedBox(height: 16),
    Expanded(
    child: filteredModels.isEmpty
    ? Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Icon(
    Icons.search_off,
    size: 64,
    color: Colors.grey.shade400,
    ),
    const SizedBox(height: 16),
    Text(
    'No models found',
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade600,
    ),
    ),
    const SizedBox(height: 8),
    Text(
    'Try adjusting your search',
    style: TextStyle(
    fontSize: 14,
    color: Colors.grey.shade500,
    ),
    ),
    ],
    ),
    )
        : ListView.separated(
    physics: const BouncingScrollPhysics(),
    padding: const EdgeInsets.only(bottom: 24),
    itemCount: filteredModels.length,
    separatorBuilder: (_, __) => const SizedBox(height: 16),
    itemBuilder: (context, index) {
    final model = filteredModels[index];
    return CarModelTile(
    name: model['name']!,
    imagePath: model['image']!,
    brandName: widget.brandName,
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => LocationSelectionScreen(
    selectedCarName: model['name']!,
    selectedCarImage: model['image']!,
      brandName: widget.brandName,
    ),
    ),
    );
    },
    );
    },
    ),
    ),
    ],
    ),
    ),
    ),
    );
  }
}

class CarModelTile extends StatelessWidget {
  final String name;
  final String imagePath;
  final String brandName;
  final VoidCallback? onTap;

  const CarModelTile({
    super.key,
    required this.name,
    required this.imagePath,
    required this.brandName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 120,
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
                      imagePath,
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
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        brandName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.blue.shade200,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'Available',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade600,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
