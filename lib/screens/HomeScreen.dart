// ignore_for_file: avoid_print, must_be_immutable, unrelated_type_equality_checks

import 'package:alessa_v2/models/GetRolesAssignedToUserModel.dart';
import 'package:alessa_v2/screens/PalletIdInquiry/PalletIdInquiryScreen.dart';
import 'package:alessa_v2/screens/UnAllocatedItem/UnAllocatedItemsScreen1.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../screens/Authentication/LoginScreen.dart';
import 'DispatchingForm/DispatchingScreen.dart';
import '../../screens/JournalMovement/JournalMovementScreen1.dart';
import '../../screens/PhysicalInventory/PhysicalInventoryScreen.dart';
import '../../screens/ProfitAndLoss/ProfitAndLossScreen1.dart';
import '../../screens/ReturnRMA/ReturnRMAScreen1.dart';

import '../../Core/Animation/Fade_Animation.dart';
import '../../screens/BinToBinAXAPTA/BinToBinAxaptaScreen.dart';
import '../../screens/BinToBinInternal/BinToBinInternalScreen.dart';
import '../../screens/BinToBinJournal/BinToBinJournalScreen.dart';
import '../../screens/ItemReAllocation/ItemReAllocationScreen.dart';
import '../../screens/Palletizing/ShipmentPalletizingScreen.dart';
import '../../screens/PutAway/PutAwayScreen.dart';
import 'ReceiptManagement/ShipmentDispatchingScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'PhysicalInverntoryByBinLocation/PhysicalInventoryByBinLocationScreen.dart';
import 'PickListAssigned/PickListAssignedScreen.dart';
import 'RMAputaway/RMAPutawayScreen.dart';

class HomeScreen extends StatefulWidget {
  List<GetRolesAssignedToUserModel> roles;
  HomeScreen({Key? key, required this.roles}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> data = {
    "images": [
      "assets/barcode.png",
      "assets/container.png",
      "assets/gtin_tracking.png",
      "assets/stock_management.png",
      "assets/picking.png",
      "assets/work_in_progress.png",
      "assets/physical_invention.png",
      "assets/log-in.png",
      "assets/journal.png",
      "assets/product-return.png",
      "assets/put-away.png",
      "assets/inventory-location.png",
      "assets/movement.png",
      "assets/wms-inventory.png",
      "assets/profit-and-loss.png",
      "assets/allocation.png",
      "assets/receipt_management.png",
      "assets/inventory.png",
      "assets/logout.jpg",
    ],
    "titles": [
      "Barcode Mapping",
      "Receiving",
      "Palletization",
      "Shipment Put-Away",
      "Picking Slip",
      "Dispatching",
      "Bin To Bin (AXAPTA)",
      "Bin To Bin (Internal)",
      "Bin To Bin (Journal)",
      "Return RMA",
      "RMA Put-Away",
      "Inventory by Bin Location",
      "Journal Movement Counting",
      "Physical Count (WMS)",
      "Profit and Loss",
      "Items Re-Allocation",
      "Un-Allocated Items",
      "Pallet ID Inquiry",
      "Logout",
    ],
    "functions": [
      () {},
      () {},
      () {},
      () {},
      () {},
      () {},
      () {},
      () {},
      () {},
      () {},
      () {},
      () {},
      () {},
      () {},
      () {},
      () {},
      () {},
      () {},
      () {},
    ],
  };

  void _showUserInfo() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString('token');
    // String? userId = prefs.getString('userId');
    // String? fullName = prefs.getString('fullName');
    // String? userLevel = prefs.getString('userLevel');
    // String? loc = prefs.getString('userLocation');

    // print('token: $token');
    // print('userId: $userId');
    // print('fullName: $fullName');
    // print('userLevel: $userLevel');
    // print('loc: $loc');
  }

  @override
  void initState() {
    super.initState();
    data['functions'][0] = () {
      if (widget.roles
              .where((element) => element.roleName == "WO Mapped Items")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const DispatchingScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    };
    data['functions'][1] = () {
      if (widget.roles
              .where((element) => element.roleName == "WO Shipment Received")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const ShipmentDispatchingScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    };
    data['functions'][2] = () {
      if (widget.roles
              .where((element) => element.roleName == "WO Pallets")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const ShipmentPalletizingScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    };
    data['functions'][3] = () {
      if (widget.roles
              .where((element) => element.roleName == "WO PutAway")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const PutAwayScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    };
    data['functions'][4] = () {
      if (widget.roles
              .where((element) => element.roleName == "WO Picking")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => PickListAssignedScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    };
    data['functions'][5] = () {
      if (widget.roles
              .where((element) => element.roleName == "WO Dispatching")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const DispatchingScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    };
    data['functions'][6] = () {
      if (widget.roles
              .where((element) => element.roleName == "WMS Bin to Bin(Axapta)")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const BinToBinAxaptaScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    };
    data['functions'][7] = () {
      if (widget.roles
              .where(
                  (element) => element.roleName == "WMS Bin to Bin(Internal)")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const BinToBinInternalScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    };
    data['functions'][8] = () {
      if (widget.roles
              .where((element) => element.roleName == "WMS Bin to Bin(Journal)")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const BinToBinJournalScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    };
    data['functions'][9] = () {
      if (widget.roles
              .where((element) => element.roleName == "WMS Return RMA")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const ReturnRMAScreen1());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    };
    data['functions'][10] = () {
      if (widget.roles
              .where((element) => element.roleName == "WO PutAway")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const RMAPutawayScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    };
    data['functions'][11] = () {
      if (widget.roles
              .where((element) =>
                  element.roleName == "WMS Inventory by Bin Location")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const PhysicalInventoryByBinLocationScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    };
    data['functions'][12] = () {
      if (widget.roles
              .where((element) => element.roleName == "WO Journal Movement")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const JournalMovementScreen1());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    };
    data['functions'][13] = () {
      if (widget.roles
              .where((element) => element.roleName == "WO Journal Counting")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const PhysicalInventoryScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'This feature is not available yet.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    };
    data['functions'][14] = () {
      if (widget.roles
              .where((element) => element.roleName == "WO Journal ProfitLoss")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const ProfitAndLossScreen1());
      } else {
        Get.snackbar(
          'Access Denied',
          'This feature is not available yet.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    };
    data['functions'][15] = () {
      if (widget.roles
              .where((element) => element.roleName == "WO Re-Allocation Picked")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const ItemReAllocationScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'This feature is not available yet.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    };
    data['functions'][16] = () {
      Get.to(() => const UnAllocatedItemsScreen1());
    };
    data['functions'][17] = () {
      Get.to(() => const PalletIdInquiryScreen());
    };
    data['functions'][18] = () async {
      Get.offAll(() => const LoginScreen());
    };

    Future.delayed(
      Duration.zero,
      () {
        _showUserInfo();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // show a dialog when the back button is pressed
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FadeAnimation(
                        delay: 2,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Image.asset(
                            'assets/alessa.png',
                            width: 150,
                            height: 80,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          return await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Are you sure?'),
                              content: const Text('Do you want to exit an App'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text('Yes'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, top: 10),
                          child: Image.asset(
                            "assets/back_button.png",
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.black, thickness: 1),
                FadeAnimation(
                  delay: 1,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          child: Image.asset(
                            data["images"][index],
                            width: 50,
                            height: 50,
                          ),
                        ),
                        title: AutoSizeText(data["titles"][index]),
                        onTap: data["functions"][index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(color: Colors.black, thickness: 1);
                    },
                    itemCount: data["images"].length,
                  ),
                ),
                const Divider(color: Colors.black, thickness: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
