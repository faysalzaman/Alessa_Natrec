// ignore_for_file: sized_box_for_whitespace, unrelated_type_equality_checks

import 'package:alessa_v2/controllers/JournalMovement/insertJournalMovementCLDetsController.dart';
import 'package:alessa_v2/controllers/JournalMovement/updateWmsJournalMovementClQtyScannedController.dart';
import 'package:alessa_v2/models/getMappedBarcodedsByItemCodeAndBinLocationModel.dart';
import 'package:alessa_v2/models/updateWmsJournalMovementClQtyScannedModel.dart';
import 'package:alessa_v2/widgets/TextFormField.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../../screens/JournalMovement/JournalMovementScreen2.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/JournalMovement/getWmsJournalMovementClByAssignedToUserIdController.dart';
import '../../models/getWmsJournalMovementClByAssignedToUserIdModel.dart';
import '../../utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/AppBarWidget.dart';
import '../../../../widgets/TextWidget.dart';

class JournalMovementScreen1 extends StatefulWidget {
  const JournalMovementScreen1({super.key});

  @override
  State<JournalMovementScreen1> createState() => _JournalMovementScreen1State();
}

class _JournalMovementScreen1State extends State<JournalMovementScreen1> {
  TextEditingController _serialNoController = TextEditingController();

  String total = "0";
  String total2 = "0";

  List<getWmsJournalMovementClByAssignedToUserIdModel> table = [];
  List<getWmsJournalMovementClByAssignedToUserIdModel> filterTable = [];

  List<getWmsJournalMovementClByAssignedToUserIdModel> table2 = [];

  List<bool> isMarked = [];

  String userName = "";
  String userID = "";

  void _showUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String? token = prefs.getString('token');
    final String? userId = prefs.getString('userId');
    final String? fullName = prefs.getString('fullName');
    // final String? userLevel = prefs.getString('userLevel');
    // final String? loc = prefs.getString('userLocation');

    setState(() {
      userName = fullName!;
      userID = userId!;
    });
  }

  String? journalIdValue = "";
  List<String> journalIdList = [];

  List<String> itemIdValue = [];
  List<String> itemIdList = [];

  updateWmsJournalMovementClQtyScannedModel
      updateWmsJournalMovementClQtyScannedList =
      updateWmsJournalMovementClQtyScannedModel();

  @override
  void initState() {
    super.initState();
    _showUserInfo();
    Future.delayed(Duration.zero, () {
      Constants.showLoadingDialog(context);
      getWmsJournalMovementClByAssignedToUserIdController
          .getData()
          .then((value) {
        setState(() {
          table = value;
          filterTable = value;

          // get the journalIdList
          journalIdList =
              table.map((e) => e.jOURNALID.toString()).toSet().toList();
          // convert to set
          journalIdList = journalIdList.toSet().toList();
          // sort the list
          journalIdList.sort((a, b) => a.compareTo(b));
          // remove the empty string
          journalIdList.removeWhere((element) => element == "");
          journalIdValue = journalIdList[0];

          // get the itemIdList
          itemIdList = table.map((e) => e.iTEMID.toString()).toSet().toList();
          // convert to set
          itemIdList = itemIdList.toSet().toList();
          // sort the list
          itemIdList.sort((a, b) => a.compareTo(b));
          // remove the empty string
          itemIdList.removeWhere((element) => element == "");

          isMarked = List<bool>.generate(table.length, (index) => false);
          total = table.length.toString();
        });
        Navigator.of(context).pop();
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString().replaceAll("Exception:", "")),
          ),
        );
        Navigator.of(context).pop();
      });
    });
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
            title: "Journal Movement".toUpperCase(),
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
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Current Logged in User Id: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900]!,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        userID,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[900]!,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Filter By Journal ID",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]!,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: const EdgeInsets.only(left: 20),
                  child: DropdownSearch<String>(
                    items: journalIdList,
                    onChanged: (value) {
                      setState(() {
                        journalIdValue = value!;
                        // filter the filterTable by journalIdValue
                        filterTable = table
                            .where((element) =>
                                element.jOURNALID == journalIdValue)
                            .toList();
                        total = filterTable.length.toString();
                      });
                    },
                    selectedItem: journalIdValue,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Filter By Item Id",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]!,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: MultiSelectDialogField(
                      items:
                          itemIdList.map((e) => MultiSelectItem(e, e)).toList(),
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (values) {
                        itemIdValue = values;
                        setState(() {
                          filterTable = table
                              .where((element) => itemIdValue
                                  .contains(element.iTEMID.toString()))
                              .toList();
                          total = filterTable.length.toString();

                          if (itemIdValue.isEmpty || itemIdValue.length == 0) {
                            filterTable = table;
                            total = filterTable.length.toString();
                          }
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue[900]!,
                        width: 2,
                      ),
                    ),
                    child: PaginatedDataTable(
                      // header: Text(
                      //   "Total: $total",
                      //   style: TextStyle(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.blue[900]!,
                      //   ),
                      // ),

                      columnSpacing: 10,
                      horizontalMargin: 20,
                      showCheckboxColumn: false,
                      headingRowHeight: 30,
                      dataRowHeight: 60,
                      primary: true,
                      showFirstLastButtons: true,
                      source: StudentDataSource(filterTable, context),
                      rowsPerPage: 5,
                      checkboxHorizontalMargin: 10,
                      columns: const [
                        DataColumn(
                            label: Text(
                          'ITEM ID',
                          style: TextStyle(color: Colors.black),
                        )),
                        DataColumn(
                            label: Text(
                          'ITEM NAME',
                          style: TextStyle(color: Colors.black),
                        )),
                        DataColumn(
                            label: Text(
                          'QTY',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'LEDGER ACCOUNT ID OFFSET',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'JOURNAL ID',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'TRANS DATE',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'INVENT SITE ID',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'INVENT LOCATION ID',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'CONFIG ID',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'WMS LOCATION ID',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'TRX DATE TIME',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'TRX USER ID ASSIGNED',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'TRX USER ID ASSIGNED BY',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'ITEM SERIAL NO',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'QTY SCANNED',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'QTY DIFFERENCE',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                      ], // Adjust the number of rows per page as needed
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    const TextWidget(
                      text: "TOTAL",
                      fontSize: 16,
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: TextWidget(
                          text: total,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 10),
                  child: TextWidget(
                    text: "Scan Serial#",
                    color: Colors.blue[900]!,
                    fontSize: 15,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: TextFormFieldWidget(
                    controller: _serialNoController,
                    readOnly: false,
                    hintText: "Enter/Scan Serial No",
                    width: MediaQuery.of(context).size.width * 0.9,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Constants.showLoadingDialog(context);

                      updateWmsJournalMovementClQtyScannedController
                          .getData(
                        "iTEMID",
                        "jOURNALID",
                        "tRXUSERIDASSIGNED",
                      )
                          .then((value) {
                        setState(() {
                          updateWmsJournalMovementClQtyScannedList = value;
                        });
                        InsertJournalMovementCLDetsController.getData(
                                updateWmsJournalMovementClQtyScannedList,
                                _serialNoController.text.trim())
                            .then((value) {
                          setState(
                            () {
                              // check if the entered serial no is not present in the
                              if (table
                                  .where((element) =>
                                      element.iTEMSERIALNO.toString().trim() ==
                                      _serialNoController.text.trim())
                                  .toList()
                                  .isEmpty) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: TextWidget(
                                      text:
                                          "Serial No. not found in the list, please a serial no from the above list.",
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              // append the selected pallet code row to the GetShipmentPalletizingList2
                              table2.add(
                                table.firstWhere(
                                  (element) =>
                                      element.iTEMSERIALNO.toString().trim() ==
                                      _serialNoController.text.trim(),
                                ),
                              );
                              // remove the selected pallet code row from the GetShipmentPalletizingList
                              table.removeWhere(
                                (element) =>
                                    element.iTEMSERIALNO.toString().trim() ==
                                    _serialNoController.text.trim(),
                              );
                              total2 = table2.length.toString();
                              total = table.length.toString();
                            },
                          );
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: TextWidget(
                                text: "Record Inserted Successfully.",
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                          _serialNoController.clear();
                        }).onError((error, stackTrace) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: TextWidget(
                                text: error
                                    .toString()
                                    .replaceAll("Exception:", ""),
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        });
                      }).onError((error, stackTrace) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: TextWidget(
                              text: error.toString(),
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StudentDataSource extends DataTableSource {
  List<getWmsJournalMovementClByAssignedToUserIdModel> students;
  BuildContext ctx;
  StudentDataSource(
    this.students,
    this.ctx,
  );

  @override
  DataRow? getRow(int index) {
    if (index >= students.length) {
      return null;
    }

    final student = students[index];

    return DataRow.byIndex(
      index: index,
      onSelectChanged: (value) {
        Get.to(() => JournalMovementScreen2(
              iTEMID: student.iTEMID.toString(),
              iTEMNAME: student.iTEMNAME.toString(),
              qTY: int.parse(student.qTY.toString()),
              lEDGERACCOUNTIDOFFSET: student.lEDGERACCOUNTIDOFFSET.toString(),
              jOURNALID: student.jOURNALID.toString(),
              tRANSDATE: student.tRANSDATE.toString(),
              iNVENTSITEID: student.iNVENTSITEID.toString(),
              iNVENTLOCATIONID: student.iNVENTLOCATIONID.toString(),
              cONFIGID: student.cONFIGID.toString(),
              wMSLOCATIONID: student.wMSLOCATIONID.toString(),
              tRXDATETIME: student.tRXDATETIME.toString(),
              tRXUSERIDASSIGNED: student.tRXUSERIDASSIGNED.toString(),
              tRXUSERIDASSIGNEDBY: student.tRXUSERIDASSIGNEDBY.toString(),
              iTEMSERIALNO: student.iTEMSERIALNO.toString() == "null"
                  ? 0
                  : int.parse(student.iTEMSERIALNO.toString()),
              qTYSCANNED: student.qTYSCANNED.toString() == "null"
                  ? 0
                  : int.parse(student.qTYSCANNED.toString()),
              qTYDIFFERENCE: student.qTYDIFFERENCE.toString() == "null"
                  ? 0
                  : int.parse(student.qTYDIFFERENCE.toString()),
            ));
      },
      cells: [
        DataCell(SelectableText(student.iTEMID ?? "")),
        DataCell(SelectableText(student.iTEMNAME ?? "")),
        DataCell(SelectableText(
            student.qTY.toString() == "null" ? "0" : student.qTY.toString())),
        DataCell(SelectableText(student.lEDGERACCOUNTIDOFFSET ?? "")),
        DataCell(SelectableText(student.jOURNALID ?? "")),
        DataCell(SelectableText(student.tRANSDATE ?? "")),
        DataCell(SelectableText(student.iNVENTSITEID ?? "")),
        DataCell(SelectableText(student.iNVENTLOCATIONID ?? "")),
        DataCell(SelectableText(student.cONFIGID ?? "")),
        DataCell(SelectableText(student.wMSLOCATIONID ?? "")),
        DataCell(SelectableText(student.tRXDATETIME ?? "")),
        DataCell(SelectableText(student.tRXUSERIDASSIGNED ?? "")),
        DataCell(SelectableText(student.tRXUSERIDASSIGNEDBY ?? "")),
        DataCell(Row(
          children: [
            SelectableText(student.iTEMSERIALNO.toString() == "null"
                ? ""
                : student.iTEMSERIALNO.toString()),
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(
                    text: student.iTEMSERIALNO.toString() == "null"
                        ? ""
                        : student.iTEMSERIALNO.toString()));
                ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                  content: Text(
                      "Copied ${student.iTEMSERIALNO.toString() == "null" ? "" : student.iTEMSERIALNO.toString()}"),
                ));
              },
            ),
          ],
        )),
        DataCell(SelectableText(student.qTYSCANNED.toString() == "null"
            ? "0"
            : student.qTYSCANNED.toString())),
        DataCell(SelectableText(student.qTYDIFFERENCE.toString() == "null"
            ? "0"
            : student.qTYDIFFERENCE.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => students.length;

  @override
  int get selectedRowCount => 0;
}
