package views

import java.time.LocalDate

import forms.WhenDidYouStartWorkingFromHomeFormProvider
import models.{NormalMode, UserAnswers}
import play.api.data.Form
import play.twirl.api.HtmlFormat
import views.behaviours.QuestionViewBehaviours
import views.html.WhenDidYouStartWorkingFromHomeView

class WhenDidYouStartWorkingFromHomeViewSpec extends QuestionViewBehaviours[LocalDate] {

  val messageKeyPrefix = "whenDidYouStartWorkingFromHome"

  val form = new WhenDidYouStartWorkingFromHomeFormProvider()()

  "WhenDidYouStartWorkingFromHomeView view" must {

    val application = applicationBuilder(userAnswers = Some(UserAnswers(userAnswersId))).build()

    val view = application.injector.instanceOf[WhenDidYouStartWorkingFromHomeView]

    def applyView(form: Form[_]): HtmlFormat.Appendable =
      view.apply(form, NormalMode)(fakeRequest, messages)

    behave like normalPage(applyView(form), messageKeyPrefix)

    behave like pageWithBackLink(applyView(form))
  }
}
