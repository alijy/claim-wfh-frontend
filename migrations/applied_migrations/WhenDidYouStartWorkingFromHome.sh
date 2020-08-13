#!/bin/bash

echo ""
echo "Applying migration WhenDidYouStartWorkingFromHome"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /whenDidYouStartWorkingFromHome                  controllers.WhenDidYouStartWorkingFromHomeController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /whenDidYouStartWorkingFromHome                  controllers.WhenDidYouStartWorkingFromHomeController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeWhenDidYouStartWorkingFromHome                        controllers.WhenDidYouStartWorkingFromHomeController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeWhenDidYouStartWorkingFromHome                        controllers.WhenDidYouStartWorkingFromHomeController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "whenDidYouStartWorkingFromHome.title = WhenDidYouStartWorkingFromHome" >> ../conf/messages.en
echo "whenDidYouStartWorkingFromHome.heading = WhenDidYouStartWorkingFromHome" >> ../conf/messages.en
echo "whenDidYouStartWorkingFromHome.checkYourAnswersLabel = WhenDidYouStartWorkingFromHome" >> ../conf/messages.en
echo "whenDidYouStartWorkingFromHome.error.required.all = Enter the whenDidYouStartWorkingFromHome" >> ../conf/messages.en
echo "whenDidYouStartWorkingFromHome.error.required.two = The whenDidYouStartWorkingFromHome" must include {0} and {1} >> ../conf/messages.en
echo "whenDidYouStartWorkingFromHome.error.required = The whenDidYouStartWorkingFromHome must include {0}" >> ../conf/messages.en
echo "whenDidYouStartWorkingFromHome.error.invalid = Enter a real WhenDidYouStartWorkingFromHome" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhenDidYouStartWorkingFromHomeUserAnswersEntry: Arbitrary[(WhenDidYouStartWorkingFromHomePage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[WhenDidYouStartWorkingFromHomePage.type]";\
    print "        value <- arbitrary[Int].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhenDidYouStartWorkingFromHomePage: Arbitrary[WhenDidYouStartWorkingFromHomePage.type] =";\
    print "    Arbitrary(WhenDidYouStartWorkingFromHomePage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(WhenDidYouStartWorkingFromHomePage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def whenDidYouStartWorkingFromHome: Option[AnswerRow] = userAnswers.get(WhenDidYouStartWorkingFromHomePage) map {";\
     print "    x =>";\
     print "      AnswerRow(";\
     print "        HtmlFormat.escape(messages(\"whenDidYouStartWorkingFromHome.checkYourAnswersLabel\")),";\
     print "        HtmlFormat.escape(x.format(dateFormatter)),";\
     print "        routes.WhenDidYouStartWorkingFromHomeController.onPageLoad(CheckMode).url";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration WhenDidYouStartWorkingFromHome completed"
