// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/common_view.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/manager/media_manager.dart';
import 'package:ke_employee/models/get_rewards.dart';
import 'package:ke_employee/models/redeem_reward.dart';
import 'package:video_player/video_player.dart';

VideoPlayerController _controller;
ChewieController _chewieController;

class RewardsPage extends StatefulWidget {
  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  List<RewardData> arrRewards = List();
  List<RewardData> arrFinalRewards = List();
  RewardData selectedModule = RewardData();
  int selectedIndex = 0;
  String _timeZone = "Unknown";

  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  String searchText = "";

  String _pdfPath = '';
  String _previewPath;
  var _pdfDocument;
  bool _isLoading = false;
  int _pageNumber = 1;

  @override
  void initState() {
    showDialogForCallApi();
    super.initState();

    Future.delayed(Duration.zero, () async {
      await this.getTimeZone();
    });
  }

  @override
  void dispose() {
    _controller?.pause();
    Injector.isSoundEnable && Injector.isBusinessMode ? Injector.performAudioAction(Const.resume) : Injector.performAudioAction(Const.stop);
    super.dispose();
  }

  Future getPDF(String url) async {
    if (selectedModule != null && url != null) {
      _pdfPath = url;
      // _pdfDocument = await PDFDocument.fromURL(url);
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> initVideoController(String link) async {
    await Injector.cacheManager.getFileFromCache(link).then((fileInfo) async {
      _controller = Utils.getCacheFile(link) != null
          ? VideoPlayerController.file(await Utils.getCacheFile(link).then((value) => value.file))
          : VideoPlayerController.network(link)
        ..initialize().then((_) {
          if (mounted)
            setState(() {
              _chewieController.play();
            });
        });
      _controller.setVolume(Injector.isSoundEnable ? 1.0 : 0.0);
      questionData.videoLoop == 1 ? _controller.setLooping(true) : _controller.setLooping(false);
      _chewieController = ChewieController(
          videoPlayerController: _controller,
          allowFullScreen: false,
          materialProgressColors: ChewieProgressColors(playedColor: ColorRes.header, handleColor: ColorRes.blue),
          cupertinoProgressColors: ChewieProgressColors(playedColor: ColorRes.header, handleColor: ColorRes.blue),
          looping: true);
    });
  }

  getTimeZone() async {
    String timezone = Utils.initPlatformState();
    if (!mounted) return;

    setState(() {
      this._timeZone = timezone;
    });
  }

  Future showDialogForCallApi() async {
    await Future.delayed(Duration(milliseconds: 50));

    if (Injector.introData != null && Injector.introData.reward2 == 0) await DisplayDialogs.showIntroRewards(context);

    Utils.isInternetConnectedWithAlert(context).then((isConnected) {
      fetchRewardsModules();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CommonView.showBackground(context),
        Padding(
          padding: EdgeInsets.only(top: Utils.getHeaderHeight(context)),
          child: Row(
            children: <Widget>[
              showFirstHalf(),
              Expanded(
                flex: 1,
                child: Injector.isBusinessMode
                    ? Card(
                        color: Colors.transparent,
                        elevation: 20,
                        child: showSecondHalf(context),
                      )
                    : showSecondHalf(context),
              )
            ],
          ),
        ),
        CommonView.showLoderView(isLoading)
      ],
    );
  }

  showFirstHalf() {
    return Expanded(
      flex: 1,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 10),
          CommonView.showTitle(context, StringRes.rewards),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.only(left: 20, right: 10, top: 2, bottom: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Container(
                        height: 33,
                        padding: EdgeInsets.only(top: 13, left: 10),
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: ColorRes.white),
                        child: Theme(
                            data: ThemeData(accentColor: ColorRes.colorPrimary),
                            child: TextField(
                                onChanged: (text) {
                                  arrFinalRewards.clear();
                                  searchText = text;

                                  if (mounted)
                                    setState(() {
                                      if (text.isEmpty) {
                                        arrFinalRewards.addAll(arrRewards);
                                      } else {
                                        searchData();
                                      }
                                    });
                                },
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                controller: searchController,
                                style: TextStyle(fontSize: 16, color: ColorRes.hintColor),
                                decoration: InputDecoration(
                                    hintText: Utils.getText(context, StringRes.searchForKeywords),
                                    hintStyle: TextStyle(color: ColorRes.hintColor),
                                    border: InputBorder.none))))),
                SizedBox(
                  width: 5,
                ),
                Image(
                    height: 35,
                    image: AssetImage(
                      Utils.getAssetsImg(Injector.isBusinessMode ? "search" : 'search_prof'),
                    ),
                    fit: BoxFit.fill)
              ],
            ),
          ),
          showSubHeader(),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: arrFinalRewards.length,
            itemBuilder: (BuildContext context, int index) {
              return showItem(index);
            },
          )
        ],
      ),
    );
  }

  showSecondHalf(BuildContext context) {
    return Container(
      color: Injector.isBusinessMode ? null : Color(0xFFeaeaea),
      child: ListView(
        children: <Widget>[showImageView(context), showDescriptionView(), showDownloadSubscribeOptions()],
      ),
    );
  }

  Container showSubHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.only(left: 20, right: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
          borderRadius: Injector.isBusinessMode ? null : BorderRadius.circular(20),
          image: Injector.isBusinessMode ? DecorationImage(image: AssetImage(Utils.getAssetsImg("business_sec_header")), fit: BoxFit.fill) : null),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Text(
              Utils.getText(context, StringRes.rewards),
              style: TextStyle(color: ColorRes.white, fontSize: 17),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Utils.getText(context, StringRes.points),
              style: TextStyle(color: ColorRes.white, fontSize: 17),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  showDownloadSubscribeOptions() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[showDetailView(), showRedeemView()],
      ),
    );
  }

  showDetailView() {
    if ((selectedModule?.points ?? "") != "" && (selectedModule?.leftUnits ?? "") != "") {
      return Padding(
          padding: EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Utils.getText(context, StringRes.costReward) +
                    " : " +
                    selectedModule.points.toString() +
                    "  " +
                    Utils.getText(context, StringRes.costUnit),
                style: TextStyle(color: Injector.isBusinessMode ? ColorRes.white : ColorRes.blue, fontSize: 17),
              ),
              SizedBox(height: 10),
              Text(
                Utils.getText(context, StringRes.unitsLeft) + " : " + selectedModule.leftUnits.toString(),
                style: TextStyle(color: Injector.isBusinessMode ? ColorRes.white : ColorRes.blue, fontSize: 17),
              ),
              SizedBox(height: 10),
            ],
          ));
    } else {
      return Container();
    }
  }

  showRedeemView() {
    return InkResponse(
        child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 50),
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Injector.isBusinessMode
                    ? null
                    : selectedModule.isRedeem == 0
                        ? ColorRes.greyText
                        : ColorRes.headerBlue,
                borderRadius: Injector.isBusinessMode ? null : BorderRadius.circular(20),
                image: Injector.isBusinessMode
                    ? DecorationImage(
                        image: AssetImage(Utils.getAssetsImg(selectedModule.isRedeem == 0 ? "bg_disable_subscribe" : "bg_subscribe")),
                        fit: BoxFit.fill)
                    : null),
            child: Text(
              Utils.getText(context, StringRes.redeem),
              style: TextStyle(color: ColorRes.white, fontSize: 20),
              textAlign: TextAlign.center,
            )),
        onTap: () {
          Utils.playClickSound();
          if (selectedModule.isRedeem == 1) {
            this.callRedeemApi();
          }
        });
  }

  callRedeemApi() {
    Utils.isInternetConnectedWithAlert(context).then((_) {
      RedeemRewardRequest rq = RedeemRewardRequest();
      rq.userId = Injector.userData.userId.toString();
      rq.rewardId = selectedModule.rewardId.toString();
      rq.timezone = this._timeZone;

      if (mounted)
        setState(() {
          isLoading = true;
        });

      WebApi().callAPI(WebApi.rqRedeemReward, rq.toJson()).then((data) {
        this.fetchRewardsModules();
        Utils.callCustomerValuesApi();
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }).catchError((e) {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        // Utils.showToast(e.toString());
      });
    });
  }

  Widget showItem(int index) {
    return InkResponse(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 20, right: 10),
        padding: EdgeInsets.only(top: 6, bottom: 6, left: 8),
        decoration: BoxDecoration(
            image: (selectedModule.rewardId == arrFinalRewards[index].rewardId)
                ? DecorationImage(image: AssetImage(Utils.getAssetsImg(Injector.isBusinessMode ? "bs_bg" : "bg_bs_prof")), fit: BoxFit.fill)
                : null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 9,
              child: Container(
                height: Injector.isBusinessMode ? 33 : 35,
                margin: EdgeInsets.only(top: Injector.isBusinessMode ? 2 : 0),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Injector.isBusinessMode ? null : ColorRes.white,
                    borderRadius: Injector.isBusinessMode ? null : BorderRadius.circular(20),
                    image: Injector.isBusinessMode
                        ? DecorationImage(image: AssetImage(Utils.getAssetsImg("bg_bus_sector_item")), fit: BoxFit.fill)
                        : null),
                child: AutoSizeText(
                  arrFinalRewards[index].reward,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  minFontSize: 7,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Injector.isBusinessMode ? ColorRes.blue : ColorRes.textProf,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                height: 30,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 5, right: 10, top: 2, bottom: 2),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                    color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                    borderRadius: Injector.isBusinessMode ? null : BorderRadius.circular(20),
                    image: Injector.isBusinessMode ? DecorationImage(image: AssetImage(Utils.getAssetsImg("value")), fit: BoxFit.fill) : null),
                child: Text(
                  arrFinalRewards[index].points.toString(),
                  style: TextStyle(
                    color: ColorRes.white,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Utils.playClickSound();

        if (mounted)
          setState(() {
            selectedModule = arrFinalRewards[index];
            selectedIndex = index;
            _controller?.pause();

            if (Utils.isPdf(selectedModule.media)) {
              Future.delayed(Duration.zero, () async {
                await this.getPDF(selectedModule.media);
              });
            }

            if (Utils.isVideo(selectedModule.media)) {
              Injector.performAudioAction(Const.stop);
              Future.delayed(Duration.zero, () async {
                await this.initVideoController(selectedModule.media);
              });
            }
          });
      },
    );
  }

  showImageView(BuildContext context) {
    if ((selectedModule?.media ?? "") != "" && (selectedModule?.mediaThumb ?? "") != "") {
      if (Utils.isPdf(selectedModule?.media)) {
        return Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: MediaManager().showQueMedia(context, ColorRes.white, selectedModule.media, selectedModule.mediaThumb,
              pdfDocument: _pdfDocument, isPdfLoading: _isLoading, pdfFilePath: selectedModule.media),
        );
      } else if (Utils.isVideo(selectedModule?.media)) {
        return Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: MediaManager().showQueMedia(context, ColorRes.white, selectedModule.media, selectedModule.mediaThumb,
              videoPlayerController: _controller, chewieController: _chewieController),
        );
      } else {
        return Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: MediaManager().showQueMedia(context, ColorRes.white, selectedModule.media, selectedModule.mediaThumb),
        );
      }
    } else {
      return Container();
    }
  }

  showDescriptionView() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Injector.isBusinessMode ? ColorRes.whiteDarkBg : ColorRes.white,
            margin: EdgeInsets.only(top: 20),
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10),
              decoration: BoxDecoration(
                color: Injector.isBusinessMode ? ColorRes.bgDescription : ColorRes.white,
                borderRadius: BorderRadius.circular(12),
                border: Injector.isBusinessMode ? Border.all(color: ColorRes.white, width: 1) : null,
              ),
              child: SingleChildScrollView(
                child: Text(
                  selectedModule.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Injector.isBusinessMode ? ColorRes.white : ColorRes.textProf, fontSize: 17),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: Injector.isBusinessMode ? 3 : 5, left: Utils.getDeviceWidth(context) / 9, right: Utils.getDeviceWidth(context) / 9),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                  borderRadius: BorderRadius.circular(20),
                  image: Injector.isBusinessMode ? DecorationImage(image: AssetImage(Utils.getAssetsImg("bg_blue")), fit: BoxFit.fill) : null),
              child: Text(
                Utils.getText(context, StringRes.description),
                style: TextStyle(color: ColorRes.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void fetchRewardsModules() async {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    GetRewardRequest rq = GetRewardRequest();
    rq.userId = Injector.userId;

    WebApi().callAPI(WebApi.rqGetRewards, rq.toJson()).then((data) async {
      if (mounted)
        setState(() {
          isLoading = false;
        });

      if (data != null) {
        List<RewardData> arrData = new List<RewardData>();

        int i = 0;
        data.forEach((v) {
          RewardData module = RewardData.fromJson(v);
//          module.index = i;
          arrData.add(module);
          i++;
        });

//        saveModulesLocally(arrData);

        if (mounted)
          setState(() {
            arrRewards.clear();
            arrFinalRewards.clear();

            arrRewards.addAll(arrData);
            arrFinalRewards.addAll(arrData);

            if (arrRewards.length > 0) {
              selectedModule = arrRewards[selectedIndex];
              if (Utils.isPdf(selectedModule.media)) {
                Future.delayed(Duration.zero, () async {
                  await this.getPDF(selectedModule.media);
                });
              }

              if (Utils.isVideo(selectedModule.media)) {
                Injector.performAudioAction(Const.stop);
                Future.delayed(Duration.zero, () async {
                  await this.initVideoController(selectedModule.media);
                });
              }
            }
          });
      }
    }).catchError((e) {
      print("getRewards_" + e.toString());
      if (mounted)
        setState(() {
          isLoading = false;
        });
      // Utils.showToast(e.toString());
    });
  }

  void searchData() {
    var data = arrRewards.where((module) => module.reward.toLowerCase().contains(searchText.toLowerCase())).toList();

    arrFinalRewards.addAll(data);
  }
}
