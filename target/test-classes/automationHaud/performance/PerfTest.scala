package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {
    val protocol = karateProtocol( )
  // "/api/destinations/countries/{countryId}/networks" -> Nil

  //protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")
  //protocol.runner.karateEnv("perf")

  val create = scenario("Select Country and Network").exec(karateFeature("classpath:automationHaud/performance/apiTest.feature"))
  
  val categoryFeeder = csv("category.csv").circular
  val createCategory = scenario("Create Category").feed(categoryFeeder).exec(karateFeature("classpath:automationHaud/performance/category.feature"))
  
  val createHttpIn = scenario("Send Message Using HttpIn").exec(karateFeature("classpath:automationHaud/performance/httpin.feature"))
  
  setUp(

    /* createCategory.inject(
        atOnceUsers(1),
        nothingFor(4.seconds),
        constantUsersPerSec(1) during (2 seconds),
    ).protocols(protocol) */

    createHttpIn.inject(
        constantUsersPerSec(500) during (15 seconds),
    ).protocols(protocol)

  )

}