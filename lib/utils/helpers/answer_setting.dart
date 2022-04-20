class AnswerSettingHelper {
  // 復習の間隔の繰り上がり条件
  static String intervalStepUpConditionText(int settingNumber) {
    String condition = '';
    switch (settingNumber) {
      case 1:
        condition = '正解する';
        break;
      case 2:
        condition = '2回連続で正解する';
        break;
      case 3:
        condition = '3回連続で正解する';
        break;
      case 4:
        condition = '4回連続で正解する';
        break;
      case 5:
        condition = '5回連続で正解する';
        break;
      default:
        condition = '正解する';
        break;
    }
    return condition;
  }

  // 復習解除条件
  static String reviewDeleteConditionText(int settingNumber) {
    String condition = '';
    switch (settingNumber) {
      case 0:
        condition = '翌日の復習で正解する';
        break;
      case 1:
        condition = '３日後の復習で正解する';
        break;
      case 2:
        condition = '１週間後の復習で正解する';
        break;
      case 3:
        condition = '２週間後の復習で正解する';
        break;
      case 4:
        condition = '３週間後の復習で正解する';
        break;
      case 5:
        condition = '１ヶ月後の復習で正解する';
        break;
      case 6:
        condition = '２ヶ月後の復習で正解する';
        break;
      case 7:
        condition = '３ヶ月後の復習で正解する';
        break;
      case 8:
        condition = '６ヶ月後の復習で正解する';
        break;
      case 9:
        condition = '１年後の復習で正解する';
        break;
      default:
        condition = '翌日の復習で正解する';
        break;
    }
    return condition;
  }

  // 復習通知時間
  static String reviewNotificationTimer(int settingNumber) {
    String condition = '';
    switch (settingNumber) {
      case 1:
        condition = '1:00 AM';
        break;
      case 2:
        condition = '2:00 AM';
        break;
      case 3:
        condition = '3:00 AM';
        break;
      case 4:
        condition = '4:00 AM';
        break;
      case 5:
        condition = '5:00 AM';
        break;
      case 6:
        condition = '6:00 AM';
        break;
      case 7:
        condition = '7:00 AM';
        break;
      case 8:
        condition = '8:00 AM';
        break;
      case 9:
        condition = '9:00 AM';
        break;
      case 10:
        condition = '10:00 AM';
        break;
      case 11:
        condition = '11:00 AM';
        break;
      case 12:
        condition = '12:00 PM';
        break;
      case 13:
        condition = '1:00 PM';
        break;
      case 14:
        condition = '2:00 PM';
        break;
      case 15:
        condition = '3:00 PM';
        break;
      case 16:
        condition = '4:00 PM';
        break;
      case 17:
        condition = '5:00 PM';
        break;
      case 18:
        condition = '6:00 PM';
        break;
      case 19:
        condition = '7:00 PM';
        break;
      case 20:
        condition = '8:00 PM';
        break;
      case 21:
        condition = '9:00 PM';
        break;
      case 22:
        condition = '10:00 PM';
        break;
      case 23:
        condition = '11:00 PM';
        break;
      default:
        condition = '';
        break;
    }
    return condition;
  }
}
