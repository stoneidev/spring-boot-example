package com.stoeni.ecsdevops.ui;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HealthController {

    @GetMapping("/")
    public String index() {
        return "HelloWorld-S&I GOGO";
    }

    @GetMapping("/healthcheck")
    public String healthcheck() {
        return "OK";
    }

    @GetMapping("/delay")
    public String delay() {
        try {
            // 0.04초(40밀리초) 동안 지연
            Thread.sleep(40);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            return "Error: Interrupted";
        }
        return "Delayed Response";
    }
}
