String formatNum(double num,int position){
  if((num.toString().length-num.toString().lastIndexOf(".")-1)<position){
    //小数点后有几位小数
    return num.toStringAsFixed(position).substring(0,num.toString().lastIndexOf(".")+position+1).toString();
  }else{
    return num.toString().substring(0,num.toString().lastIndexOf(".")+position+1).toString();
  }
}
String  changeToWan(int num) {
  return num.toDouble() > 10000
      ? formatNum(num.toDouble() / 10000, 1) + "万"
      : formatNum(num.toDouble(), -1);
}
String getPubDataText(int duration) {
  var startDate = DateTime(1970, 1, 1, 0, 0, 0);
  var endData = startDate.add(Duration(seconds: duration.toInt()));
  var endDataText = endData.toString();
  return endData.toString().substring(0, endDataText.length - 4);
}
String changeToDurationText(double duration) {
  if(duration > 60) {
    if(duration > 3600) {
      var hours = duration ~/ 3600;
      var minutes = (duration - hours * 3600) ~/ 60;
      var seconds = (duration - hours * 3600 - minutes * 60).toInt();
      return hours.toString() + minutes.toString().padLeft(2, '0') + seconds.toString().padLeft(2, '0');
    }else{
      var minutes = duration ~/ 60;
      var seconds = (duration - minutes * 60).toInt();
      return minutes.toString() + ":" + seconds.toString().padLeft(2, '0');
    }
  }else{
    return "0:" + duration.toInt().toString().padLeft(2, '0');
  }
}