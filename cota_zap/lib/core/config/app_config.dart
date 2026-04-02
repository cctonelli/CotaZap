// core/config/app_config.dart
class AppConfig {
  static const String appName = 'CotaZap';
  static const String version = '1.0.0';
  
  // Supabase Config
  static const String supabaseUrl = 'https://juckbmlcantjoyjpotbs.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp1Y2tibWxjYW50am95anBvdGJzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUwNzkxOTUsImV4cCI6MjA5MDY1NTE5NX0.4TbPn6ZO4m30sE55_L34PWLno8TPMCwg4U7m31JgZsw';

  // FastAPI API URL
  static const String apiBaseUrl = 'http://localhost:8000'; // Alterar após deploy do backend
}
