import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/questions.dart';
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

  bool isLoading = false;

  showQueMedia(BuildContext context, Color borderColor, String answer, String thumbImage,
      {PDFDocument pdfDocument, bool isPdfLoading = false, String pdfFilePath, ChewieController chewieController, VideoPlayerController videoPlayerController, int videoPlay, int videoLoop}) {

    return InkResponse(

        onTap: () {
          performImageClick(context, answer, pdfFilePath: pdfFilePath, videoPlay: videoPlay, videoLoop: videoLoop);
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
                  child: showMediaView(context, answer, thumbImage, pdfDocument: pdfDocument, isPdfLoading: isPdfLoading, chewieController: chewieController, videoPlayerController: videoPlayerController, videoPlay: videoPlay, videoLoop: videoLoop)),
            ),
            showMediaExpandIcon(context, answer, pdfFilePath: pdfFilePath, videoPlay: videoPlay, videoLoop: videoLoop)
          ],
        ));
  }

  showMediaExpandIcon(BuildContext context, String link, {String pdfFilePath, int videoPlay, int videoLoop}) {
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
          showDialog(context: context, builder: (_) => ExpandMedia(pdfPath: pdfFilePath, link: link, videoPlay: videoPlay, videoLoop: videoLoop));
        },
      ),
    );
  }

  void performImageClick(BuildContext context, String link, {String pdfFilePath, int videoPlay, int videoLoop}) {
    Utils.playClickSound();
//    Utils.isImage(link)
//        ? showDialog(
//      context: context,
//      builder: (_) => ExpandMedia(link: link),
//    )
//        : Container();

    showDialog(
        context: context,
        builder: (_) => ExpandMedia(link: link, pdfPath: pdfFilePath, videoPlay: videoPlay, videoLoop: videoLoop));
  }

  showMediaView(BuildContext context, String path, String thumbImage,
      {PDFDocument pdfDocument, bool isPdfLoading = false, ChewieController chewieController, VideoPlayerController videoPlayerController, int videoPlay, int videoLoop}) {
    if(chewieController != null && (videoPlayerController?.value?.isInitialized ?? false) && Utils.isVideo(path)){
      return Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          height: Utils.getDeviceHeight(context) / 1.5,
          width: Utils.getDeviceWidth(context),
          decoration: BoxDecoration(
            color: ColorRes.white,
          ),
          child: Utils.isVideo(path) &&
              (videoPlayerController?.value?.isInitialized ?? false)
              ? Chewie(controller: chewieController) : Container(color: ColorRes.white,));
    }else{
      if (Utils.isImage(path) || Utils.isVideo(path)) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
//              child: Center(
//                  widthFactor: double.infinity,
//                  heightFactor: double.infinity,
//                  child: new Image.network(thumbImage,width:double.infinity,height:double.infinity, fit: BoxFit.fill,)
//              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(thumbImage,
                        scale: Const.imgScaleProfile,
                        cacheManager: Injector.cacheManager),
                    fit: BoxFit.cover,
                  )
              ),
            ),
            Utils.isVideo(path) ? Container(
              child: MaterialButton(
                height: 60,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => ExpandMedia(link: path, videoLoop: videoLoop, videoPlay: videoPlay));
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
      }else if (Utils.isPdf(path)) {
        return Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          padding: EdgeInsets.all(3),
          decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25))),
//        child: Utils.pdfShow(pdfPreviewPath, isPdfLoading),
          child: PDFViewer(document: pdfDocument, showPicker: false),
        );
      }
    }
  }

}

class ExpandMedia extends StatefulWidget {
  final String pdfPath;
  final String link;
  final int videoPlay;
  final int videoLoop;

  ExpandMedia({Key key, this.pdfPath, this.link, this.videoLoop, this.videoPlay}) : super(key: key);


  @override
  State<StatefulWidget> createState() => ExpandMediaState();
}

class ExpandMediaState extends State<ExpandMedia>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  PDFDocument document;
  bool isPdfLoading = true;

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

    if(Utils.isVideo(widget.link)){
      Injector.audioPlayerBg.stop();
      Future.delayed(Duration.zero, () async {
        await this.initVideoController(widget.link);
      });
    }

    if (Utils.isPdf(widget.link)) loadPdf();

  }

  Future<void> initVideoController(String link) async {
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
              widget.videoPlay == 1 ? _chewieController.play() : _chewieController.pause();
              widget.videoLoop == 1 ? _controller.setLooping(true) : _controller.setLooping(false);
            });
        });
      _controller.setVolume(Injector.isSoundEnable ? 1.0 : 0.0);
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

  Future<void> loadPdf() async {
    print("----------------  pdf path :: ${widget.link}");
    PDFDocument doc = await PDFDocument.fromURL(widget.link);
    await doc.get(page: 1);
    if(mounted){
      setState(() {
        this.document = doc;
        isPdfLoading = false;
      });
    }
  }

  bool checkimg = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Utils.playClickSound();
        if(Injector.isSoundEnable){
          Injector.audioPlayerBg.resume();
        }
        if(Utils.isVideo(widget.link)) {
          _chewieController.pause();
          _controller.pause();
        }
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Material(
            color: Colors.transparent,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
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
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            margin: EdgeInsets.only(
                                top: 0, bottom: 0, left: 0, right: 0),
                            height: Utils.getDeviceHeight(context) / 1.5,
                            width: Utils.getDeviceWidth(context),
                            decoration: BoxDecoration(
                              color: ColorRes.white,
                            ),
                            child: Utils.isVideo(widget.link) &&
                                (_controller?.value?.isInitialized ?? false)
                                ? Chewie(
                              controller: _chewieController,
                            )
                                : (Utils.isPdf(widget.link)
                                ? PDFViewer(document: document, showPicker: false,)
                                : Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: Utils.getCacheNetworkImage(
                                          widget.link),
                                      fit: BoxFit.cover)
                              ),)),
                          ),
                        ),
                        Positioned(
                            top: 0,
                            right: 10,
                            child: InkResponse(
                                onTap: () {
                                  Utils.playClickSound();
                                  if(Injector.isSoundEnable){
                                    Injector.audioPlayerBg.resume();
                                  }
                                  if(Utils.isVideo(widget.link)) {
                                    _chewieController.pause();
                                    _controller.pause();
                                  }
                                  Navigator.pop(context);
                                },
                                child: Container(
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
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}