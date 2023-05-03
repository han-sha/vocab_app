import "package:flutter/material.dart";
import "../UI/palette_colors.dart";


Color getColor(String theme, String level){
  Color rst;
  switch(theme) {
    case "red":
      rst = _getRed(level);
      break;
    case "blue":
      rst = _getBlue(level);
      break;
  }
  return rst;
}

Color getPageButtonColor(String theme){
  Color rst;
  switch(theme){
    case "blue":
      rst = blueHomePageButton;
      break;
  }

  return rst;
}


Color _getRed(String level){
  Color rst;
  switch(level){
    case "1":
      rst = redPrimary1;
      break;
    case "2":
      rst =  redPrimary2;
  }
  return rst;
}


Color _getBlue(String level){
  Color rst;
  switch(level){
    case "1":
      rst = blue1;
      break;
    case "2":
      rst =  blue2;
      break;
    case "3":
      rst =  blue3;
      break;
    case "4":
      rst =  blue4;
      break;
    case "5":
      rst =  blue5;
      break;
    case "6":
      rst =  blue6;
      break;
    case "7":
      rst =  blue7;
      break;
    case "8":
      rst =  blue8;
      break;
    case "9":
      rst =  blue9;
      break;
    case "learn1":
      rst =  blueLearn1;
      break;
    case "learn2":
      rst =  blueLearn2;
  }
  return rst;
}



Color getExpandedBubbleColor(String theme){
  Color rst;
  switch(theme){
    case "blue":
      rst = blueExpandedBubbleColor;
      break;
  }

  return rst;
}


Color getOpenBubbleColor(String theme){
  Color rst;
  switch(theme){
    case "blue":
      rst = blueOpenBubbleColor;
      break;
  }
  return rst;
}
