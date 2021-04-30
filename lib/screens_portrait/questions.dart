import 'package:flutter/material.dart';
import 'package:ke_employee/baseController/base_button.dart';
import 'package:ke_employee/baseController/base_text.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/manager/screens_manager.dart';
import 'package:ke_employee/manager/theme_manager.dart';


class QuestionsPagePortrait extends StatefulWidget {
  @override
  _QuestionsPagePortraitState createState() => _QuestionsPagePortraitState();
}

class _QuestionsPagePortraitState extends State<QuestionsPagePortrait> {

  List<bool> _selected = List.generate(4, (i) => false);
  bool isSnackBarVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils().showAppBarWithDrawer(ScreensManager().bottomNavigationPortraitState.context, BottomItems.questions),
      body: SingleChildScrollView(
        child: Container(
          color: ThemeManager().getBgGradientLight(),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showCorrectIncorrectSnackBar(),
              showCardView(),
              showIntroductionText(),
              showSelectTheRightOption(),
              Divider(height: 1, thickness: 1),
              showOptionsList(),
              showSubmitButton(),
              showExplanationText(),
              showNextQuestionButton(),
            ],
          ),
        ),
      ),
    );
  }

  showCorrectIncorrectSnackBar() {
    return Visibility(
        visible: isSnackBarVisible,
        child: Container(
          width: Utils.getDeviceWidth(context),
          height: 44,
          color: ThemeManager().getStaticGradientColor(),
          alignment: Alignment.center,
          child: BaseText(
              text: "Correct!",
              textColor: ThemeManager().getDarkColor(),
              fontSize: 14,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center),
        ));
  }

  showNextQuestionButton() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      width: Utils.getDeviceWidth(context),
      child: BaseRaisedButton(
        buttonText: "Next question",
        onPressed: (){},
        buttonColor: ThemeManager().getHeaderColor(),
        textColor: ThemeManager().getLightColor(),
        borderColor: ThemeManager().getDarkColor(),
      ),
    );
  }

  showSubmitButton() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
      width: Utils.getDeviceWidth(context),
      child: BaseRaisedButton(
        buttonText: "Submit",
        onPressed: (){
          Utils.showAlertDialog(context);
//          setState(() {
//            isSnackBarVisible = !isSnackBarVisible;
//            Timer(Duration(seconds: 2), (){
//              isSnackBarVisible = false;
//              setState(() {});
//            });
//          });
        },
        buttonColor: ThemeManager().getHeaderColor(),
        textColor: ThemeManager().getLightColor(),
        borderColor: ThemeManager().getDarkColor(),
      ),
    );
  }

  showOptionsList() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        itemCount: 4,
        itemBuilder: (context, index){
          return showMediaOption(index);
        });
  }

  showMediaOption(int index){
    return InkResponse(
      onTap: () {
        setState(() => _selected[index] = !_selected[index]);
      },
      child: Container(
        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
        decoration: BoxDecoration(
            color: _selected[index] ? ThemeManager().getBgGradientDark() : ThemeManager().getBgGradientLight()
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Row(
                      children: [
                        showRightAnswer(),
                        SizedBox(width: 10),
                        Container(
                          width: Utils.getDeviceWidth(context) - 70,
                          height: Utils.getDeviceHeight(context) * 0.22,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey,
                              )
                          ),
                        )
                      ],
                    )),
              ],
            ),
            SizedBox(height: 15),
            index == 3 ? Container() : Divider(height: 1, thickness: 0.7)
          ],
        ),
      ),
    );
  }

  showTextOption(int index) {
    return InkResponse(
      onTap: () {
        setState(() => _selected[index] = !_selected[index]);
      },
      child: Container(
        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
        decoration: BoxDecoration(
            color: _selected[index] ? ThemeManager().getBgGradientDark() : ThemeManager().getBgGradientLight()
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Row(
                      children: [
                        showRightAnswer(),
                        SizedBox(width: 10),
                        Text("Question title", style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 14))
                      ],
                    )),
              ],
            ),
            SizedBox(height: 15),
            index == 3 ? Container() : Divider(height: 1, thickness: 0.7)
          ],
        ),
      ),
    );
  }

  showRightAnswer() {
    return GestureDetector(
      onTap: (){},
      child: Icon(Icons.check_box, color: ThemeManager().getHeaderColor()),
    );
  }

  showCardView(){
    return Container(
      width: Utils.getDeviceWidth(context),
      height: Utils.getDeviceHeight(context) * 0.32,
      child: Card(
        elevation: 3,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: Image.asset(Utils.getAssetsImg("book"))),
            showProgressIndicator(),
            Container(
//              height: Utils.getDeviceHeight(context) * 0.10,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 22),
              alignment: Alignment.center,
              color: ThemeManager().getStaticGradientColor(),
              child: showModuleTitleAndQuestion(),
            ),
          ],
        ),
      ),
    );
  }

  showExplanationText(){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: BaseText(
                  text: "Show explanation",
                  textColor: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity3()),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  textAlign: null
              ),
            ),
            SizedBox(height: 10),
            BaseText(
                text: Utils.getText(context, StringRes.strChallangesDialogContent),
                textColor: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()),
                fontSize: 13,
                fontWeight: FontWeight.normal,
                textAlign: null
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: Utils.getDeviceWidth(context),
              height: Utils.getDeviceHeight(context) * 0.25,
              decoration: BoxDecoration(
                  border: Border.all(color: ThemeManager().getDarkColor()),
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: AssetImage(Utils.getAssetsImg("book")))
              ),
            ),
            BaseText(
                text: "Link\nFile.pdf",
                textColor: ThemeManager().getDarkColor(),
                fontSize: 15,
                fontWeight: FontWeight.normal,
                textAlign: null
            )
          ],
        )
    );
  }

  showIntroductionText(){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: BaseText(
            text: "Introduction to fundamentals of marketing.",
            textColor: ThemeManager().getDarkColor(),
            fontSize: 15,
            fontWeight: FontWeight.normal,
            textAlign: null
        )
    );
  }

  showSelectTheRightOption(){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: BaseText(
            text: "Select the right option",
            textColor: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()),
            fontSize: 12,
            fontWeight: FontWeight.normal,
            textAlign: null
        )
    );
  }

  showModuleTitleAndQuestion(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BaseText(
            text: "Configure 15",
            textColor: ThemeManager().getDarkColor(),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            textAlign: null
        ),
        BaseText(
            text: "24",
            textColor: ThemeManager().getDarkColor(),
            fontSize: 15,
            fontWeight: FontWeight.normal,
            textAlign: null
        )
      ],
    );
  }

  showProgressIndicator() {
    return  LinearProgressIndicator(
      backgroundColor: Colors.grey.withOpacity(0.3),
      valueColor: AlwaysStoppedAnimation(ThemeManager().getDarkColor()),
      value: 0.5,
      minHeight: 3,
    );
  }

}
