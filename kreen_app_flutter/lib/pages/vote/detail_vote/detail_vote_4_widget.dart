import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kreen_app_flutter/constants.dart';
import 'package:kreen_app_flutter/modal/faq_modal.dart';
import 'package:kreen_app_flutter/modal/s_k_modal.dart';
import 'package:kreen_app_flutter/modal/tutor_modal.dart';

class DeskripsiSection_4 extends StatelessWidget {
  final Map<String, dynamic> data;
  final String langCode;
  const DeskripsiSection_4({super.key, required this.data, required this.langCode});

  @override
  Widget build(BuildContext context) {
    Map<String, Color> colorMap = {
      'Blue': Colors.blue,
      'Red': Colors.red,
      'Green': Colors.green,
      'Yellow': Colors.yellow,
      'Purple': Colors.purple,
      'Orange': Colors.orange,
      'Pink': Colors.pink,
      'Grey': Colors.grey,
      'Turqoise': Colors.teal,
    };

    String themeName = 'Red';
    if (data['theme_name'] != null)
      themeName = data['theme_name'];
    Color color = colorMap[themeName] ?? Colors.red;

    Color bgColor;
    if (color is MaterialColor) {
      bgColor = color.shade50;
    } else {
      bgColor = color.withOpacity(0.1);
    }

    final dateStr = data['tanggal_grandfinal_mulai']?.toString() ?? '-';
    
    String formattedDate = '-';
    
    if (dateStr.isNotEmpty) {
      try {
        // parsing string ke DateTime
        final date = DateTime.parse(dateStr); // pastikan format ISO (yyyy-MM-dd)
        if (langCode == 'id') {
          // Bahasa Indonesia
          final formatter = DateFormat("EEEE, dd MMMM yyyy", "id_ID");
          formattedDate = formatter.format(date);
        } else {
          // Bahasa Inggris
          final formatter = DateFormat("EEEE, MMMM d yyyy", "en_US");
          formattedDate = formatter.format(date);

          // tambahkan suffix (1st, 2nd, 3rd, 4th...)
          final day = date.day;
          String suffix = 'th';
          if (day % 10 == 1 && day != 11) suffix = 'st';
          else if (day % 10 == 2 && day != 12) suffix = 'nd';
          else if (day % 10 == 3 && day != 13) suffix = 'rd';
          formattedDate = formatter.format(date).replaceFirst('$day', '$day$suffix');
        }
      } catch (e) {
        formattedDate = '-';
      }
    }

    DateTime mulai = DateTime.parse("${data['tanggal_grandfinal_mulai']} ${data['waktu_mulai']}");
    DateTime selesai = DateTime.parse("${data['tanggal_grandfinal_mulai']} ${data['waktu_selesai']}");

    String jamMulai = "${mulai.hour.toString().padLeft(2, '0')}:${mulai.minute.toString().padLeft(2, '0')}";
    String jamSelesai = "${selesai.hour.toString().padLeft(2, '0')}:${selesai.minute.toString().padLeft(2, '0')}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          data['banner']?.toString().isNotEmpty == true
              ? data['banner']
              : 'https://via.placeholder.com/600x300?text=No+Image',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        const SizedBox(height: 8),

        Padding(
          padding: kGlobalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  data['nama_kategori'],
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),

              // title event
              Text(
                data['judul_vote'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // tombol list horizontal
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        await FaqModal.show(context, 'id');
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: color,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "FAQ Vote",
                              style: TextStyle(color: color),
                            ),
                            const SizedBox(width: 5),
                            Icon(Icons.open_in_new, color: color, size: 14),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () async {
                        await TutorModal.show(context, 'id');
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: color, // outline merah
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Tutorial Vote",
                              style: TextStyle(color: color),
                            ),
                            const SizedBox(width: 5),
                            Icon(Icons.open_in_new, color: color, size: 14),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () async {
                        await SKModal.show(context, data['snk']);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: color, // outline merah
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "S&K Voting",
                              style: TextStyle(color: color),
                            ),
                            const SizedBox(width: 5),
                            Icon(Icons.open_in_new, color: color, size: 14),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              Container(
                color: Colors.white,
                child: Padding(
                  padding: kGlobalPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.network(
                            data['icon_penyelenggara'],
                            width: 80,   // atur sesuai kebutuhan
                            height: 80,
                            fit: BoxFit.contain,
                          ),

                          const SizedBox(width: 12),
                          //text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Diselenggarakan Oleh",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  data['nama_penyelenggara'],
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                  softWrap: true,          // biar teks bisa kebungkus
                                  overflow: TextOverflow.visible, 
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12,),
                      Text(
                        "Deskripsi",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 12,),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: kGlobalPadding,
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (data['merchant_description'] != null)
                                    Html(
                                      data: data['merchant_description'],
                                    ),
                                  Html(
                                    data: data['deskripsi'],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ) 
                      ),

                      const SizedBox(height: 12,),
                      Text(
                        "Tanggal dan Waktu",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 12,),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: kGlobalPadding,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.network(
                                    "https://dev.kreenconnect.com/image/icon-vote/${themeName}/Calendar.svg",
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.contain,
                                  ),

                                  const SizedBox(width: 12),
                                  //text
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          formattedDate,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.network(
                                    "https://dev.kreenconnect.com/image/icon-vote/${themeName}/Time.svg",
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.contain,
                                  ),

                                  const SizedBox(width: 12),
                                  //text
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "$jamMulai - $jamSelesai",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 2), 
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          " (${data['code_timezone']})",
                                          style: TextStyle(
                                            color: color,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic
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

                      const SizedBox(height: 15,),
                      Text(
                        "Lokasi",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 12,),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: kGlobalPadding,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.network(
                                    "https://dev.kreenconnect.com/image/icon-vote/${themeName}/Locations.svg",
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.contain,
                                  ),

                                  const SizedBox(width: 12),
                                  //text
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          data['lokasi_alamat'] ?? '-',
                                          style: TextStyle(
                                            color: Colors.black,
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
                    ],
                  ),
                ) 
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class LeaderboardSection_4 extends StatelessWidget {
  final List<dynamic> ranking;
  final Map<String, dynamic> data;
  const LeaderboardSection_4({super.key, required this.ranking, required this.data});
  

  @override
  Widget build(BuildContext context) {
    Map<String, Color> colorMap = {
      'Blue': Colors.blue,
      'Red': Colors.red,
      'Green': Colors.green,
      'Yellow': Colors.yellow,
      'Purple': Colors.purple,
      'Orange': Colors.orange,
      'Pink': Colors.pink,
      'Grey': Colors.grey,
      'Turqoise': Colors.teal,
    };

    String themeName = 'Red';
    if (data['theme_name'] != null)
      themeName = data['theme_name'];
    Color color = colorMap[themeName] ?? Colors.red;

    Color bgColor;
    if (color is MaterialColor) {
      bgColor = color.shade200;
    } else {
      bgColor = color.withOpacity(0.1);
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [bgColor, color],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(6), // jarak icon ke lingkaran
                decoration: const BoxDecoration(
                  color: Colors.white, // background lingkaran
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  FontAwesomeIcons.crown, // icon mahkota
                  color: color,
                  size: 20,
                ),
              ),

              const SizedBox(height: 12,),
              Text(
                "Leaderboard",
                style: TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 12,),
              Text(
                data['judul_vote'],
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),

        // konten data dari data api
        if (ranking.isNotEmpty) ... [
          const SizedBox(height: 12,),

          Column(
            children: ranking.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20), // jarak antar item
                  child: buildListCard(
                    rank: item['rank'],
                    name: item['nama_finalis'],
                    votes: item['total_voters'],
                    image: item['poster_finalis'],
                  ),
              );
            }).toList(),
          )
        ]

        else ... [
          Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Belum ada leaderboard",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class DukunganSection_4 extends StatelessWidget {
  final Map<String, dynamic> data;
  final List<dynamic> support;
  final String langCode;
  const DukunganSection_4({super.key, required this.data, required this.support, required this.langCode});

  @override
  Widget build(BuildContext context) {
    Map<String, Color> colorMap = {
      'Blue': Colors.blue,
      'Red': Colors.red,
      'Green': Colors.green,
      'Yellow': Colors.yellow,
      'Purple': Colors.purple,
      'Orange': Colors.orange,
      'Pink': Colors.pink,
      'Grey': Colors.grey,
      'Turqoise': Colors.teal,
    };

    String themeName = 'Red';
    if (data['theme_name'] != null)
      themeName = data['theme_name'];
    Color color = colorMap[themeName] ?? Colors.red;

    Color bgColor;
    if (color is MaterialColor) {
      bgColor = color.shade200;
    } else {
      bgColor = color.withOpacity(0.1);
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [bgColor, color],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.mail_outline,
                  color: color,
                  size: 20,
                ),
              ),
              Text(
                "Apa Kata Mereka",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: (data['dukungan'] != null && data['dukungan'].isNotEmpty)
          ? data['dukungan'].map<Widget>((item) {
            final dateStr = item['created_at'];
            var hide_nama = item['hide_name'];
            var nama = item['nama'] ?? '-';
    
            String formattedDate = '-';
  
            if (dateStr.isNotEmpty) {
              try {
                final date = DateTime.parse(dateStr);

                if (langCode == 'id') {
                  // Bahasa Indonesia
                  final formatter = DateFormat("dd MMMM yyyy HH:mm", "id_ID");
                  formattedDate = "${formatter.format(date)} WIB";
                } else {
                  // Bahasa Inggris
                  final formatter = DateFormat("MMMM d yyyy HH:mm", "en_US");
                  formattedDate = formatter.format(date);

                  // Tambahkan suffix hari
                  final day = date.day;
                  String suffix = 'th';
                  if (day % 10 == 1 && day != 11) suffix = 'st';
                  else if (day % 10 == 2 && day != 12) suffix = 'nd';
                  else if (day % 10 == 3 && day != 13) suffix = 'rd';
                  formattedDate = formatter.format(date).replaceFirst('$day', '$day$suffix');
                }
              } catch (e) {
                formattedDate = '-';
              }
            }
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 20), // jarak antar item
              child: CommentCard(
                name: hide_nama == '0' ? nama : 'Anonymous',
                time: formattedDate,
                message: item['dukungan']
              ),
            );
          }).toList()
          : [
            Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Belum ada dukungan",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget buildListCard({
  required int rank,
  required String name,
  required int votes,
  required String image,
}) {

  return Container(
    padding: kGlobalPadding,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        if (rank == 1)
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.emoji_events, size: 32, color: Colors.amber),
              Text(
                "1",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          )
        else if (rank == 2)
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.emoji_events, size: 32, color: Colors.grey),
              Text(
                "2",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          )
        else if (rank == 3)
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.emoji_events, size: 32, color: Colors.brown),
              Text(
                "3",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          )
        else
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.circle, size: 32, color: Colors.white),
              Text(
                "$rank",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
            
        const SizedBox(width: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(image, height: 50, width: 50, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
        ),
        
      ],
    ),
  );
}

Widget CommentCard({
  required String name,
  required String time,
  required String message,
}) {
  return Container(
    width: double.infinity,
    padding: kGlobalPadding,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, // biar teks rata kiri
      children: [
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        Text(
          time,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),

        const SizedBox(height: 15),

        Text(
          message,
          softWrap: true, // biar otomatis turun ke bawah
        ),
      ],
    ),
  );

}