import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '/services/lang_service.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  String dialog_title = "";
  String input_email = "";
  String input_password = "";
  String lupa_password = "";
  String login = "";
  String login_as = "";
  String belum = "";
  String daftar = "";

  bool get _isFormFilled =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  OutlineInputBorder _border(bool isFilled) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: isFilled ? Colors.orange : Colors.grey.shade400,
        width: 1.5,
      ),
    );
  }

  Future<void> _loadPrefBahasa() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString('bahasa'); // null kalau belum ada

    if (savedLang != null) {
      setState(() {
        _selectedLang = savedLang; // isi ulang ke variabel global
      });
      _loadLanguage(savedLang); // misalnya untuk load file bahasa
    }
  }


  void _doLogin() async {
    // loading
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      body: Column(
        children: const [
          CircularProgressIndicator(color: Colors.red),
          SizedBox(height: 16),
          Text("Loading..."),
        ],
      ),
    ).show();

    await Future.delayed(const Duration(seconds: 2)); // simulasi proses login

    if (!mounted) return;

    Navigator.pop(context); // tutup dialog loading

    // Cek login dummy
    if (_emailController.text == "admin" &&
        _passwordController.text == "1234") {
      // Berhasil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      // Gagal
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: 'Gagal',
        desc: 'Username atau password salah!',
        btnOkOnPress: () {},
      ).show();
    }
  }

  //setting bahasa
  Future<void> _loadLanguage(String langCode) async {

    final data_dialog = await LangService.loadDialogTitle(langCode);
    setState(() {
      dialog_title = data_dialog;
    });

    final data_email = await LangService.input_email(langCode);
    setState(() {
      input_email = data_email;
    });

    final data_pass = await LangService.input_password(langCode);
    setState(() {
      input_password = data_pass;
    });

    final data_pass_lupa = await LangService.lupa_password(langCode);
    setState(() {
      lupa_password = data_pass_lupa;
    });

    final data_login = await LangService.loadlogin(langCode);
    setState(() {
      login = data_login;
    });

    final data_login_as = await LangService.loadlogin_as(langCode);
    setState(() {
      login_as = data_login_as;
    });

    final data_belum = await LangService.belum(langCode);
    setState(() {
      belum = data_belum;
    });

    final data_daftar = await LangService.daftar(langCode);
    setState(() {
      daftar = data_daftar;
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
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _selectedLang = val; // update global
                          });
                          setStateDialog(() {
                            tempLang = val; // update local
                          });
                          _loadLanguage(val);
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

  @override
  void initState() {
    super.initState();
    _loadPrefBahasa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),

      body: Stack(
        children: [
          //konten page
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  //logo
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      Image.asset(
                        "assets/images/img_homekreen.png",
                        width: 200,   // atur sesuai kebutuhan
                        height: 200,
                        fit: BoxFit.contain, // biar proporsional tanpa crop
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),

                  //email
                  const SizedBox(height: 40),
                  TextField(
                    controller: _emailController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: input_email,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      enabledBorder: _border(_emailController.text.isNotEmpty),
                      focusedBorder: _border(true),
                    ),
                  ),

                  //password
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    onChanged: (_) => setState(() {}),
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: input_password,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      enabledBorder: _border(_emailController.text.isNotEmpty),
                      focusedBorder: _border(true),
                      suffixIcon: IconButton(
                        icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                    ),
                  ),

                  // lupa Password
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        lupa_password,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),

                  // tombol Login
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isFormFilled
                        ? Colors.red
                        : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _isFormFilled ? _doLogin : null,
                      child: Text(
                        login,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),

                  // masuk dengan
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(login_as),
                      ),
                      Expanded(child: Divider(thickness: 1)),
                    ],
                  ),

                  // tombol google dan fb
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset("assets/images/img_facebook.png"),
                        iconSize: 50,
                      ),
                      const SizedBox(width: 24),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset("assets/images/img_google.png"),
                        iconSize: 50,
                      ),
                    ],
                  ),

                  // regis
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(belum),
                      GestureDetector(
                        onTap: () {
                          // navigasi ke register
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const RegisPage()),
                          );
                        },
                        child: Text(
                          daftar,
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
      )
    );
  }
}