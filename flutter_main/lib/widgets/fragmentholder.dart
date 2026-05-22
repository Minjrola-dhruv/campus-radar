import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/placement.dart';
import 'home_screen.dart';
import 'add_screen.dart';
import 'edit_screen.dart';
class FragmentHolder extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String? filterCity;
  final String? filterDate;
  final Function(String, {Object? arguments})? onNavigate;
  const FragmentHolder({
    super.key,
    required this.navigatorKey,
    this.filterCity,
    this.filterDate,
    this.onNavigate,
  });
  @override
  State<FragmentHolder> createState() => _FragmentHolderState();
}
// // Global data list so it acts as an in-memory database without needing shared_preferences
// List<Map<String, String>> globalPlacementsData = [
//   {"id": "1", "role": "Software Engineer",  "company": "Google",    "city": "Bangalore", "date": "May 24", "package": "30 LPA"},
//   {"id": "2", "role": "Backend Developer",  "company": "Microsoft", "city": "Hyderabad", "date": "May 29", "package": "28 LPA"},
//   {"id": "3", "role": "Full Stack Engineer","company": "Amazon",    "city": "Pune",      "date": "Jun 03", "package": "25 LPA"},
//   {"id": "4", "role": "SDE-1",              "company": "Flipkart",  "city": "Bangalore", "date": "Jun 08", "package": "22 LPA"},
//   {"id": "5", "role": "Software Engineer",  "company": "Cognizant", "city": "Delhi",     "date": "May 23", "package": "15 LPA"},
// ];
class _FragmentHolderState extends State<FragmentHolder> {
  bool isLoading = true;
  List<Placement> globalPlacementsData = [];
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _loadData();
    // Poll for changes to sync across multiple tabs/instances
    _refreshTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      _loadData(isRefresh: true);
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }
  Future<void> _loadData({bool isRefresh = false}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload(); // Force reload to get updates from other tabs
    
    final String? dataString = prefs.getString('placements_data');
    if (dataString != null) {
      try {
        final List<dynamic> jsonList = jsonDecode(dataString);
        final parsedData = jsonList.map((json) => Placement.fromJson(json)).toList();
        
        // Only rebuild if data actually changed to avoid UI flickering
        if (jsonEncode(parsedData.map((e) => e.toJson()).toList()) != 
            jsonEncode(globalPlacementsData.map((e) => e.toJson()).toList())) {
          setState(() {
            globalPlacementsData = parsedData;
            isLoading = false;
          });
        } else if (!isRefresh && isLoading) {
          setState(() { isLoading = false; });
        }
      } catch (e) {
        // Fallback to empty if error
        if (globalPlacementsData.isNotEmpty || isLoading) {
          setState(() {
            globalPlacementsData = [];
            isLoading = false;
          });
        }
      }
    } else {
      // Default dummy data if nothing is saved
      if (globalPlacementsData.isNotEmpty || isLoading) {
        setState(() {
          globalPlacementsData = [];
          isLoading = false;
        });
      }
    }
  }
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final String dataString = jsonEncode(globalPlacementsData.map((e) => e.toJson()).toList());
    await prefs.setString('placements_data', dataString);
  }
  Future<void> _addPlacement(Placement placement) async {
    setState(() {
      final newPlacement = placement.copyWith(id: DateTime.now().millisecondsSinceEpoch.toString());
      globalPlacementsData.add(newPlacement);
    });
    await _saveData();
  }
  Future<void> _editPlacement(Placement updatedPlacement) async {
    setState(() {
      int index = globalPlacementsData.indexWhere((item) => item.id == updatedPlacement.id);
      if (index != -1) {
        globalPlacementsData[index] = updatedPlacement;
      }
    });
    await _saveData();
  }
  Future<void> _deletePlacement(String id) async {
    setState(() {
      globalPlacementsData.removeWhere((item) => item.id == id);
    });
    await _saveData();
  }
  List<Placement> get filteredData {
    return globalPlacementsData.where((item) {
      bool matchesCity = widget.filterCity == null || 
                         widget.filterCity!.trim().isEmpty || 
                         item.city.toLowerCase().contains(widget.filterCity!.trim().toLowerCase());
      
      bool matchesDate = widget.filterDate == null || 
                         widget.filterDate!.isEmpty || 
                         item.date == widget.filterDate;
                         
      return matchesCity && matchesDate;
    }).toList();
  }
  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case '/':
        builder = (context) => isLoading 
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : PlacementListWidget(
              data: filteredData, 
              onDelete: _deletePlacement,
              onEdit: (item) {
                if (widget.onNavigate != null) {
                  widget.onNavigate!('/edit', arguments: item);
                } else {
                  widget.navigatorKey.currentState!.pushNamed('/edit', arguments: item);
                }
              },
            );
        break;
      case '/add':
        builder = (context) => AddScreen(
              onAdd: _addPlacement,
              onSuccess: () => widget.navigatorKey.currentState!.pop(),
            );
        break;
      case '/edit':
        final item = settings.arguments as Placement;
        builder = (context) => EditScreen(
              placement: item,
              onEdit: _editPlacement,
              onSuccess: () => widget.navigatorKey.currentState!.pop(),
            );
        break;
      default:
        builder = (context) => const Scaffold(
              body: Center(child: Text('Route not found')),
            );
    }
    // Animated transition between the screens
    return MaterialPageRoute(builder: builder, settings: settings);
  }
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      initialRoute: '/',
      onGenerateRoute: _onGenerateRoute,
    );
  }
}