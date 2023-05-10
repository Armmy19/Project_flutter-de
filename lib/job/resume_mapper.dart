String graduation_maper_reverse(String value) {
  switch (value) {
    case '1':
      return 'ไม่มีวุฒิการศึกษา';
    case '2':
      return 'ระดับ ประถมศึกษา';
    case '3':
      return 'ระดับ มัธยมศึกษา';
    case '4':
      return 'ระดับ ปวช.';
    case '5':
      return 'ระดับ ปวส.';
    case '6':
      return 'ระดับ ปริญญาตรี';
    case '7':
      return 'ระดับ ปริญญาโท';
    case '8':
      return 'ระดับ ปริญญาเอก';
    default:
      return value;
  }
}

String type_interested_maper(String value) {
  switch (value) {
    case 'ช่างซ่อม':
      return '1';
    case 'งานโรงงาน/ฝ่ายการผลิต/ควบคุมคุณภาพ':
      return '2';
    case 'โปรแกรมเมอร์':
      return '3';
    case 'ออกแบบกราฟฟิก/3D/ตัดต่อวิดีโอ':
      return '4';
    case 'สื่อสารสนเทศ/นักเขียน/พิสูจน์อักษร/นักแปลภาษา':
      return '5';
    case 'งานบริการลูกค้า/งานขาย/งานขนส่ง':
      return '6';
    case 'การเงินการบัญชี':
      return '7';
    case 'งานเอกสารและธุรการ':
      return '8';
    case 'คอร์สสอน/ครู/อาจารย์':
      return '9';
    case 'ล่าม/มัคคุเทศก์':
      return '10';
    case 'Freelance/Part-time':
      return '11';
    default:
      return '0';
  }
}

String type_interested_maper_reverse(String value) {
  switch (value) {
    case '1':
      return 'ช่างซ่อม';
    case '2':
      return 'งานโรงงาน/ฝ่ายการผลิต/ควบคุมคุณภาพ';
    case '3':
      return 'โปรแกรมเมอร์';
    case '4':
      return 'ออกแบบกราฟฟิก/3D/ตัดต่อวิดีโอ';
    case '5':
      return 'สื่อสารสนเทศ/นักเขียน/พิสูจน์อักษร/นักแปลภาษา';
    case '6':
      return 'งานบริการลูกค้า/งานขาย/งานขนส่ง';
    case '7':
      return 'การเงินการบัญชี';
    case '8':
      return 'งานเอกสารและธุรการ';
    case '9':
      return 'คอร์สสอน/ครู/อาจารย์';
    case '10':
      return 'ล่าม/มัคคุเทศก์';
    case '11':
      return 'Freelance/Part-time';
    default:
      return value;
  }
}

String graduation_maper(String value) {
  switch (value) {
    case 'ไม่มีวุฒิการศึกษา':
      return '1';
    case 'ระดับ ประถมศึกษา':
      return '2';
    case 'ระดับ มัธยมศึกษา':
      return '3';
    case 'ระดับ ปวช.':
      return '4';
    case 'ระดับ ปวส.':
      return '5';
    case 'ระดับ ปริญญาตรี':
      return '6';
    case 'ระดับ ปริญญาโท':
      return '7';
    case 'ระดับ ปริญญาเอก':
      return '8';
    default:
      return '0';
  }
}
