import 'package:flutter/material.dart';


class SliderModel{

  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath,this.title,this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("Have a problem with searching medical products?");
  sliderModel.setTitle("Welcome to Family Pharmacy");
  sliderModel.setImageAssetPath("assets/intro/onboard1.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("Upload Medicine presecription and Relax");
  sliderModel.setTitle("Add Products to your Cart");
  sliderModel.setImageAssetPath("assets/intro/onboard2.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("We will get you medical products at home");
  sliderModel.setTitle("Delivery at your Doorstep");
  sliderModel.setImageAssetPath("assets/intro/onboard3.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}