package com.clover.salad.common.logging.controller;

import java.io.IOException;
import java.io.BufferedReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.clover.salad.common.logging.dto.AccessLogDTO;

@RestController
@RequestMapping("/api/log")
public class AccessLogController {
	@GetMapping("/access")
	public List<AccessLogDTO> getAccessLogs() throws IOException {
		List<AccessLogDTO> result = new ArrayList<>();
		String logPath = System.getProperty("user.dir") + "/logs/request.log"; // logback log 파일 경로

		Pattern pattern = Pattern.compile(
			"(\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}) \\[REQ\\] INFO  ACCESS_LOGGER - Client Request - User: ([^,]+), IP: ([^,]+), Method: ([^,]+), URI: ([^,]+), User-Agent: (.+)"
		);

		Path path = Paths.get(logPath); // String -> Path 변환

		try (BufferedReader reader = Files.newBufferedReader(path)) {
			String line;
			while ((line = reader.readLine()) != null) {
				Matcher m = pattern.matcher(line);
				if (m.find()) {
					AccessLogDTO dto = new AccessLogDTO();
					dto.setTime(m.group(1));
					dto.setUser(m.group(2));
					dto.setIp(m.group(3));
					dto.setMethod(m.group(4));
					dto.setUri(m.group(5));
					dto.setUserAgent(m.group(6));
					result.add(dto);
				}
			}
		}
		return result;
	}
}
