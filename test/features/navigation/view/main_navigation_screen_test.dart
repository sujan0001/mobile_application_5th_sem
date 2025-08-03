import 'package:batch34_b/features/navigation/view_model/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

// Simplified test version of MainNavigationScreen that doesn't depend on service locator
class TestMainNavigationScreen extends StatelessWidget {
  const TestMainNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const Scaffold(body: Center(child: Text('Dashboard Screen'))),
      const Scaffold(body: Center(child: Text('Marketplace Screen'))),
      const Scaffold(body: Center(child: Text('Owned Products Screen'))),
      const Scaffold(body: Center(child: Text('Permissions Screen'))),
      const Scaffold(body: Center(child: Text('Profile Screen'))),
    ];

    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: IndexedStack(
              index: currentIndex,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                context.read<NavigationCubit>().changeTab(index);
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.store),
                  label: 'Marketplace',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.inventory_2),
                  label: 'Owned Products',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.admin_panel_settings),
                  label: 'Permissions',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() {
  group('MainNavigationScreen Tests', () {
    testWidgets('should render navigation screen with bottom navigation bar', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TestMainNavigationScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Verify bottom navigation bar exists
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      
      // Verify all navigation items exist
      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.text('Marketplace'), findsOneWidget);
      expect(find.text('Owned Products'), findsOneWidget);
      expect(find.text('Permissions'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('should have correct number of bottom navigation items', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TestMainNavigationScreen(),
        ),
      );

      await tester.pumpAndSettle();

      final bottomNavBar = tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
      expect(bottomNavBar.items.length, 5);
    });

    testWidgets('should have correct icons for navigation items', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TestMainNavigationScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Check if icons exist in the bottom navigation
      expect(find.byIcon(Icons.dashboard), findsOneWidget);
      expect(find.byIcon(Icons.store), findsOneWidget);
      expect(find.byIcon(Icons.inventory_2), findsOneWidget);
      expect(find.byIcon(Icons.admin_panel_settings), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('should initially show dashboard screen (index 0)', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TestMainNavigationScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // The first screen should be active by default
      final indexedStack = tester.widget<IndexedStack>(find.byType(IndexedStack));
      expect(indexedStack.index, 0);

      // Dashboard content should be in the widget tree
      expect(find.text('Dashboard Screen'), findsOneWidget);
    });

    testWidgets('should change screen when navigation item is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TestMainNavigationScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Initially dashboard should be shown
      var indexedStack = tester.widget<IndexedStack>(find.byType(IndexedStack));
      expect(indexedStack.index, 0);

      // Tap on Marketplace tab (second item)
      await tester.tap(find.text('Marketplace'));
      await tester.pumpAndSettle();

      // IndexedStack should now show index 1
      indexedStack = tester.widget<IndexedStack>(find.byType(IndexedStack));
      expect(indexedStack.index, 1);
    });

    testWidgets('should navigate to all tabs correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TestMainNavigationScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Test navigation to each tab
      final tabTests = [
        ('Dashboard', 0),
        ('Marketplace', 1),
        ('Owned Products', 2),
        ('Permissions', 3),
        ('Profile', 4),
      ];

      for (final (tabName, expectedIndex) in tabTests) {
        // Tap the tab
        await tester.tap(find.text(tabName));
        await tester.pumpAndSettle();

        // Verify the index changed
        final indexedStack = tester.widget<IndexedStack>(find.byType(IndexedStack));
        expect(indexedStack.index, expectedIndex, reason: 'Failed to navigate to $tabName');
      }
    });

    testWidgets('should have IndexedStack with 5 children', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TestMainNavigationScreen(),
        ),
      );

      await tester.pumpAndSettle();

      final indexedStack = tester.widget<IndexedStack>(find.byType(IndexedStack));
      expect(indexedStack.children.length, 5);
    });

    testWidgets('should use BottomNavigationBarType.fixed', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TestMainNavigationScreen(),
        ),
      );

      await tester.pumpAndSettle();

      final bottomNavBar = tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
      expect(bottomNavBar.type, BottomNavigationBarType.fixed);
    });

    testWidgets('should have grey color for unselected items', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TestMainNavigationScreen(),
        ),
      );

      await tester.pumpAndSettle();

      final bottomNavBar = tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
      expect(bottomNavBar.unselectedItemColor, Colors.grey);
    });

    testWidgets('should create NavigationCubit provider', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TestMainNavigationScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Verify BlocProvider for NavigationCubit exists
      expect(find.byType(BlocProvider<NavigationCubit>), findsOneWidget);
    });

    testWidgets('should have proper scaffold structure', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TestMainNavigationScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Should have multiple scaffolds (main + each screen)
      expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
      expect(find.byType(IndexedStack), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

  
    testWidgets('should have correct bottom navigation bar current index', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TestMainNavigationScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Initially should be index 0
      var bottomNavBar = tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
      expect(bottomNavBar.currentIndex, 0);

      // Tap marketplace and check current index
      await tester.tap(find.text('Marketplace'));
      await tester.pumpAndSettle();

      bottomNavBar = tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
      expect(bottomNavBar.currentIndex, 1);
    });

    group('NavigationCubit Unit Tests', () {
      test('should start with index 0', () {
        final cubit = NavigationCubit();
        expect(cubit.state, 0);
        cubit.close();
      });

      test('should change tab correctly', () {
        final cubit = NavigationCubit();
        
        cubit.changeTab(3);
        expect(cubit.state, 3);
        
        cubit.changeTab(1);
        expect(cubit.state, 1);
        
        cubit.close();
      });

      test('should have correct helper methods', () {
        final cubit = NavigationCubit();
        
        cubit.goToMarketplace();
        expect(cubit.state, 1);
        
        cubit.goToProfile();
        expect(cubit.state, 4);
        
        cubit.goToDashboard();
        expect(cubit.state, 0);
        
        cubit.goToPermissions();
        expect(cubit.state, 2);
        
        cubit.goToOwnedProducts();
        expect(cubit.state, 3);
        
        cubit.close();
      });

      test('should emit state changes', () {
        final cubit = NavigationCubit();
        
        expectLater(
          cubit.stream,
          emitsInOrder([1, 2, 0]),
        );
        
        cubit.changeTab(1);
        cubit.changeTab(2);
        cubit.changeTab(0);
        
        cubit.close();
      });
    });

      });
}