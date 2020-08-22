import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/questions.dart';
import 'package:pdf_previewer/pdf_previewer.dart';
import 'package:video_player/video_player.dart';

VideoPlayerController _controller;
ChewieController _chewieController;
QuestionData questionData = QuestionData();

class MediaManager{

  static final MediaManager _singleton = MediaManager._internal();

  factory MediaManager() {
    return _singleton;
  }

  MediaManager._internal();

  String _pdfPath = '';
  String _previewPath;
  bool isLoading = false;

  showQueMedia(BuildContext context, Color borderColor, String answer, String thumbImage, {String pdfPreviewPath = "", bool isPdfLoading = false, String pdfFilePath}) {

    return InkResponse(
        onTap: () {
//          Utils.playClickSound();
          performImageClick(context, answer, pdfFilePath: pdfFilePath);
        },
        child: Stack(
          children: <Widget>[
            Card(
              elevation: 5,
              color: ColorRes.transparent.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.only(top: 15, bottom: 10, right: 15, left: 10),
              child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 2.5,
                  alignment: Alignment.center,
                  padding:
                  EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: borderColor, width: 3)),
                  child: showMediaView(context, answer, thumbImage, pdfPreviewPath: pdfPreviewPath, isPdfLoading: isPdfLoading)),
            ),
            showMediaExpandIcon(context, answer, pdfFilePath: pdfFilePath)
          ],
        ));
  }

  showMediaExpandIcon(BuildContext context, String link, {String pdfFilePath}) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: InkResponse(
        child: Container(
            alignment: Alignment.center,
            height: Utils.getDeviceWidth(context) / 20,
            width: Utils.getDeviceWidth(context) / 20,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Injector.isBusinessMode
                        ? Utils.getAssetsImg("full_expand_question_answers")
                        : Utils.getAssetsImg("expand_pro")),
                    fit: BoxFit.fill))),
        onTap: () {
          Utils.playClickSound();
          showDialog(context: context, builder: (_) => ExpandMedia(pdfPath: pdfFilePath, link: link));
        },
      ),
    );
  }

  void performImageClick(BuildContext context, String link, {String pdfFilePath}) {
    Utils.playClickSound();
//    Utils.isImage(link)
//        ? showDialog(
//      context: context,
//      builder: (_) => ExpandMedia(link: link),
//    )
//        : Container();

    showDialog(
        context: context,
        builder: (_) => ExpandMedia(link: link, pdfPath: pdfFilePath,));
  }

  showMediaView(BuildContext context, String path, String thumbImage, {String pdfPreviewPath = "", bool isPdfLoading = false}) {
    if (Utils.isImage(path) || Utils.isVideo(path)) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(thumbImage ,
                      scale: Const.imgScaleProfile,
                      cacheManager: Injector.cacheManager),
                  fit: BoxFit.cover,
                )),
          ),
          Utils.isVideo(path) ? Container(
            child: MaterialButton(
              height: 60,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => ExpandMedia(link: path));
              },
              child: Container(
                width: Utils.getDeviceHeight(context) / 10,
                height: Utils.getDeviceHeight(context) / 10,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Utils.getAssetsImg("play_button")),
                        fit: BoxFit.scaleDown)),
              ),
            ),
          ) : Container()
        ],
      ) ;

    }/*else if (Utils.isVideo(path)) {
      print("IsVideo true ++++++++++++++++++");
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            child: Chewie(
              controller: _chewieController,
            ),
          ),
          Container(
            child: MaterialButton(
              height: 100,
              color: Colors.red,
              onPressed: () {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              },
              child: Container(
                width: Utils.getDeviceHeight(context) / 7,
                height: Utils.getDeviceHeight(context) / 7,
                decoration: BoxDecoration(
                    color: Colors.green,
                    image: DecorationImage(
                        image: AssetImage(
                          _controller.value.isPlaying
                              ? Utils.getAssetsImg("") //add_emp_check
                              : Utils.getAssetsImg("play_button"),
                        ),
                        fit: BoxFit.scaleDown)),
              ),
            ),
          )
        ],
      );
    }*/ else if (Utils.isPdf(path)) {
      return Container(
        padding: EdgeInsets.all(3),
        decoration:
        BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Utils.pdfShow(pdfPreviewPath, isPdfLoading),
      );
    }
  }

}

class ExpandMedia extends StatefulWidget {
  final String pdfPath;
  final String link;
  ExpandMedia({Key key, this.pdfPath, this.link}) : super(key: key);


  @override
  State<StatefulWidget> createState() => ExpandMediaState();
}

class ExpandMediaState extends State<ExpandMedia>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  String _pdfPath = '';
  String _previewPath;
  bool _isLoading = false;
  int _pageNumber = 1;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();

    Future.delayed(Duration.zero, () async {
      await this.initVideoController(widget.link);
    });

    if (Utils.isPdf(widget.link)) getPdf();
  }

  Future<void> initVideoController(String link) async {
    if (Utils.isVideo(link)) {
      await Injector.cacheManager
          .getFileFromCache(link)
          .then((fileInfo) {
        _controller = Utils.getCacheFile(link) != null
            ? VideoPlayerController.file(
            Utils
                .getCacheFile(link)
                .file)
            : VideoPlayerController.network(link)
          ..initialize().then((_) {
            if (mounted)
              setState(() {
                _chewieController.play();
              });
          });
        _controller.setVolume(Injector.isSoundEnable ? 1.0 : 0.0);
        questionData.videoLoop == 1
            ? _controller.setLooping(true)
            : _controller.setLooping(false);
        _chewieController = ChewieController(
            videoPlayerController: _controller,
//            autoPlay: true,
            allowFullScreen: false,
            materialProgressColors: ChewieProgressColors(playedColor: ColorRes.header, handleColor: ColorRes.blue),
            cupertinoProgressColors: ChewieProgressColors(playedColor: ColorRes.header, handleColor: ColorRes.blue),
            looping: true);
        print("========================= video controller initialized =================");
      });
    }
  }

  Future getPdf() async {
    _pdfPath = widget.pdfPath;
    _previewPath = await PdfPreviewer.getPagePreview(filePath: _pdfPath, pageNumber: _pageNumber);
    setState(() {
      _isLoading = false;
    });
  }

  bool checkimg = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Stack(
                  fit: StackFit.loose,
                  alignment: Alignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      margin: EdgeInsets.only(
                          top: 35, bottom: 15, right: 25, left: 25),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 0, bottom: 0, left: 0, right: 0),
                        height: Utils.getDeviceHeight(context) / 1.5,
                        decoration: BoxDecoration(
                          color: Injector.isBusinessMode
                              ? ColorRes.black
                              : ColorRes.white,
                          image: Utils.isImage(widget.link)
                              ? DecorationImage(
                              image: Utils.getCacheNetworkImage(
                                  widget.link),
                              fit: BoxFit.cover)
                              : null,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Utils.isVideo(widget.link) &&
                            (_controller?.value?.initialized ?? false)
                            ? Chewie(
                          controller: _chewieController,
                        )
                            : (Utils.isPdf(widget.link)
                            ? Utils.pdfShow(_previewPath, _isLoading)
                            : null),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkResponse(
                          onTap: () {
                            Utils.playClickSound();
                            Navigator.pop(context);
                          },
                          child: (checkimg == true
                              ? Container(
                              alignment: Alignment.center,
                              height: Utils.getDeviceWidth(context) / 30,
                              width: Utils.getDeviceWidth(context) / 30,
                              decoration: BoxDecoration(
                                  image:
                                  DecorationImage(
                                      image: AssetImage(
                                          Utils.getAssetsImg(
                                              "close_dialog")),
                                      fit: BoxFit.contain)
                              ))
                              : Container(
                              alignment: Alignment.center,
                              height: Utils.getDeviceWidth(context) / 30,
                              width: Utils.getDeviceWidth(context) / 30,
                              decoration: BoxDecoration(
                                  image:
                                  DecorationImage(
                                      image: AssetImage(
                                          Utils.getAssetsImg(
                                              "close_dialog")),
                                      fit: BoxFit.contain)
                              )))),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}