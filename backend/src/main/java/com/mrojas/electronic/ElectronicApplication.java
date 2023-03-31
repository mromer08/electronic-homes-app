package com.mrojas.electronic;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@SpringBootApplication
public class ElectronicApplication {

	public static void main(String[] args) {
		SpringApplication.run(ElectronicApplication.class, args);
	}

	// IMPORTANTE CONFIGURACION DE LOS CORS PARA QUE LA API PUEDA SER CONSUMIDA
	@Bean
	public WebMvcConfigurer corsConfigurer() {
		return new WebMvcConfigurer() {
			@Override
			public void addCorsMappings(CorsRegistry registry) {
				registry
					.addMapping("/api/**")
					.allowedOrigins("http://localhost:5173/")
					.allowedMethods("*");

			}
		};
	}

}
