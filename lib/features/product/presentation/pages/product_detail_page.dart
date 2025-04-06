import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/widgets/common_snackbar.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> category;

  ProductDetailPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category['name'] ?? 'Category Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Action for editing the category
              AppSnackBar.show(
                context,
                content: 'Edit category tapped!',
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Action for deleting the category
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Delete Category'),
                    content: const Text(
                        'Are you sure you want to delete this category?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Category deleted!')),
                          );
                          // Perform delete action here, such as calling a function to delete the category
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/vehicle_img.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            // if (category['images'] != null &&
            //     (category['images'] as List<dynamic>).isNotEmpty)
            //   Image.network(
            //     category['images'][0], // Display the first image in the list
            //     width: double.infinity,
            //     height: 200, // Adjust the height as needed
            //     fit: BoxFit.cover,
            //   ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.category, color: AppColors.orange),
                    title: const Text('Category Name'),
                    subtitle: Text(category['name'] ?? 'Unknown'),
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.branding_watermark, color: AppColors.orange),
                    title: const Text('Brand'),
                    subtitle: Text(category['brand'] ?? 'Unknown'),
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.model_training, color: AppColors.orange),
                    title: const Text('Model'),
                    subtitle: Text(category['model'] ?? 'Unknown'),
                  ),
                  ListTile(
                    leading: Icon(Icons.attach_money, color: AppColors.orange),
                    title: const Text('Rental Price'),
                    subtitle: Text('\$${category['rentalPrice'] ?? 0.0}'),
                  ),
                  ListTile(
                    leading: Icon(Icons.security, color: AppColors.orange),
                    title: const Text('Security Deposit'),
                    subtitle: Text('\$${category['securityDeposit'] ?? 0.0}'),
                  ),
                  ListTile(
                    leading: Icon(Icons.check_circle, color: AppColors.orange),
                    title: const Text('Availability'),
                    subtitle: Text(category['availability'] ?? 'IN'),
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.local_gas_station, color: AppColors.orange),
                    title: const Text('Fuel Type'),
                    subtitle: Text(category['fuelType'] ?? 'Unknown'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: AppColors.orange),
                    title: const Text('Transmission'),
                    subtitle: Text(category['transmission'] ?? 'Unknown'),
                  ),
                  ListTile(
                    leading: Icon(Icons.event_seat, color: AppColors.orange),
                    title: const Text('Seat Capacity'),
                    subtitle: Text(
                        (category['seatCapacity'] ?? 'Unknown').toString()),
                  ),
                  ListTile(
                    leading: Icon(Icons.confirmation_number,
                        color: AppColors.orange),
                    title: const Text('Registration Number'),
                    subtitle: Text(category['registrationNumber'] ?? 'Unknown'),
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.directions_car, color: AppColors.orange),
                    title: const Text('Vehicle Type'),
                    subtitle: Text(category['vehicleType'] ?? 'Unknown'),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on, color: AppColors.orange),
                    title: const Text('Location'),
                    subtitle: Text(category['location'] ?? 'Unknown'),
                  ),
                  ListTile(
                    leading: Icon(Icons.color_lens, color: AppColors.orange),
                    title: const Text('Color'),
                    subtitle: Text(category['color'] ?? 'Unknown'),
                  ),
                  ListTile(
                    leading: Icon(Icons.description, color: AppColors.orange),
                    title: const Text('Description'),
                    subtitle: Text(category['description'] ?? 'Unknown'),
                  ),
                  if (category['facilities'] != null &&
                      (category['facilities'] as List<dynamic>).isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Facilities:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        ...((category['facilities'] as List<dynamic>)
                            .map((facility) => ListTile(
                                  leading:
                                      Icon(Icons.check, color: AppColors.green),
                                  title: Text(facility),
                                ))
                            .toList()),
                      ],
                    ),
                  if (category['details'] != null &&
                      (category['details'] as List<dynamic>).isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Details:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        ...((category['details'] as List<dynamic>)
                            .map((detail) => ListTile(
                                  leading:
                                      Icon(Icons.info, color: AppColors.orange),
                                  title: Text(detail),
                                ))
                            .toList()),
                      ],
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
