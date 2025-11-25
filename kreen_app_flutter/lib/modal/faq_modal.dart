
import 'package:flutter/material.dart';
import 'package:kreen_app_flutter/constants.dart';
import 'package:kreen_app_flutter/services/lang_service.dart';
import 'package:url_launcher/url_launcher.dart';

class FaqModal {
  static Future<void> show(BuildContext context, String langCode) async {

    await showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: kGlobalPadding,
                child: FutureBuilder<Map<String, dynamic>>(
                  future: LangService.getJsonDataArray(langCode, "detail_vote", "modal_faq"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Text("Error load text");
                    }

                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Text("No data available");
                    }

                    final data = snapshot.data!;
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //header
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data["header"] ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(Icons.close_rounded, color: Colors.black),
                              ),
                            ],
                          ),
                          const Divider(),

                          const SizedBox(height: 8),

                          //isi konten
                          //sub 1
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '1.  ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data["sub_titel_1"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsetsGeometry.only(left: 23),
                            child: Text(
                              data["desc_titel_1"] ?? "",
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          //sub 2
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '2.  ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data["sub_titel_2"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsetsGeometry.only(left: 23),
                            child: Text(
                              data["desc_titel_2"] ?? "",
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsetsGeometry.only(left: 40),
                            child: Column(
                              children: _buildPoints(data["poin_titel_2"]),
                            ) 
                          ),

                          const SizedBox(height: 20),
                          //sub 3
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '3.  ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data["sub_titel_3"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsetsGeometry.only(left: 23),
                            child: Text(
                              data["desc_titel_3"] ?? "",
                            ),
                          ),

                          const SizedBox(height: 20),
                          //sub 4
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '4.  ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data["sub_titel_4"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsetsGeometry.only(left: 23),
                            child: Text(
                              data["desc_titel_4"] ?? "",
                            ),
                          ),

                          const SizedBox(height: 20),
                          //sub 5
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '5.  ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data["sub_titel_5"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsetsGeometry.only(left: 23),
                            child: Text(
                              data["desc_titel_5"] ?? "",
                            ),
                          ),

                          const SizedBox(height: 20),
                          //sub 6
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '6.  ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data["sub_titel_6"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsetsGeometry.only(left: 23),
                            child: Text(
                              data["desc_titel_6"] ?? "",
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsetsGeometry.only(left: 40),
                            child: Column(
                              children: _buildPoints(data["poin_titel_6"]),
                            ) 
                          ),

                          const SizedBox(height: 20),
                          //sub 7
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '7.  ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data["sub_titel_7"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsetsGeometry.only(left: 23),
                            child: Text(
                              data["desc_titel_7"] ?? "",
                            ),
                          ),

                          const SizedBox(height: 20),
                          //sub 8
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '8.  ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data["sub_titel_8"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsetsGeometry.only(left: 23),
                            child: Text(
                              data["desc_titel_8"] ?? "",
                            ),
                          ),

                          const SizedBox(height: 20),
                          //sub 9
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '9.  ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data["sub_titel_9"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsetsGeometry.only(left: 23),
                            child: Text(
                              data["desc_titel_9"] ?? "",
                            ),
                          ),

                          const SizedBox(height: 20),
                          //sub 10
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '10.',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data["sub_titel_10"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsetsGeometry.only(left: 23),
                            child: Text(
                              data["desc_titel_10"] ?? "",
                            ),
                          ),

                          const SizedBox(height: 20),
                          //sub 11
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '11.',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data["sub_titel_11"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left: 23),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data["desc_titel_11"] ?? "",
                                  softWrap: true,
                                ),

                                InkWell(
                                  onTap: () async {
                                    final url = Uri.parse('https://wa.me/6285232304965');
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url, mode: LaunchMode.externalApplication);
                                    } else {
                                      debugPrint("Could not launch WhatsApp");
                                    }
                                  },
                                  child: const Text(
                                    '+62 852-3230-4965',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),
                          //sub 12
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '12.',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data["sub_titel_12"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsetsGeometry.only(left: 23),
                            child: Text(
                              data["desc_titel_7"] ?? "",
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }
        );
      }
    );
  }
  
  static _buildPoints(dynamic poinList) {
    if (poinList == null) return [];
    final List<Map<String, dynamic>> items =
        List<Map<String, dynamic>>.from(poinList);

    return List<Widget>.generate(items.length, (index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${index + 1}. ",
            ),
            Expanded(
              child: Text(
                items[index]["poin"] ?? "",
              ),
            ),
          ],
        ),
      );
    });
  }
}