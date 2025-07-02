import 'package:flutter/material.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/views/home_page.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/views/people_page.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/views/tasks_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Icon(Icons.menu, color: Colors.white,),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text("Timesheet App",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ),
            ],
          ),
          elevation: 4,
          backgroundColor: Colors.blue,
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.white24, width: 1),
            ),
          ),
          child: TabBar(
            indicator: BoxDecoration(
              color: Colors.blue.shade200,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            controller: _tabController,
            onTap: _onTabTapped,
            tabs: const [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.person), text: 'People'),
              Tab(icon: Icon(Icons.task_rounded), text: 'Tasks'),
            ],
          ),
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _tabs,
        ),
      ),
    );
  }

  final List<Widget> _tabs = [
    const HomePage(),
    const PeoplePage(),
    const TasksPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.index = index;
    });
  }
}

