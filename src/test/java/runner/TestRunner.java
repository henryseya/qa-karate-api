package runner;

import com.intuit.karate.junit5.Karate;

class TestRunner {

    @Karate.Test
    Karate testAll() {
        return Karate.run("classpath:api").relativeTo(getClass());
    }

    @Karate.Test
    Karate testRest() {
        return Karate.run("classpath:api/rest").relativeTo(getClass());
    }

    @Karate.Test
    Karate testGraphQL() {
        return Karate.run("classpath:api/graphql").relativeTo(getClass());
    }
}
