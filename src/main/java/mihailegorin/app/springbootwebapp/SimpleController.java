package mihailegorin.app.springbootwebapp;


import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

@RestController
public class SimpleController {

    @GetMapping(value = {"/"})
    public ResponseEntity<String> getServerStatus() {
        var res = "Server is working!   |   "
                .concat("Server time: " + new Date() + "    |   ")
                .concat("Have a nice day :)");
        return ResponseEntity.ok(res);
    }

}
