// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace, use_build_context_synchronously

import 'package:alessa_v2/controllers/ReturnRMA/ReturnDZones.dart';
import 'package:alessa_v2/models/GetItemInfoByItemSerialNoModel.dart';
import 'package:alessa_v2/screens/PalletIdInquiry/PalletIdInquiryScreen.dart';
import 'package:alessa_v2/widgets/ElevatedButtonWidget.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../controllers/PalletIdInquiry/PalletIdInquiryController.dart';

import '../../utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/AppBarWidget.dart';
import '../../../widgets/TextFormField.dart';
import '../../../widgets/TextWidget.dart';

class PalletIdInquiryScreen2 extends StatefulWidget {
  String grin;
  String palletCode;
  String serialNo;
  String binLocation;

  PalletIdInquiryScreen2({
    required this.grin,
    required this.palletCode,
    required this.serialNo,
    required this.binLocation,
  });

  @override
  State<PalletIdInquiryScreen2> createState() => _PalletIdInquiryScreen2State();
}

class _PalletIdInquiryScreen2State extends State<PalletIdInquiryScreen2> {
  TextEditingController palletIdController = TextEditingController();
  FocusNode serialNoFocusNode = FocusNode();

  String total = "0";
  List<GetItemInfoByItemSerialNoModel> table = [];
  List<bool> isMarked = [];

  final TextEditingController _searchController = TextEditingController();
  String? dropDownValue;
  List<String> dropDownList = [];
  List<String> filterList = [];

  @override
  void initState() {
    palletIdController.text = widget.palletCode;
    super.initState();
    // Future.delayed(Duration.zero, () {
    //   Constants.showLoadingDialog(context);
    //   GetMapBarcodeDataByItemCodeController.getData().then((value) {
    //     for (int i = 0; i < value.length; i++) {
    //       setState(() {
    //         dropDownList.add(value[i].bIN ?? "");
    //       });
    //     }

    //     setState(() {
    //       // convert list to set to remove duplicate values
    //       dropDownList = dropDownList.toSet().toList();

    //       dropDownList.removeWhere((element) => element == "");
    //       dropDownValue = dropDownList[0];
    //       filterList = dropDownList;
    //     });
    //     Navigator.pop(context);
    //   }).onError((error, stackTrace) {
    //     Navigator.pop(context);
    //   });
    // });

    Future.delayed(
      Duration.zero,
      () async {
        try {
          Constants.showLoadingDialog(context);
          var value = await ReturnDZones.getData();

          for (int i = 0; i < value.length; i++) {
            setState(() {
              dropDownList.add(value[i].rZONE ?? "");
              Set<String> set = dropDownList.toSet();
              dropDownList = set.toList();
            });
          }
          setState(() {
            dropDownValue = dropDownList[0];
            filterList = dropDownList;
          });

          Navigator.pop(context);
        } catch (e) {
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    palletIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBarWidget(
            autoImplyLeading: true,
            onPressed: () {
              Get.back();
            },
            title: "Pallet Id inquiry".toUpperCase(),
            actions: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    "assets/delete.png",
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 10),
                  child: const TextWidget(
                    text: "Pallet ID/Code*",
                    fontSize: 16,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: TextFormFieldWidget(
                    hintText: "Enter/Scan pallet code",
                    controller: palletIdController,
                    width: MediaQuery.of(context).size.width * 0.9,
                    readOnly: true,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: PaginatedDataTable(
                    rowsPerPage: 3,
                    columns: const [
                      DataColumn(
                          label: Text(
                        'Gtin',
                        style: TextStyle(color: Colors.black),
                      )),
                      DataColumn(
                          label: Text(
                        'Pallet Code',
                        style: TextStyle(color: Colors.black),
                      )),
                      DataColumn(
                          label: Text(
                        'Item Serial No.',
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      )),
                      DataColumn(
                          label: Text(
                        'Bin Location',
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      )),
                    ],
                    source: PaginatedTable(table, context),
                    showCheckboxColumn: false,
                    showFirstLastButtons: true,
                    arrowHeadColor: Colors.orange,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 10),
                  child: TextWidget(
                    text: "Scan Location To:",
                    color: Colors.blue[900]!,
                    fontSize: 15,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width * 0.73,
                      margin: const EdgeInsets.only(left: 20),
                      child: DropdownSearch<String>(
                        filterFn: (item, filter) {
                          return item
                              .toLowerCase()
                              .contains(filter.toLowerCase());
                        },
                        enabled: true,
                        dropdownButtonProps: const DropdownButtonProps(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                        ),
                        items: filterList,
                        onChanged: (value) {
                          setState(() {
                            dropDownValue = value!;
                          });
                        },
                        selectedItem: dropDownValue,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: IconButton(
                        onPressed: () {
                          // show dialog box for search
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: TextWidget(
                                  text: "Search",
                                  color: Colors.blue[900]!,
                                  fontSize: 15,
                                ),
                                content: TextFormFieldWidget(
                                  controller: _searchController,
                                  readOnly: false,
                                  hintText: "Enter/Scan Location",
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  onEditingComplete: () {
                                    setState(() {
                                      dropDownList = dropDownList
                                          .where((element) => element
                                              .toLowerCase()
                                              .contains(_searchController.text
                                                  .toLowerCase()))
                                          .toList();
                                      dropDownValue = dropDownList[0];
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: TextWidget(
                                      text: "Cancel",
                                      color: Colors.blue[900]!,
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // filter list based on search
                                      setState(() {
                                        filterList = dropDownList
                                            .where((element) => element
                                                .toLowerCase()
                                                .contains(_searchController.text
                                                    .toLowerCase()))
                                            .toList();
                                        dropDownValue = filterList[0];
                                      });

                                      Navigator.pop(context);
                                    },
                                    child: TextWidget(
                                      text: "Search",
                                      color: Colors.blue[900]!,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButtonWidget(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 50,
                      title: "Scan Again",
                      fontSize: 16,
                      textColor: Colors.white,
                      color: Colors.grey,
                      onPressed: () {
                        // go back to previous screen and replace it
                        Get.off(() => const PalletIdInquiryScreen1());
                      },
                    ),
                    ElevatedButtonWidget(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 50,
                      title: "Transfer Location",
                      fontSize: 16,
                      textColor: Colors.white,
                      color: Colors.orange,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onClick() async {
    if (palletIdController.text.trim().isEmpty) {
      // hide keyboard
      FocusScope.of(context).requestFocus(FocusNode());
      return;
    }
    Constants.showLoadingDialog(context);
    PalletIdInquiryController.getShipmentPalletizing(
            palletIdController.text.trim())
        .then((value) {
      setState(() {
        table = List.generate(1, (index) => value[index]);
        total = table.length.toString();
        isMarked = List<bool>.filled(table.length, false);
        palletIdController.clear();
        // focus back to serial no
        FocusScope.of(context).requestFocus(serialNoFocusNode);
      });
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      setState(() {
        palletIdController.clear();
        FocusScope.of(context).requestFocus(serialNoFocusNode);
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.toString().replaceAll("Exception:", ""))));
    });
  }
}

class PaginatedTable extends DataTableSource {
  List<GetItemInfoByItemSerialNoModel> e;
  BuildContext ctx;

  PaginatedTable(
    this.e,
    this.ctx,
  );

  @override
  DataRow? getRow(int index) {
    if (index >= e.length) {
      return null;
    }

    final student = e[index];

    return DataRow.byIndex(
      index: index,
      onSelectChanged: (value) {},
      cells: [
        DataCell(SelectableText(student.gTIN ?? "")),
        DataCell(SelectableText(student.palletCode ?? "")),
        DataCell(SelectableText(student.itemSerialNo ?? "")),
        DataCell(SelectableText(student.binLocation ?? "")),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => e.length;

  @override
  int get selectedRowCount => 0;
}
