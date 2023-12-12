extension ActionBottomSheetTitle on String{
  String get toCapitalize{
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String get ringtoneTitle{
    if(isEmpty){
      return "Choose Your Ringtone";
    }else{
      return this;
    }
  }
}