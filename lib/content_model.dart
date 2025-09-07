class UnbordingContent {
  String image;
  String title;
  String description;

  UnbordingContent(
      {required this.image, required this.title, required this.description});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Emotionally Balanced Living',
      image: 'images/Frame_1.svg',
      description:
          "Tailor soundscapes to uplift, relax, or soothe your varying moods. Experience emotional wellness."),
  UnbordingContent(
      title: 'CATER TO YOUR NEEDS',
      image: 'images/Frame_2.svg',
      description:
          "From focused study to tranquil sleep, find the perfect sound for every purpose."),
  UnbordingContent(
      title: 'SOUNDSCAPES ENVIRONMENT',
      image: 'images/Frame_3.svg',
      description:
          "Craft personalized surroundings with layered sounds. Customize your ambient experience."),
];
