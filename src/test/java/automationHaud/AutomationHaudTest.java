package automationHaud;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

@KarateOptions(tags = {"smpp_to_http"})
class AutomationHaudTest {

    @Test
    void testParallel() {
        Results results = Runner.parallel(getClass(),5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}