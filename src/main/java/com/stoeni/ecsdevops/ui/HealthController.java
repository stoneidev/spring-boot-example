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
}
