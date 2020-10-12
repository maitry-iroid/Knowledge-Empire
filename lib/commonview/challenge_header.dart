import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/BLoC/challenge_question_bloc.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';

class ChallengeHeader extends StatefulWidget {
  final bool isBtnVisible;
  final int challengeCount;
  final int currentIndex;

  ChallengeHeader({this.isBtnVisible, this.challengeCount, this.currentIndex});

  @override
  _ChallengeHeaderState createState() => new _ChallengeHeaderState();
}

class _ChallengeHeaderState extends State<ChallengeHeader> {
  int setColor = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: getChallengeQueBloc.getChallenge,
        builder:
            (context, AsyncSnapshot<List<QuestionCountWithData>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CommonView.showShimmer();
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData)
              return showData(snapshot?.data);
            else
              Container();
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Container();
        });
  }

  Widget showData(List<QuestionCountWithData> data) {
    Injector.countList = new List();
    Injector.countList = data;
    return Container(
      color: ColorRes.colorBgDark,
      height: Utils.getHeaderHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(Injector.countList.length, (index) {
                return Flexible(
                  child: Row(
                    children: <Widget>[
                      setStatusColor(index),
                      index == Injector.countList.length - 1
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(
                                  right: 5, left: 5, top: 8, bottom: 8),
                              child: Container(
                                height: 1,
                                width: 30,
                                color: Colors.white,
                              ),
                            )
                    ],
                  ),
                );
              }),
            ),
          ),
          widget.isBtnVisible != null && widget.isBtnVisible
              ? Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () {
                            if (setColor <= 0) {
                              setColor = Injector.countList.length;
                            }
                            setColor--;
                            Injector.countList.forEach(
                                (QuestionCountWithData yourCountWithData) =>
                                    yourCountWithData.color = Colors.blue);
                            Injector.countList[setColor].color = Colors.red;
                            setState(() {});
                          },
                          child: Text("previus"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () {
                            if (setColor == ((Injector.countList.length) - 1)) {
                              setColor = -1;
                            }
                            setColor++;
                            Injector.countList.forEach(
                                (QuestionCountWithData yourCountWithData) =>
                                    yourCountWithData.color = Colors.blue);
                            Injector.countList[setColor].color = Colors.green;
                            setState(() {});
                          },
                          child: Text("next"),
                        ),
                      ),
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }

  Widget setStatusColor(int index) {
    if (Injector.countList[index].isCorrect == null) {
      return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            color: widget.currentIndex == index
                ? ColorRes.blue
                : ColorRes.greyText,
            border: Border.all(
                color: widget.currentIndex == index
                    ? ColorRes.blue
                    : ColorRes.white),
            shape: BoxShape.circle),

        child: Center(
          child: Text((index + 1).toString(),
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: ColorRes.white)),
        ),
      );
    } else if (!Injector.countList[index].isCorrect) {
      return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            color: colorData(index, false),
            border: Border.all(
                color: widget.currentIndex == index
                    ? ColorRes.blue
                    : Colors.white),
            shape: BoxShape.circle),
        child: Icon(Icons.close, color: ColorRes.white),
      );
    } else if (Injector.countList[index].isCorrect) {
      return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            color: colorData(index, true),
            border: Border.all(
                color: widget.currentIndex == index
                    ? ColorRes.blue
                    : Colors.white),
            shape: BoxShape.circle),
        child: Icon(Icons.done, color: ColorRes.white),
      );
    } else {
      return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            color: ColorRes.blue,
            border: Border.all(color: Colors.white),
            shape: BoxShape.circle),
        child: Center(
          child: Text((index + 1).toString(),
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: ColorRes.white)),
        ),
      );
    }
  }

  Color colorData(int index, bool isForCorrect) {
    if (widget.currentIndex == index) {
      if (Injector.countList[index].isCorrect != null &&
          Injector.countList[index].isCorrect) {
        return isForCorrect ? ColorRes.greenDot : ColorRes.red;
      } else {
        return isForCorrect ? ColorRes.greenDot : ColorRes.red;
      }
    } else {
      return isForCorrect ? ColorRes.greenDot : ColorRes.red;
    }
  }
}

/*class QuestionCountWithData {
  int count;
  Color color;

  QuestionCountWithData(this.count, this.color);
}*/

class QuestionCountWithData {
  int questionIndex;
  bool isCorrect;
  Color color;

  QuestionCountWithData(this.color);

  QuestionCountWithData.fromJson(Map<String, dynamic> json) {
    questionIndex = json['questionIndex'];
    isCorrect = json['isCorrect'];
    if (isCorrect == null) {
      color = ColorRes.blue;
    } else if (isCorrect) {
      color = ColorRes.greyText;
    } else {
      color = ColorRes.red;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionIndex'] = this.questionIndex;
    data['isCorrect'] = this.isCorrect;
    return data;
  }
}
