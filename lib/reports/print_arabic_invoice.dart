import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

Future<void> generateAndPrintArabicPdf({
  required List<QueryDocumentSnapshot> data,
}) async {
  final Document pdf = Document();
  // List<String>name =data.;
  // List<String>color =['احمر','اخضر','اصفر'];
  // List<String>weight =['50','20','30'];
  // List<String>date =['20/9/2020','21/10/2021','30/7/2019'];
  List<List<String>> salidas = [];
  List<List<String>> listOfPurchases = [];

  var purchasesAsMap = <Map<String, String>>[
    for (int i = 0; i < data.length; i++)
      {
        "color": "${data[i].get('nameColor')}",
        "weight": "${data[i].get('weight')}",
        "date": "${data[i].get('date')}",
        "name": "${data[i].get('nameCustomer')}",
      },
  ];

  for (int i = 0; i < purchasesAsMap.length; i++) {
    listOfPurchases.add(purchasesAsMap[i].values.toList());
  }

  var arabicFont = Font.ttf(await rootBundle.load("fonts/Cairo-Regular.ttf"));
  pdf.addPage(Page(
      theme: ThemeData.withFont(
        base: arabicFont,
      ),
      pageFormat: PdfPageFormat.roll80,
      build: (Context context) {
        return ListView(children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Directionality(
                textDirection: TextDirection.rtl,
                child: Center(
                    child: Text(' شركه مودال للالمنيوم ',
                        style: TextStyle(
                          fontSize: 7,
                        ))))
          ]),
          SizedBox(height: 3),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Directionality(
                textDirection: TextDirection.rtl,
                child: Center(
                    child: Text(' غزة مقابل برج الوحده ',
                        style: TextStyle(
                          fontSize: 7,
                        ))))
          ]),
          SizedBox(height: 10),
          Container(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Table.fromTextArray(
                  headerStyle: TextStyle(fontSize: 6),
                  headers: <dynamic>['اللون', 'الوزن', 'التاريخ', 'اسم الزبون'],
                  cellAlignment: Alignment.center,
                  cellStyle: TextStyle(fontSize: 5),
                  data: listOfPurchases),
            ),
          ),
          SizedBox(height: 20),

          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Directionality(
                textDirection: TextDirection.rtl,
                child: Center(
                    child: Text(' اجمالي الوزن  250 : ',
                        style: TextStyle(
                          fontSize: 7,
                        ))))
          ]),
        ]);
      }));
  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/1.pdf';
  final File file = File(path);
  await file.writeAsBytes(List.from(await pdf.save()));
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());

  // Directory documentDirectory = await getApplicationDocumentsDirectory();
  // String documentPath = documentDirectory.path;
  // File receiptFile = File("$documentPath/receipt.pdf");
  // receiptFile.writeAsBytesSync(List.from(await pdf.save()));
}
