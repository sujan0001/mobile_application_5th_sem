import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:batch34_b/features/profile/presentation/view_model/profile_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey.shade900,
        
        elevation: 0,
      ),
      body: Consumer<ProfileViewModel>(
        builder: (context, viewModel, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      // Profile Picture
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // User Name (Static)
                      // const Text(
                      //   'John Doe',
                      //   style: TextStyle(
                      //     fontSize: 24,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      const SizedBox(height: 8),
                      // User Role (Static)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Consumer',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Profile Options
                _buildProfileOption(
                  icon: Icons.person_outline,
                  title: 'Edit Profile',
                  subtitle: 'Update your personal information',
                  onTap: () {
                    // TODO: Navigate to edit profile
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Edit Profile - Coming Soon')),
                    );
                  },
                ),
                
                _buildProfileOption(
                  icon: Icons.settings_outlined,
                  title: 'Settings & Privacy',
                  subtitle: 'Manage your account settings',
                  onTap: () {
                    // TODO: Navigate to settings
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Settings - Coming Soon')),
                    );
                  },
                ),
                
                _buildProfileOption(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  subtitle: 'Get help and contact support',
                  onTap: () {
                    // TODO: Navigate to help
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Help & Support - Coming Soon')),
                    );
                  },
                ),
                
                _buildProfileOption(
                  icon: Icons.accessibility_outlined,
                  title: 'Display & Accessibility',
                  subtitle: 'Customize your app experience',
                  onTap: () {
                    // TODO: Navigate to accessibility settings
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Display & Accessibility - Coming Soon')),
                    );
                  },
                ),
                
                const SizedBox(height: 24),
                
                // Logout Button
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: viewModel.isLoggingOut ? null : () {
                      _showLogoutDialog(context, viewModel);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: viewModel.isLoggingOut
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ),
                              SizedBox(width: 12),
                              Text('Logging out...'),
                            ],
                          )
                        : const Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // App Version
                Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          icon,
          size: 24,
          color: Colors.grey[700],
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[400],
        ),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, ProfileViewModel viewModel) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Close dialog first
                Navigator.of(dialogContext).pop();
                
                // Small delay to ensure dialog is closed
                await Future.delayed(const Duration(milliseconds: 100));
                
                // Then call logout with the original context (not dialog context)
                await viewModel.logout(context);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}