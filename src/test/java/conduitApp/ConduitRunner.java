package conduitApp;

import com.intuit.karate.junit5.Karate;

class ConduitRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run().relativeTo(getClass());
    }

    @Karate.Test
    Karate testTags() {
        return Karate.run().tags("@debug").relativeTo(getClass());
    }

}
