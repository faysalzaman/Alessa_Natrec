class GetPackingSlipTableClByItemIdAndPackingSlipIdModel {
  String? sALESID;
  String? iTEMID;
  String? nAME;
  String? iNVENTLOCATIONID;
  String? cONFIGID;
  num? oRDERED;
  String? pACKINGSLIPID;
  String? vEHICLESHIPPLATENUMBER;
  String? dATETIMECREATED;
  String? aSSIGNEDUSERID;
  String? iTEMSERIALNO;

  GetPackingSlipTableClByItemIdAndPackingSlipIdModel(
      {this.sALESID,
      this.iTEMID,
      this.nAME,
      this.iNVENTLOCATIONID,
      this.cONFIGID,
      this.oRDERED,
      this.pACKINGSLIPID,
      this.vEHICLESHIPPLATENUMBER,
      this.dATETIMECREATED,
      this.aSSIGNEDUSERID,
      this.iTEMSERIALNO});

  GetPackingSlipTableClByItemIdAndPackingSlipIdModel.fromJson(
      Map<String, dynamic> json) {
    sALESID = json['SALESID'];
    iTEMID = json['ITEMID'];
    nAME = json['NAME'];
    iNVENTLOCATIONID = json['INVENTLOCATIONID'];
    cONFIGID = json['CONFIGID'];
    oRDERED = json['ORDERED'];
    pACKINGSLIPID = json['PACKINGSLIPID'];
    vEHICLESHIPPLATENUMBER = json['VEHICLESHIPPLATENUMBER'];
    dATETIMECREATED = json['DATETIMECREATED'];
    aSSIGNEDUSERID = json['ASSIGNEDUSERID'];
    iTEMSERIALNO = json['ITEMSERIALNO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SALESID'] = sALESID;
    data['ITEMID'] = iTEMID;
    data['NAME'] = nAME;
    data['INVENTLOCATIONID'] = iNVENTLOCATIONID;
    data['CONFIGID'] = cONFIGID;
    data['ORDERED'] = oRDERED;
    data['PACKINGSLIPID'] = pACKINGSLIPID;
    data['VEHICLESHIPPLATENUMBER'] = vEHICLESHIPPLATENUMBER;
    data['DATETIMECREATED'] = dATETIMECREATED;
    data['ASSIGNEDUSERID'] = aSSIGNEDUSERID;
    data['ITEMSERIALNO'] = iTEMSERIALNO;
    return data;
  }
}
