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
     paragraph: "An online eye test project powered by the Hospital Authority(HA)."),
 OnBoardingData(
     title: "Comprehensive tests for your eyes",
     image: "assets/images/onboarding/slide2.png",
     paragraph: "With 4 tests to choose from, this application provides diagnosis for common ocular conditions ranging from visual acuity to myopia."),
 OnBoardingData(
     title: "Organized results for analysis",
     image: "assets/images/onboarding/slide3.png",
     paragraph: "After taking the tests, an immediate analysis on the results and diagnosis is provided.Users can track and monitor their ocular conditions over time."),

 OnBoardingData(
     title: "Professional advice at your fingertips",
     image: "assets/images/onboarding/slide4.png",
     paragraph: "All of these features embedded at the expense of a single application.Professional advice without the long waiting time at hospitals.")

];
