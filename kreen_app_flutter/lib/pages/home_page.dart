import 'package:flutter/material.dart';
import 'package:kreen_app_flutter/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '/services/lang_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),

      // --- Floating Action Button (scan) ---
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          // Aksi untuk scan
        },
        child: const Icon(Icons.qr_code_scanner, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // --- Bottom Navigation Bar ---
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Home
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.home, color: Colors.red),
                      Text("Home", style: TextStyle(fontSize: 12, color: Colors.red)),
                    ],
                  ),
                ),
              ),

              // Eksplore
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.search, color: Colors.grey),
                      Text("Eksplore", style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 40), // space untuk tombol scan

              // Pesanan
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.receipt_long, color: Colors.grey),
                      Text("Pesanan", style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ),

              // Info
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.person, color: Colors.grey),
                      Text("Info", style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // konten page
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              //top logo dan button
              Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget> [
                            //logo
                            Container(
                              child: Image.asset(
                                      "assets/images/avata_logo.png",
                                      width: 40,   // atur sesuai kebutuhan
                                      height: 40,
                                      fit: BoxFit.contain, // biar proporsional tanpa crop
                                    ),
                            ),

                            //button
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 220),
                                child: IntrinsicWidth(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      backgroundColor: const Color(0xFFFFDFE0),
                                    ),
                                    onPressed: () async {
                                      await Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (_) => const LoginPage()),
                                      );
                                    },
                                    child: const Text(
                                      "Masuk",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                )

                              )
                            )
                          ],
                        ),

                        //text selamat datang
                        const SizedBox(height: 40),
                        Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Selamat datang di Kreen",
                              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),

              // === Image Slider ===
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.red,
                      Colors.white
                    ],
                    stops: [0.5, 0.5],
                  )
                ),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 150,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    aspectRatio: 16 / 9,
                    autoPlayInterval: const Duration(seconds: 4),
                  ),
                  items: [
                    "assets/images/img_banner3.png",
                    "assets/images/img_banner1.png",
                    "assets/images/img_banner2.png",
                  ].map((bannerPath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            bannerPath,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              

              //icon
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: [
                                Container(
                                  child: Image.asset(
                                      "assets/images/vote.png",
                                      width: 55,   // atur sesuai kebutuhan
                                      height: 55,
                                      fit: BoxFit.contain, // biar proporsional tanpa crop
                                    ),
                                ),
                                Container(
                                  child: Text("Vote",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              ],
                            ),

                            Column(
                              children: [
                                Container(
                                  child: Image.asset(
                                      "assets/images/event.png",
                                      width: 55,   // atur sesuai kebutuhan
                                      height: 55,
                                      fit: BoxFit.contain, // biar proporsional tanpa crop
                                    ),
                                ),
                                Container(
                                  child: Text("Event",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              ],
                            ),

                            Column(
                              children: [
                                Container(
                                  child: Image.asset(
                                      "assets/images/charity.png",
                                      width: 55,   // atur sesuai kebutuhan
                                      height: 55,
                                      fit: BoxFit.contain, // biar proporsional tanpa crop
                                    ),
                                ),
                                Container(
                                  child: Text("Charity",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              //event & vote mendatang
              const SizedBox(height: 20),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/img_event.png",
                            width: 30,   // atur sesuai kebutuhan
                            height: 30,
                            fit: BoxFit.contain,
                          ),

                          const SizedBox(width: 12),
                          //text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Event & Vote Populer",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Vote sekarang, amankan tiketmu, dan jadi bagian dari keseruannya!",
                                  style: TextStyle(color: Colors.black),
                                  softWrap: true,          // biar teks bisa kebungkus
                                  overflow: TextOverflow.visible, 
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      //image
                      Container(
                        child: Row(
                          children: [
                            Card(
                              color: Colors.white,
                              elevation: 1, // bikin shadow
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                width: 160, // lebar card (atur sesuai kebutuhan)
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // gambar + label "Voting"
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.asset(
                                            "assets/images/image_140.png",
                                            height: 150,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          left: 8,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: const Text(
                                              "Voting",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 8),
                                    const Text(
                                      "Voting Finalis Miss Indonesia",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),

                                    const SizedBox(height: 4),
                                    Text(
                                      "29 Februari",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),

                                    const SizedBox(height: 4),
                                    const Text(
                                      "Rp. 3000",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ) 
              ),

              //jadi partner
              const SizedBox(height: 20),
              Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/img_onboarding3.png",
                            width: 150,   // atur sesuai kebutuhan
                            height: 150,
                            fit: BoxFit.contain,
                          ),

                          const SizedBox(width: 12),
                          //text
                          Expanded( // <= ini solusinya
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Buat Acara & Voting Kamu Sekarang",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: true,          // biar teks bisa kebungkus
                                  overflow: TextOverflow.visible, 
                                ),
                                SizedBox(height: 4),
                                //button
                                // button
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    backgroundColor: Color(0xFFFFDFE0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    // aksi kalau button diklik
                                  },
                                  child: Text(
                                    "Jadi Partner Kami",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ) 
              ),

              //cari informasi
              const SizedBox(height: 20),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/img_search.png",
                            width: 30,   // atur sesuai kebutuhan
                            height: 30,
                            fit: BoxFit.contain,
                          ),

                          const SizedBox(width: 12),
                          //text
                          Expanded( 
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Cari Informasi Terupdate",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Temukan sumber informasi Terbaru dan Terupdate di Sini!",
                                  style: TextStyle(color: Colors.black),
                                  softWrap: true,          // biar teks bisa kebungkus
                                  overflow: TextOverflow.visible, 
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 50),
                      //news
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(width: 12),
                          //text
                          Expanded( 
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "29 Februari",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "News Title",
                                  style: TextStyle(color: Colors.black),
                                  softWrap: true,          // biar teks bisa kebungkus
                                  overflow: TextOverflow.visible, 
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "News Desc",
                                  style: TextStyle(color: Colors.black),
                                  softWrap: true,          // biar teks bisa kebungkus
                                  overflow: TextOverflow.visible, 
                                ),
                              ],
                            ),
                          ),

                          Image.asset(
                            "assets/images/image_140.png",
                            width: 80,   // atur sesuai kebutuhan
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),
                      //news 2
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(width: 12),
                          //text
                          Expanded( 
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "29 Februari",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "News Title",
                                  style: TextStyle(color: Colors.black),
                                  softWrap: true,          // biar teks bisa kebungkus
                                  overflow: TextOverflow.visible, 
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "News Desc",
                                  style: TextStyle(color: Colors.black),
                                  softWrap: true,          // biar teks bisa kebungkus
                                  overflow: TextOverflow.visible, 
                                ),
                              ],
                            ),
                          ),

                          Image.asset(
                            "assets/images/image_140.png",
                            width: 80,   // atur sesuai kebutuhan
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),

                    ],
                  ),
                ) 
              )

            ],
          ),
        ),
      ),
    );
  }
}