package mihailegorin.app.springbootwebapp;


import lombok.extern.slf4j.Slf4j;
import mihailegorin.app.springbootwebapp.data.GetServerStatusResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.Date;

@Slf4j
@RestController
public class SimpleController {

    @GetMapping(value = {"/"})
    public ResponseEntity<GetServerStatusResponse> getServerStatus() {
        final var client = WebClient.create("http://169.254.169.254");
        final var ip = client.get()
                .uri("/latest/meta-data/local-ipv4")
                .retrieve()
                .bodyToMono(String.class)
                .doOnError(error -> log.error("An error has occurred {}", error.getMessage()))
                .block();


        final var response = GetServerStatusResponse.builder()
                .serverIp(ip)
                .serverTime(new Date().toString())
                .message("Server is working! Have a nice day :)")
                .build();

        return ResponseEntity.ok(response);
    }

    @GetMapping(value = {"/greet"})
    public ResponseEntity<String> greet() {
        return ResponseEntity.ok("Hello!");
    }

}
