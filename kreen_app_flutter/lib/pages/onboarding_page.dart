import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'home_page.dart';
import '/services/lang_service.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  List<Map<String, dynamic>> pages = [];
  String dialog_title = "";
  String lewati = "";
  String lanjut = "";
  String selesai = "";
  String login = "";
  String guest = "";


  @override
  void initState() {
    super.initState();
    _loadLanguage("id"); // default bahasa indo
  }


  //setting bahasa
  Future<void> _loadLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('bahasa', 'id');
    
    final data = await LangService.loadOnboarding(langCode);
    setState(() {
      pages = data;
    });

    final data_dialog = await LangService.loadDialogTitle(langCode);
    setState(() {
      dialog_title = data_dialog;
    });


    final data_lewati = await LangService.loadlewati(langCode);
    setState(() {
      lewati = data_lewati;
    });
    final data_lanjut = await LangService.loadlanjut(langCode);
    setState(() {
      lanjut = data_lanjut;
    });
    final data_selesai = await LangService.loadselesai(langCode);
    setState(() {
      selesai = data_selesai;
    });

    final data_login = await LangService.loadlogin(langCode);
    setState(() {
      login = data_login;
    });
    final data_guest = await LangService.loadguest(langCode);
    setState(() {
      guest = data_guest;
    });
  }

  String _selectedLang = "id";
  final Map<String, String> languages = {
    "id": "Indonesia",
    "en": "English"
  };

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String tempLang = _selectedLang; // buat sementara
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(dialog_title),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: languages.entries.map((entry) {
                    return RadioListTile<String>(
                      value: entry.key,
                      groupValue: tempLang,
                      onChanged: (val) async {
                        if (val != null) {
                          final prefs = await SharedPreferences.getInstance();
                          setState(() {
                            _selectedLang = val; // update global
                          });
                          setStateDialog(() {
                            tempLang = val; // update local
                          });
                          _loadLanguage(val);
                          prefs.setString('bahasa', val);
                          Navigator.pop(context); // langsung tutup popup
                          // TODO: ganti bahasa aplikasi disini
                        }
                      },
                      title: Row(
                        children: [
                          Image.asset(
                            "assets/flags/${entry.key}.png", // simpan bendera di folder assets/flags
                            width: 28,
                            height: 28,
                          ),
                          const SizedBox(width: 12),
                          Text(entry.value),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  void _nextPage() {
    if (_currentPage == pages.length - 1) {
      _finishOnboarding();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _setOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
  }

  void _goToLogin() async {
    await _setOnboardingDone();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  void _goToHome() async {
    await _setOnboardingDone();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: Stack(
        children: [

          //konten page
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: pages.length,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            pages[index]["image"]!,
                            height: 250,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 32),
                          Text(
                            pages[index]["title"]!,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            pages[index]["desc"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, color: Colors.grey),
                          ),

                          const Spacer(),
                          if (index == pages.length - 1) ...[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor: Colors.red,
                              ),
                              onPressed: _goToLogin,
                              child: Text(
                                login,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: _goToHome,
                              child: Text(
                                guest,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                )
              ),

              // Bottom controls
              // Navigation bar bawah (hanya tampil kalau bukan halaman terakhir)
              if (_currentPage != pages.length - 1)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Lewati
                      TextButton(
                        onPressed: _finishOnboarding,
                        child: Text(
                          lewati,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),

                      // Indicator
                      Row(
                        children: List.generate(
                          pages.length,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? Colors.red
                                  : Colors.grey.shade400,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),

                      // Lanjut
                      TextButton(
                        onPressed: _nextPage,
                        child: Text(
                          _currentPage == pages.length - 1 ? selesai : lanjut,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

            ],
          ),

          
          //bahasa
          Positioned(
            top: 16,
            right: 20,
            child: GestureDetector(
              onTap: _showLanguageDialog,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                Image.asset("assets/flags/$_selectedLang.png",
                    width: 24, height: 24),
                const SizedBox(width: 4),
                Text(
                  _selectedLang.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
