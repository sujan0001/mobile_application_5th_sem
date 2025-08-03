import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';

// Import your actual files
import 'package:batch34_b/features/owned_products/presentation/view/my_owned_products_view.dart';
import 'package:batch34_b/features/owned_products/presentation/view_model/owned_products_bloc.dart';
import 'package:batch34_b/features/owned_products/presentation/view_model/owned_products_state.dart';
import 'package:batch34_b/features/owned_products/presentation/view_model/owned_products_event.dart';
import 'package:batch34_b/features/owned_products/domain/entity/owned_product_entity.dart';

// Mock BLoC using mocktail
class MockOwnedProductsBloc extends MockBloc<OwnedProductsEvent, OwnedProductsState> 
    implements OwnedProductsBloc {}

void main() {
  group('MyOwnedProductsView Tests', () {
    late MockOwnedProductsBloc mockBloc;
    late GetIt serviceLocator;

    // Create test data
    final testCreator = CreatorEntity(
      id: '1',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@test.com',
      role: 'creator',
      isDeleted: false,
      createdAt: '2024-01-01',
      updatedAt: '2024-01-01',
    );

    final testCollection = CollectionEntity(
      id: '1',
      title: 'Test Collection',
      description: 'Test Description',
      coverImage: 'test.jpg',
      creator: '1',
      certified: true,
      isDeleted: false,
      createdAt: '2024-01-01',
      updatedAt: '2024-01-01',
    );

    final testPendingTransfer = PendingTransferEntity(
      isPending: false,
      buyer: null,
    );

    final testProduct = OwnedProductEntity(
      id: '1',
      name: 'Test Product',
      description: 'Test Description',
      image: 'test.jpg',
      originalPrice: 1000,
      resalePrice: null,
      onSale: false,
      certified: true,
      creator: testCreator,
      collection: testCollection,
      pendingTransfer: testPendingTransfer,
      owner: '1',
      soldHistory: [],
      createdAt: '2024-01-01',
      updatedAt: '2024-01-01',
    );

    final testProductOnSale = OwnedProductEntity(
      id: '2',
      name: 'Product On Sale',
      description: 'Test Description',
      image: 'test.jpg',
      originalPrice: 1000,
      resalePrice: 800,
      onSale: true,
      certified: true,
      creator: testCreator,
      collection: testCollection,
      pendingTransfer: testPendingTransfer,
      owner: '1',
      soldHistory: [],
      createdAt: '2024-01-01',
      updatedAt: '2024-01-01',
    );

    setUp(() {
      mockBloc = MockOwnedProductsBloc();
      serviceLocator = GetIt.instance;
      
      // Reset service locator and register mock
      if (serviceLocator.isRegistered<OwnedProductsBloc>()) {
        serviceLocator.unregister<OwnedProductsBloc>();
      }
      serviceLocator.registerFactory<OwnedProductsBloc>(() => mockBloc);
    });

    tearDown(() {
      if (serviceLocator.isRegistered<OwnedProductsBloc>()) {
        serviceLocator.unregister<OwnedProductsBloc>();
      }
    });

    Widget createTestWidget() {
      return MaterialApp(
        home: const MyOwnedProductsView(),
      );
    }

    Widget createBodyTestWidget(OwnedProductsState initialState) {
      whenListen(
        mockBloc,
        Stream.fromIterable([initialState]),
        initialState: initialState,
      );

      return MaterialApp(
        home: Scaffold(
          body: BlocProvider<OwnedProductsBloc>.value(
            value: mockBloc,
            child: const MyOwnedProductsBody(),
          ),
        ),
      );
    }

    testWidgets('should display app bar with correct title and search icon', (tester) async {
      whenListen(mockBloc, Stream.fromIterable([OwnedProductsInitial()]), initialState: OwnedProductsInitial());
      
      await tester.pumpWidget(createTestWidget());
      
      expect(find.text('My Owned Products'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('should show search coming soon snackbar when search icon tapped', (tester) async {
      whenListen(mockBloc, Stream.fromIterable([OwnedProductsInitial()]), initialState: OwnedProductsInitial());
      
      await tester.pumpWidget(createTestWidget());
      await tester.tap(find.byIcon(Icons.search));
      await tester.pump();
      
      expect(find.text('Search functionality coming soon!'), findsOneWidget);
    });

    testWidgets('should display loading indicator when state is loading', (tester) async {
      await tester.pumpWidget(createBodyTestWidget(OwnedProductsLoading()));
      
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display empty state when no products', (tester) async {
      await tester.pumpWidget(createBodyTestWidget(const OwnedProductsLoaded([])));
      
      expect(find.text('No owned products found'), findsOneWidget);
      expect(find.text('Your purchased items will appear here'), findsOneWidget);
      expect(find.byIcon(Icons.inventory_2_outlined), findsOneWidget);
    });

    testWidgets('should display products when loaded', (tester) async {
      await tester.pumpWidget(createBodyTestWidget(OwnedProductsLoaded([testProduct])));
      
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('Rs. 1000'), findsOneWidget);
      expect(find.text('By: John Doe'), findsOneWidget);
      expect(find.text('Test Collection'), findsOneWidget);
    });

    testWidgets('should display resell button for products not on sale', (tester) async {
      await tester.pumpWidget(createBodyTestWidget(OwnedProductsLoaded([testProduct])));
      
      expect(find.text('Resell'), findsOneWidget);
      expect(find.byIcon(Icons.sell), findsOneWidget);
    });

    testWidgets('should display listed button for products on sale', (tester) async {
      await tester.pumpWidget(createBodyTestWidget(OwnedProductsLoaded([testProductOnSale])));
      
      expect(find.text('Listed'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.text('On Sale'), findsOneWidget);
      expect(find.text('Sale: Rs. 800'), findsOneWidget);
    });

  

    testWidgets('should show error message when error state occurs', (tester) async {
      whenListen(
        mockBloc,
        Stream.fromIterable([
          const OwnedProductsLoaded([]),
          const OwnedProductsError('Test error message'),
        ]),
        initialState: const OwnedProductsLoaded([]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<OwnedProductsBloc>.value(
              value: mockBloc,
              child: const MyOwnedProductsBody(),
            ),
          ),
        ),
      );
      
      await tester.pump(); // Process the error state
      
      expect(find.text('Test error message'), findsOneWidget);
    });

    testWidgets('should show success message when resell succeeds', (tester) async {
      whenListen(
        mockBloc,
        Stream.fromIterable([
          OwnedProductsLoaded([testProduct]),
          const ResellProductSuccess('Product listed successfully'),
        ]),
        initialState: OwnedProductsLoaded([testProduct]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<OwnedProductsBloc>.value(
              value: mockBloc,
              child: const MyOwnedProductsBody(),
            ),
          ),
        ),
      );
      
      await tester.pump(); // Process the success state
      
      expect(find.text('Product listed successfully'), findsOneWidget);
    });

    testWidgets('should show error message when resell fails', (tester) async {
      whenListen(
        mockBloc,
        Stream.fromIterable([
          OwnedProductsLoaded([testProduct]),
          const ResellProductError('Failed to list product'),
        ]),
        initialState: OwnedProductsLoaded([testProduct]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<OwnedProductsBloc>.value(
              value: mockBloc,
              child: const MyOwnedProductsBody(),
            ),
          ),
        ),
      );
      
      await tester.pump(); // Process the error state
      
      expect(find.text('Failed to list product'), findsOneWidget);
    });

    testWidgets('should display resell loading state', (tester) async {
      await tester.pumpWidget(createBodyTestWidget(ResellProductLoading()));
      
      expect(find.text('Processing resell request...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should handle pull to refresh', (tester) async {
      await tester.pumpWidget(createBodyTestWidget(OwnedProductsLoaded([testProduct])));
      
      // Find the RefreshIndicator
      expect(find.byType(RefreshIndicator), findsOneWidget);
      
      // Simulate pull to refresh
      await tester.fling(find.byType(GridView), const Offset(0, 300), 1000);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      
      // Verify refresh indicator appeared
      expect(find.byType(RefreshIndicator), findsOneWidget);
    });

    testWidgets('should display arrow navigation button', (tester) async {
      await tester.pumpWidget(createBodyTestWidget(OwnedProductsLoaded([testProduct])));
      
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('should display product description when available', (tester) async {
      await tester.pumpWidget(createBodyTestWidget(OwnedProductsLoaded([testProduct])));
      
      expect(find.text('Test Description'), findsOneWidget);
    });

    testWidgets('should handle multiple products correctly', (tester) async {
      final products = [testProduct, testProductOnSale];
      await tester.pumpWidget(createBodyTestWidget(OwnedProductsLoaded(products)));
      
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('Product On Sale'), findsOneWidget);
      expect(find.text('Resell'), findsOneWidget);
      expect(find.text('Listed'), findsOneWidget);
    });

    testWidgets('should show grid layout with correct aspect ratio', (tester) async {
      await tester.pumpWidget(createBodyTestWidget(OwnedProductsLoaded([testProduct])));
      
      expect(find.byType(GridView), findsOneWidget);
      
      final gridView = tester.widget<GridView>(find.byType(GridView));
      final delegate = gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      
      expect(delegate.crossAxisCount, 2);
      expect(delegate.childAspectRatio, 0.50);
      expect(delegate.crossAxisSpacing, 12);
      expect(delegate.mainAxisSpacing, 12);
    });

    testWidgets('should display all product information correctly', (tester) async {
      await tester.pumpWidget(createBodyTestWidget(OwnedProductsLoaded([testProduct])));
      
      // Check all text elements are displayed
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
      expect(find.text('Test Collection'), findsOneWidget);
      expect(find.text('Rs. 1000'), findsOneWidget);
      expect(find.text('By: John Doe'), findsOneWidget);
      expect(find.text('Resell'), findsOneWidget);
    });

    testWidgets('should handle empty description correctly', (tester) async {
      final productNoDescription = OwnedProductEntity(
        id: '1',
        name: 'Test Product',
        description: null, // No description
        image: 'test.jpg',
        originalPrice: 1000,
        resalePrice: null,
        onSale: false,
        certified: true,
        creator: testCreator,
        collection: testCollection,
        pendingTransfer: testPendingTransfer,
        owner: '1',
        soldHistory: [],
        createdAt: '2024-01-01',
        updatedAt: '2024-01-01',
      );
      
      await tester.pumpWidget(createBodyTestWidget(OwnedProductsLoaded([productNoDescription])));
      
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('Rs. 1000'), findsOneWidget);
      // Description should not be displayed
      expect(find.text('Test Description'), findsNothing);
    });

  });
}