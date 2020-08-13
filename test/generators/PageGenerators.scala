package generators

import org.scalacheck.Arbitrary
import pages._

trait PageGenerators {

  implicit lazy val arbitraryWhenDidYouStartWorkingFromHomePage: Arbitrary[WhenDidYouStartWorkingFromHomePage.type] =
    Arbitrary(WhenDidYouStartWorkingFromHomePage)
}
