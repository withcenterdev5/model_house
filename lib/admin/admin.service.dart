/// AdminService
///
///
class AdminService {
  static AdminService? _instance;
  static AdminService get instance => _instance ??= AdminService();

  bool initialized = false;

  /// Initialize the AdminService
  init() {
    initialized = true;
  }
}
