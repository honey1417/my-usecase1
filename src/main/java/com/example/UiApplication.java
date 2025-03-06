package com.example.uipage;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;

@SpringBootApplication
public class UiApplication {
    public static void main(String[] args) {
        new SpringApplicationBuilder(UiApplication.class)
                .properties("server.port=8084")
                .run(args);
    }
}
