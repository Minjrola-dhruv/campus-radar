import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'add_screen.dart';

class FragmentHolder extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String? filterCity;
  final String? filterDate;

  const FragmentHolder({
    super.key,
    required this.navigatorKey,
    this.filterCity,
    this.filterDate,
  });

  @override
  State<FragmentHolder> createState() => _FragmentHolderState();
}

class _FragmentHolderState extends State<FragmentHolder> {
  List<Map<String, String>> data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDefaultData();
  }

  void _loadDefaultData() {
    setState(() {
      data = [
        {"id": "1", "role": "Software Engineer",  "company": "Google",    "city": "Bangalore", "date": "May 24", "package": "30 LPA"},
        {"id": "2", "role": "Backend Developer",  "company": "Microsoft", "city": "Hyderabad", "date": "May 29", "package": "28 LPA"},
        {"id": "3", "role": "Full Stack Engineer","company": "Amazon",    "city": "Pune",      "date": "Jun 03", "package": "25 LPA"},
        {"id": "4", "role": "SDE-1",              "company": "Flipkart",  "city": "Bangalore", "date": "Jun 08", "package": "22 LPA"},
        {"id": "5", "role": "Software Engineer",  "company": "Cognizant", "city": "Delhi",     "date": "May 23", "package": "15 LPA"},
      ];
      isLoading = false;
    });
  }
  void _addPlacement(Map<String, String> placement) {
    setState(() {
      placement['id'] = DateTime.now().millisecondsSinceEpoch.toString();
      data.add(placement);
    });
  }

  void _deletePlacement(String id) {
    setState(() {
      data.removeWhere((item) => item['id'] == id);
    });
  }

  List<Map<String, String>> get filteredData {
    return data.where((item) {
      bool matchesCity = widget.filterCity == null || 
                         widget.filterCity!.trim().isEmpty || 
                         item['city']!.toLowerCase().contains(widget.filterCity!.trim().toLowerCase());
      
      bool matchesDate = widget.filterDate == null || 
                         widget.filterDate!.isEmpty || 
                         item['date'] == widget.filterDate;
                         
      return matchesCity && matchesDate;
    }).toList();
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    WidgetBuilder builder;

    switch (settings.name) {
      case '/':
        builder = (context) => isLoading 
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : PlacementListWidget(data: filteredData, onDelete: _deletePlacement);
        break;
      case '/add':
        builder = (context) => AddScreen(
              onAdd: _addPlacement,
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