import 'package:flutter/material.dart';
import 'package:ke_employee/baseController/base_button.dart';
import 'package:ke_employee/baseController/base_text.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/manager/module_manager.dart';
import 'package:ke_employee/manager/theme_manager.dart';

class ModuleDetailPortrait extends StatefulWidget {
  final ModuleOptions moduleOptions;
  ModuleDetailPortrait(this.moduleOptions);

  @override
  _ModuleDetailPortraitState createState() => _ModuleDetailPortraitState();
}

class _ModuleDetailPortraitState extends State<ModuleDetailPortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: AppBar(
            elevation: 0,
            title: Text("Module", style: TextStyle(color: ThemeManager().getTextColor(), fontSize: 17)),
            leading: IconButton(icon: Icon(Icons.arrow_back, size: 24, color: ThemeManager().getTextColor()), onPressed: (){Navigator.of(context).pop();}),
          )),
      body: SingleChildScrollView(
        child: Container(
          color: ThemeManager().getBgGradientLight(),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showCardView(),
              showIntroductionText(),
              showStartModuleButton(),
              showDescriptionText(),
              showAllQuestionsText(),
              Divider(height: 1, thickness: 1),
              showQuestionsList()
            ],
          ),
        ),
      ),
    );
  }


  showQuestionsList() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        itemCount: 10,
        itemBuilder: (context, index){
          return Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: ThemeManager().getDarkColor())
                              ),
                              child: Text("Q.${index+1}", style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 12)),
                            ),
                            SizedBox(width: 10),
                            Text("Question title", style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 14))
                          ],
                        )),
                    showRightAnswer()
                  ],
                ),
                SizedBox(height: 15),
                Divider(height: 1, thickness: 0.7)
              ],
            ),
          );
        });
  }

  showRightAnswer() {
    return GestureDetector(
      onTap: (){},
      child: Icon(Icons.check_box, color: ThemeManager().getHeaderColor()),
    );
  }

  showWrongAnswer() {
    return GestureDetector(
      onTap: (){},
      child: Icon(Icons.cancel, color: ThemeManager().getHeaderColor()),
    );
  }

  showAllQuestionsText() {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
      child: Text("All questions",
        style: TextStyle(
            color: ThemeManager().getDarkColor(),
            fontSize: 15,
            fontWeight: FontWeight.bold
        ),
      ),
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
              height: Utils.getDeviceHeight(context) * 0.10,
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              color: ThemeManager().getStaticGradientColor(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  showModuleTitleAndQuestion(),
                  Row(
                    children: [
                      addModuleWidget(),
                      SizedBox(width: 10),
                      downloadWidget()
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  showModuleTitleAndQuestion(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Utils.getText(context,widget.moduleOptions.title),
            style: TextStyle(
                color: ThemeManager().getDarkColor(),
                fontSize: 17,
                fontWeight: FontWeight.bold
            )),
        SizedBox(height: 5),
        Text("10 Questions",
            style: TextStyle(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()), fontSize: 13))
      ],
    );
  }

  showProgressIndicator() {
    return  LinearProgressIndicator(
      backgroundColor: Colors.grey.withOpacity(0.3),
      valueColor: AlwaysStoppedAnimation(ThemeManager().getDarkColor()),
      value: widget.moduleOptions.progressValue,
      minHeight: 3,
    );
  }

  addModuleWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: ThemeManager().getDarkColor())
      ),
      child: Text("Add module +",
          style: TextStyle(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity2()), fontSize: 13)),
    );
  }

  downloadWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: ThemeManager().getDarkColor())
      ),
      child: Icon(Icons.file_download, size: 20),
    );
  }

  showIntroductionText(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: BaseText(
          text: "Introduction to fundamentals of marketing.",
          textColor: ThemeManager().getDarkColor(),
          fontSize: 13,
          fontWeight: FontWeight.normal,
          textAlign: null
      )
    );
  }

  showStartModuleButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: Utils.getDeviceWidth(context),
      child: BaseRaisedButton(
        buttonText: "Start module",
        onPressed: (){},
        buttonColor: ThemeManager().getHeaderColor(),
        textColor: ThemeManager().getLightColor(),
        borderColor: ThemeManager().getDarkColor(),
      ),
    );
  }

  showDescriptionText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(Utils.getText(context, StringRes.rewardsDialogContent),
        style: TextStyle(
          color: ThemeManager().getDarkColor(),
          fontSize: 13,
        ),
      ),
    );
  }
}
