import 'package:batch34_b/app/constant/api_endpoints.dart';

String getBackendImageUrl(String? filepath) {
  if (filepath == null || filepath.isEmpty) {
    return "";
  }
  
  // Clean up the file path (replace backslashes with forward slashes)
  String cleanPath = filepath.replaceAll(r'\', '/');
  
  // Debug print to see what we're working with
  print('ApiEndpoints.imageUrl: ${ApiEndpoints.imageUrl}');
  print('Clean filepath: $cleanPath');
  
  // If the filepath already starts with "uploads/", remove it since imageUrl already includes it
  if (cleanPath.startsWith('uploads/')) {
    cleanPath = cleanPath.substring(8); // Remove "uploads/" from the beginning
  }
  
  // Remove leading slash if present
  if (cleanPath.startsWith('/')) {
    cleanPath = cleanPath.substring(1);
  }
  
  final String finalUrl = '${ApiEndpoints.imageUrl}$cleanPath';
  print('Final image URL: $finalUrl');
  
  return finalUrl;
}