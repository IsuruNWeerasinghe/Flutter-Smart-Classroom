import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PhonicsSongScreen extends StatefulWidget {
  static const String routeName = '/phonics_song_page';
  const PhonicsSongScreen({Key? key}) : super(key: key);

  @override
  _PhonicsSongScreenState createState() => _PhonicsSongScreenState();
}

class _PhonicsSongScreenState extends State<PhonicsSongScreen>{
  late YoutubePlayerController youtubePlayerController;

  @override
  void initState() {
    super.initState();
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: 'ryss1kT9RZc',
      flags: const YoutubePlayerFlags(
        hideControls: false,
        loop: true,
        controlsVisibleAtStart: false,
        autoPlay: true,
        mute: false,
      ),
    );

  }

  @override
  void dispose() {
    youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BackgroundImage(
      topMargin: 0.0,
      pageTitle: AppStrings.phonics_song,
      width: size.width,
      height: size.height,
      isActiveAppBar: true,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height * 0.75,
            alignment: Alignment.bottomCenter,
            //margin: EdgeInsets.only(top: size.height * 0.01, bottom: size.height * 0.01),
            padding: EdgeInsets.only(top: size.height * 0.16),
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.center,
                image: AssetImage(
                  "assets/images/alphabet/video_bg.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: <Widget>[
                YoutubePlayer(
                  controller: youtubePlayerController,
                  width: size.width * 0.98,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: AppColors.blue,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

}


/*YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: 'ryss1kT9RZc', //Add videoID.
                    flags: YoutubePlayerFlags(
                      hideControls: false,
                      controlsVisibleAtStart: true,
                      autoPlay: true,
                      mute: false,
                    ),
                  ),
                  width: size.width * 0.7,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: AppColors.blue,
                ),*/