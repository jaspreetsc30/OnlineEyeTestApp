class OnBoardingData {
  final String title ;
   final String image ;
   final String paragraph ;

   OnBoardingData({
    required this.title,
    required this.image,
    required this.paragraph
});
}

List <OnBoardingData> OnBoardingDataList = [
 OnBoardingData(
     title: "Welcome to the Online Eye Test",
     image: "assets/images/onboarding/slide1.png",
     paragraph: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tincidunt pharetra sed malesuada auctor convallis aliquet. Urna nisi lectus morbi eu et sit id faucibus enim."),
 OnBoardingData(
     title: "Comprehensive tests for your eyes",
     image: "assets/images/onboarding/slide2.png",
     paragraph: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tincidunt pharetra sed malesuada auctor convallis aliquet. Urna nisi lectus morbi eu et sit id faucibus enim."),
 OnBoardingData(
     title: "Organized results for analysis",
     image: "assets/images/onboarding/slide3.png",
     paragraph: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tincidunt pharetra sed malesuada auctor convallis aliquet. Urna nisi lectus morbi eu et sit id faucibus enim."),

 OnBoardingData(
     title: "Professional advice at your fingertips",
     image: "assets/images/onboarding/slide4.png",
     paragraph: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tincidunt pharetra sed malesuada auctor convallis aliquet. Urna nisi lectus morbi eu et sit id faucibus enim.")

];
