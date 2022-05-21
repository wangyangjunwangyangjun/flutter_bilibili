String formatNum(double num,int position){
  if((num.toString().length-num.toString().lastIndexOf(".")-1)<position){
    //小数点后有几位小数
    return num.toStringAsFixed(position).substring(0,num.toString().lastIndexOf(".")+position+1).toString();
  }else{
    return num.toString().substring(0,num.toString().lastIndexOf(".")+position+1).toString();
  }
}