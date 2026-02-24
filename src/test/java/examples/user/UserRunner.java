package examples.user;

import com.intuit.karate.junit5.Karate;

class UserRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("users").relativeTo(getClass());
    }    

}
