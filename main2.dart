import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(DocsToSheetsApp());
}

class DocsToSheetsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DocsToSheets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/profile': (context) => ProfileScreen(),
        '/microsoft': (context) => MicrosoftToolsScreen(),
        '/google': (context) => GoogleToolsScreen(),
        '/shortcuts': (context) => ShortcutsScreen(),
        '/progress': (context) => ProgressScreen(),
      },
    );
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Icon(
                Icons.school,
                size: 60,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'DocsToSheets',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Master Office & Google Tools',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 50),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

// Home Screen
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<Widget> _screens = [
    HomeTab(),
    CoursesTab(),
    ShortcutsTab(),
    ProgressTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DocsToSheets'),
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.keyboard), label: 'Shortcuts'),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: 'Progress'),
        ],
      ),
    );
  }
}

// Home Tab
class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search tutorials, shortcuts...',
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.grey[600]),
              ),
            ),
          ),
          SizedBox(height: 30),

          // Welcome Section
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[400]!, Colors.blue[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to DocsToSheets!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Master Microsoft Office and Google tools with our step-by-step tutorials',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),

          // Popular Tools Section
          Text(
            'Popular Tools',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 15),
          
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: [
              _buildToolCard(
                context,
                'Microsoft Word',
                Icons.description,
                Colors.blue[600]!,
                () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TutorialScreen(tool: 'Microsoft Word'),
                )),
              ),
              _buildToolCard(
                context,
                'Excel',
                Icons.table_chart,
                Colors.green[600]!,
                () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TutorialScreen(tool: 'Microsoft Excel'),
                )),
              ),
              _buildToolCard(
                context,
                'Google Forms',
                Icons.quiz,
                Colors.purple[600]!,
                () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TutorialScreen(tool: 'Google Forms'),
                )),
              ),
              _buildToolCard(
                context,
                'Teams',
                Icons.video_call,
                Colors.indigo[600]!,
                () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TutorialScreen(tool: 'Microsoft Teams'),
                )),
              ),
            ],
          ),
          SizedBox(height: 30),

          // Recent Progress
          Text(
            'Continue Learning',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 15),
          
          _buildProgressCard('Word Formatting', 0.7, Colors.blue),
          SizedBox(height: 10),
          _buildProgressCard('Excel Formulas', 0.4, Colors.green),
          SizedBox(height: 10),
          _buildProgressCard('PowerPoint Design', 0.2, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildToolCard(BuildContext context, String title, IconData icon, 
                       Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 30, color: color),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(String title, double progress, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
          SizedBox(height: 5),
          Text(
            '${(progress * 100).toInt()}% complete',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

// Courses Tab
class CoursesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Learning Paths',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 20),

          // Microsoft Tools Section
          _buildCourseSection(
            context,
            'Microsoft Office Suite',
            Colors.blue,
            [
              {'name': 'Microsoft Word', 'lessons': '25 lessons', 'icon': Icons.description},
              {'name': 'Microsoft Excel', 'lessons': '30 lessons', 'icon': Icons.table_chart},
              {'name': 'Microsoft PowerPoint', 'lessons': '20 lessons', 'icon': Icons.slideshow},
              {'name': 'Microsoft Teams', 'lessons': '15 lessons', 'icon': Icons.video_call},
              {'name': 'Microsoft OneNote', 'lessons': '12 lessons', 'icon': Icons.note},
              {'name': 'PowerBI', 'lessons': '18 lessons', 'icon': Icons.bar_chart},
            ],
          ),
          SizedBox(height: 30),

          // Google Tools Section
          _buildCourseSection(
            context,
            'Google Productivity Tools',
            Colors.green,
            [
              {'name': 'Google Forms', 'lessons': '15 lessons', 'icon': Icons.quiz},
              {'name': 'Firebase', 'lessons': '22 lessons', 'icon': Icons.cloud},
              {'name': 'Chrome DevTools', 'lessons': '18 lessons', 'icon': Icons.developer_mode},
              {'name': 'Android Studio', 'lessons': '25 lessons', 'icon': Icons.android},
              {'name': 'Google Colab', 'lessons': '12 lessons', 'icon': Icons.code},
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCourseSection(BuildContext context, String title, Color color, List<Map<String, dynamic>> courses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color[700],
            ),
          ),
        ),
        SizedBox(height: 15),
        ...courses.map((course) => _buildCourseCard(
          context,
          course['name'],
          course['lessons'],
          course['icon'],
          color,
        )).toList(),
      ],
    );
  }

  Widget _buildCourseCard(BuildContext context, String name, String lessons, 
                         IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color[600]),
        ),
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(lessons),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) => TutorialScreen(tool: name),
        )),
      ),
    );
  }
}

// Shortcuts Tab
class ShortcutsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Keyboard Shortcuts',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 20),

          _buildShortcutSection('Microsoft Word', [
            {'shortcut': 'Ctrl + B', 'action': 'Bold text'},
            {'shortcut': 'Ctrl + I', 'action': 'Italic text'},
            {'shortcut': 'Ctrl + U', 'action': 'Underline text'},
            {'shortcut': 'Ctrl + Z', 'action': 'Undo'},
            {'shortcut': 'Ctrl + Y', 'action': 'Redo'},
            {'shortcut': 'Ctrl + F', 'action': 'Find'},
          ]),

          _buildShortcutSection('Microsoft Excel', [
            {'shortcut': 'Ctrl + C', 'action': 'Copy'},
            {'shortcut': 'Ctrl + V', 'action': 'Paste'},
            {'shortcut': 'F2', 'action': 'Edit cell'},
            {'shortcut': 'Ctrl + Shift + +', 'action': 'Insert row/column'},
            {'shortcut': 'Ctrl + -', 'action': 'Delete row/column'},
            {'shortcut': 'Ctrl + A', 'action': 'Select all'},
          ]),

          _buildShortcutSection('Google Chrome', [
            {'shortcut': 'Ctrl + T', 'action': 'New tab'},
            {'shortcut': 'Ctrl + W', 'action': 'Close tab'},
            {'shortcut': 'Ctrl + Shift + T', 'action': 'Reopen closed tab'},
            {'shortcut': 'F12', 'action': 'Developer tools'},
            {'shortcut': 'Ctrl + Shift + I', 'action': 'Inspect element'},
          ]),
        ],
      ),
    );
  }

  Widget _buildShortcutSection(String title, List<Map<String, String>> shortcuts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue[700],
          ),
        ),
        SizedBox(height: 10),
        ...shortcuts.map((shortcut) => _buildShortcutCard(
          shortcut['shortcut']!,
          shortcut['action']!,
        )).toList(),
        SizedBox(height: 25),
      ],
    );
  }

  Widget _buildShortcutCard(String shortcut, String action) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              shortcut,
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              action,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.copy, size: 20, color: Colors.grey[500]),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: shortcut));
            },
          ),
        ],
      ),
    );
  }
}

// Progress Tab
class ProgressTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Progress',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 20),

          // Overall Progress Card
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple[400]!, Colors.purple[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overall Progress',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '12 / 25 Courses',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          SizedBox(height: 5),
                          LinearProgressIndicator(
                            value: 0.48,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      '48%',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30),

          // Individual Course Progress
          Text(
            'Course Progress',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 15),

          _buildCourseProgress('Microsoft Word', 0.75, 15, 20, Colors.blue),
          _buildCourseProgress('Microsoft Excel', 0.60, 18, 30, Colors.green),
          _buildCourseProgress('Google Forms', 0.40, 6, 15, Colors.purple),
          _buildCourseProgress('PowerBI', 0.25, 4, 18, Colors.orange),
          _buildCourseProgress('Firebase', 0.10, 2, 22, Colors.red),

          SizedBox(height: 30),

          // Achievements
          Text(
            'Achievements',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 15),

          Row(
            children: [
              _buildAchievementBadge('First Course', Icons.school, Colors.blue),
              SizedBox(width: 10),
              _buildAchievementBadge('Word Master', Icons.description, Colors.green),
              SizedBox(width: 10),
              _buildAchievementBadge('Shortcut Pro', Icons.keyboard, Colors.purple),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCourseProgress(String courseName, double progress, 
                             int completed, int total, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                courseName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              Text(
                '$completed/$total',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
          SizedBox(height: 5),
          Text(
            '${(progress * 100).toInt()}% complete',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementBadge(String title, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Tutorial Screen
class TutorialScreen extends StatelessWidget {
  final String tool;

  TutorialScreen({required this.tool});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tool),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[400]!, Colors.blue[600]!],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getToolIcon(tool),
                    size: 60,
                    color: Colors.white,
                  ),
                  SizedBox(height: 15),
                  Text(
                    tool,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Master ${tool} with step-by-step tutorials',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            Text(
              'Lessons',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 15),

            ..._getTutorialLessons(tool).map((lesson) => _buildLessonCard(
              context,
              lesson['title']!,
              lesson['duration']!,
              lesson['difficulty']!,
            )).toList(),
          ],
        ),
      ),
    );
  }

  IconData _getToolIcon(String tool) {
    switch (tool.toLowerCase()) {
      case 'microsoft word':
        return Icons.description;
      case 'microsoft excel':
        return Icons.table_chart;
      case 'google forms':
        return Icons.quiz;
      case 'microsoft teams':
        return Icons.video_call;
      default:
        return Icons.school;
    }
  }

  List<Map<String, String>> _getTutorialLessons(String tool) {
    switch (tool.toLowerCase()) {
      case 'microsoft word':
        return [
          {'title': 'Getting Started with Word', 'duration': '10 min', 'difficulty': 'Beginner'},
          {'title': 'Text Formatting Basics', 'duration': '15 min', 'difficulty': 'Beginner'},
          {'title': 'Working with Paragraphs', 'duration': '12 min', 'difficulty': 'Beginner'},
          {'title': 'Headers and Footers', 'duration': '18 min', 'difficulty': 'Intermediate'},
          {'title': 'Tables and Lists', 'duration': '20 min', 'difficulty': 'Intermediate'},
        ];
      case 'microsoft excel':
        return [
          {'title': 'Excel Interface Overview', 'duration': '12 min', 'difficulty': 'Beginner'},
          {'title': 'Basic Formulas', 'duration': '25 min', 'difficulty': 'Beginner'},
          {'title': 'Working with Charts', 'duration': '30 min', 'difficulty': 'Intermediate'},
          {'title': 'Pivot Tables', 'duration': '45 min', 'difficulty': 'Advanced'},
          {'title': 'Data Analysis Tools', 'duration': '35 min', 'difficulty': 'Advanced'},
        ];
      default:
        return [
          {'title': 'Introduction to ${tool}', 'duration': '15 min', 'difficulty': 'Beginner'},
          {'title': 'Basic Features', 'duration': '20 min', 'difficulty': 'Beginner'},
          {'title': 'Advanced Techniques', 'duration': '30 min', 'difficulty': 'Intermediate'},
        ];
    }
  }

  Widget _buildLessonCard(BuildContext context, String title, String duration, String difficulty) {
    Color difficultyColor = difficulty == 'Beginner' 
        ? Colors.green 
        : difficulty == 'Intermediate' 
            ? Colors.orange 
            : Colors.red;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.play_arrow, color: Colors.blue),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Row(
          children: [
            Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
            SizedBox(width: 5),
            Text(duration),
            SizedBox(width: 15),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: difficultyColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                difficulty,
                style: TextStyle(
                  fontSize: 12,
                  color: difficultyColor[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) => LessonDetailScreen(
            lessonTitle: title,
            toolName: tool,
          ),
        )),
      ),
    );
  }
}

// Lesson Detail Screen
class LessonDetailScreen extends StatelessWidget {
  final String lessonTitle;
  final String toolName;

  LessonDetailScreen({required this.lessonTitle, required this.toolName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lessonTitle),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video Placeholder
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_circle_outline, size: 60, color: Colors.grey[600]),
                  SizedBox(height: 10),
                  Text(
                    'Video Tutorial',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),

            // Lesson Content
            Text(
              'What You\'ll Learn',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 15),

            _buildLearningPoint('Understanding the basic interface'),
            _buildLearningPoint('Key features and tools'),
            _buildLearningPoint('Best practices and tips'),
            _buildLearningPoint('Hands-on exercises'),

            SizedBox(height: 30),

            Text(
              'Step-by-Step Guide',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 15),

            _buildStep(1, 'Open ${toolName} from your desktop or start menu'),
            _buildStep(2, 'Familiarize yourself with the ribbon interface'),
            _buildStep(3, 'Create a new document or project'),
            _buildStep(4, 'Practice with the basic tools and features'),
            _buildStep(5, 'Save your work in the appropriate format'),

            SizedBox(height: 30),

            // Practice Exercise
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.yellow[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.yellow[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.assignment, color: Colors.orange[700]),
                      SizedBox(width: 10),
                      Text(
                        'Practice Exercise',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[700],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Try creating a simple document using the techniques learned in this lesson. Experiment with different features and don\'t hesitate to explore!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.check),
                    label: Text('Mark Complete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.bookmark),
                    label: Text('Save for Later'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLearningPoint(String point) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              point,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(int stepNumber, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                stepNumber.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Login Screen
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Sign In'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50),
              
              // Logo and Title
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.school,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Continue your learning journey',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),

              SizedBox(height: 15),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text('Forgot Password?'),
                ),
              ),

              SizedBox(height: 30),

              // Sign In Button
              ElevatedButton(
                onPressed: _isLoading ? null : _signIn,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Sign In',
                        style: TextStyle(fontSize: 18),
                      ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account? '),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Simulate login delay
      await Future.delayed(Duration(seconds: 2));
      
      setState(() => _isLoading = false);
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

// Register Screen
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Create Account'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30),
              
              // Logo and Title
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.school,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Join DocsToSheets',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Start your learning journey today',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40),

              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              // Confirm Password Field
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),

              SizedBox(height: 30),

              // Sign Up Button
              ElevatedButton(
                onPressed: _isLoading ? null : _signUp,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Create Account',
                        style: TextStyle(fontSize: 18),
                      ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Sign In Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? '),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    child: Text('Sign In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Simulate registration delay
      await Future.delayed(Duration(seconds: 2));
      
      setState(() => _isLoading = false);
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

// Profile Screen
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[400]!, Colors.blue[600]!],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.blue[600],
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'john.doe@email.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Profile Options
            _buildProfileOption(
              Icons.edit,
              'Edit Profile',
              'Update your personal information',
              () {},
            ),
            _buildProfileOption(
              Icons.notifications,
              'Notifications',
              'Manage your notification preferences',
              () {},
            ),
            _buildProfileOption(
              Icons.download,
              'Download Certificates',
              'Download your completed course certificates',
              () {},
            ),
            _buildProfileOption(
              Icons.help,
              'Help & Support',
              'Get help with the app',
              () {},
            ),
            _buildProfileOption(
              Icons.info,
              'About',
              'Learn more about DocsToSheets',
              () {},
            ),
            _buildProfileOption(
              Icons.logout,
              'Sign Out',
              'Sign out of your account',
              () => Navigator.pushReplacementNamed(context, '/login'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue[600]),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

// Additional Screens (Microsoft Tools, Google Tools, etc.)
class MicrosoftToolsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Microsoft Tools'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            _buildToolCard(context, 'Word', Icons.description, Colors.blue[600]!),
            _buildToolCard(context, 'Excel', Icons.table_chart, Colors.green[600]!),
            _buildToolCard(context, 'PowerPoint', Icons.slideshow, Colors.orange[600]!),
            _buildToolCard(context, 'Teams', Icons.video_call, Colors.indigo[600]!),
            _buildToolCard(context, 'OneNote', Icons.note, Colors.purple[600]!),
            _buildToolCard(context, 'PowerBI', Icons.bar_chart, Colors.red[600]!),
          ],
        ),
      ),
    );
  }

  Widget _buildToolCard(BuildContext context, String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (context) => TutorialScreen(tool: 'Microsoft $title'),
      )),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoogleToolsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Tools'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            _buildToolCard(context, 'Forms', Icons.quiz, Colors.purple[600]!),
            _buildToolCard(context, 'Firebase', Icons.cloud, Colors.orange[600]!),
            _buildToolCard(context, 'DevTools', Icons.developer_mode, Colors.blue[600]!),
            _buildToolCard(context, 'Android Studio', Icons.android, Colors.green[600]!),
            _buildToolCard(context, 'Colab', Icons.code, Colors.red[600]!),
          ],
        ),
      ),
    );
  }

  Widget _buildToolCard(BuildContext context, String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (context) => TutorialScreen(tool: 'Google $title'),
      )),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShortcutsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShortcutsTab();
  }
}

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProgressTab();
  }
}
