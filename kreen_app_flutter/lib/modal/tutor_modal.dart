import 'package:flutter/material.dart';
import 'package:kreen_app_flutter/constants.dart';
import 'package:kreen_app_flutter/services/lang_service.dart';

class TutorModal {

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
              child: ListView(
                padding: kGlobalPadding,
                children: [ 
                  FutureBuilder<Map<String, dynamic>>(
                    future: LangService.getJsonDataArray(langCode, "detail_vote", "modal_tutor"),
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
                      return Container(
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
                            Text(
                              data["sub_titel_1"] ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsetsGeometry.only(left: 23),
                              child: Column(
                                children: _buildPoints(data["poin_titel_1"]),
                              )
                            ),

                            const SizedBox(height: 16),

                            // Sub 2
                            Text(
                              data["sub_titel_2"] ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsetsGeometry.only(left: 23),
                              child: Column(
                                children: _buildPoints(data["poin_titel_2"]),
                              )
                            ),

                            const SizedBox(height: 16),

                            // Sub 3
                            Text(
                              data["sub_titel_3"] ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsetsGeometry.only(left: 23),
                              child: Column(
                                children: _buildPoints(data["poin_titel_3"]),
                              )
                            ),
                          ],
                        )
                      );
                    },
                  ),
                ]
              )
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