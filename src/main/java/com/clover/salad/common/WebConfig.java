package com.clover.salad.common;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.clover.salad.common.logging.ClientLogInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	@Override
	public void addCorsMappings(CorsRegistry registry) {
		String[] origins = {
			"http://localhost:8080",
			"http://localhost:5173",
			"https://saladerp.com",
			"https://salad-alb-240627784.ap-northeast-2.elb.amazonaws.com"
		};

		registry.addMapping("/auth/login")
			.allowedOrigins(origins)
			.allowedMethods("POST", "OPTIONS")
			.allowedHeaders("*")
			.allowCredentials(false);

		registry.addMapping("/auth/refresh-token")
			.allowedOrigins(origins)
			.allowedMethods("POST", "OPTIONS")
			.allowedHeaders("*")
			.allowCredentials(true); // 쿠키 기반 인증 필요

		registry.addMapping("/notification/subscribe")
			.allowedOrigins(origins)
			.allowedMethods("GET", "OPTIONS")
			.allowedHeaders("*")
			.allowCredentials(false);

		registry.addMapping("/employee/password-reset")
			.allowedOrigins(origins)
			.allowedMethods("POST", "OPTIONS")
			.allowedHeaders("*")
			.allowCredentials(false);

		registry.addMapping("/employee/password-resets/confirm")
			.allowedOrigins(origins)
			.allowedMethods("POST", "OPTIONS")
			.allowedHeaders("*")
			.allowCredentials(false);

		registry.addMapping("/**")
			.allowedOrigins(origins)
			.allowedMethods("GET", "POST", "PUT", "DELETE", "PATCH", "OPTIONS")
			.allowedHeaders("*")
			.exposedHeaders("Authorization")
			.allowCredentials(true);
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new ClientLogInterceptor())
			.addPathPatterns("/**");
	}
}

