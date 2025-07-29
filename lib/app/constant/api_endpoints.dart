class ApiEndpoints {
  ApiEndpoints._();

  static const connectionTimeout = Duration(seconds: 1000);
  static const receiveTimeout = Duration(seconds: 1000);

  // Replace with your machine's IP if running on a physical device
  // static const String serverAddress = "http://10.0.2.2:5050"; // thsi is done when i am using the android emulator
  static const String serverAddress = "http://192.168.1.10:5050";  //this is used when i am using the physical device
  static const String baseUrl = "$serverAddress/";
  static const String imageUrl = "${serverAddress}/uploads/";

  // Auth endpoints to match your backend routes
  static const String login = "api/auth/login";
  static const String register = "api/auth/register";

  static const String sendResetLink = "api/auth/request-reset";
  static String resetPassword(String token) => "api/auth/reset-password/$token";

  //get all creator
  static const String getAllCreators = "api/auth/GetAllCreators";

  // ─────────────────────────────────────────────────────────────
  // COLLECTIONS
  static const String getAllCollections = "api/collections/allCollection";
  static const String getPublishedCollections = "api/collections/published";
  static String getCollectionById(String id) => "api/collections/$id"; // Auth required

  // ─────────────────────────────────────────────────────────────
  // PRODUCTS (Primary & Secondary Marketplace)
  static const String getAvailableProducts = "api/product/available"; // For dashboard
  static const String getSoldProducts = "api/product/sold";     // For secondary marketplace
  static String getProductById(String id) => "api/product/$id";

  static String requestProductTransfer(String productId) => "api/product/request-transfer/$productId";
  static String resellProduct(String productId) => "api/product/resell/$productId";

 
  // ─────────────────────────────────────────────────────────────
   // OWNERSHIP
  static const String getMyOwnerships = "api/product/ownership/my";

  // ─────────────────────────────────────────────────────────────
  // PERMISSIONS / TRANSFER REQUESTS

  static const String getMYIncomingTransferRequests = "api/product/incoming-transfers";
  static String respondToTransferRequest(String requestId) => "api/product/respond-transfer/$requestId";

  // ─────────────────────────────────────────────────────────────
  // UTILITY FUNCTIONS (Optional for dynamic routing)

  static String getProductsByCollection(String collectionId) => "api/product/collection/$collectionId";
  static String getCreatorProductsInCollection(String collectionId) => "api/product/my/collection/$collectionId";


}
