package com.clover.salad.documentTemplate.command.application.service;

import java.io.IOException;
import java.time.LocalDateTime;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.clover.salad.common.file.entity.FileUploadEntity;
import com.clover.salad.common.file.enums.FileUploadType;
import com.clover.salad.common.file.repository.FileUploadRepository;
import com.clover.salad.common.file.service.FileUploadService;
import com.clover.salad.common.file.service.PdfThumbnailService;
import com.clover.salad.contract.document.entity.DocumentTemplate;
import com.clover.salad.documentTemplate.command.application.dto.DocumentTemplatePatchRequestDTO;
import com.clover.salad.documentTemplate.command.application.dto.DocumentTemplateUploadRequestDTO;
import com.clover.salad.documentTemplate.command.application.dto.DocumentTemplateUploadResponseDTO;
import com.clover.salad.documentTemplate.command.domain.repository.DocumentTemplateCommandRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DocumentTemplateCommandServiceImpl implements DocumentTemplateCommandService {

	private final DocumentTemplateCommandRepository documentTemplateCommandRepository;
	private final FileUploadService fileUploadService;
	private final PdfThumbnailService pdfThumbnailService;
	private final FileUploadRepository fileUploadRepository;

	@Override
	@Transactional
	public DocumentTemplateUploadResponseDTO uploadDocumentTemplate(
		MultipartFile file,
		DocumentTemplateUploadRequestDTO dto
	) throws IOException {
		FileUploadEntity uploaded = fileUploadService.uploadAndSave(file, FileUploadType.DOCUMENT_TEMPLATE);

		String fileName = file.getOriginalFilename();
		if (fileName != null && fileName.toLowerCase().endsWith(".pdf")) {
			byte[] thumbnailBytes = pdfThumbnailService.generateFirstPageThumbnail(uploaded.getPath());
			String thumbnailPath = pdfThumbnailService.uploadThumbnailToS3(uploaded.getPath(), thumbnailBytes);
			uploaded.setThumbnailPath(thumbnailPath);
			fileUploadRepository.save(uploaded);
		}

		DocumentTemplate entity = DocumentTemplate.builder()
			.name(dto.getName())
			.version("v1.0")
			.description(dto.getDescription())
			.createdAt(LocalDateTime.now())
			.isDeleted(false)
			.fileUpload(uploaded)
			.build();

		DocumentTemplate saved = documentTemplateCommandRepository.save(entity);
		return new DocumentTemplateUploadResponseDTO(saved.getId(), "템플릿 업로드 성공");
	}

	@Override
	@Transactional
	public void deleteDocumentTemplate(Integer id) {
		DocumentTemplate template = documentTemplateCommandRepository.findById(id)
			.orElseThrow(() -> new IllegalArgumentException("존재하지 않는 템플릿입니다."));
		template.setDeleted(true);
		template.setCreatedAt(LocalDateTime.now());
	}

	@Override
	@Transactional
	public void patchDocumentTemplate(
		Integer id,
		DocumentTemplatePatchRequestDTO dto
	) throws IOException {
		DocumentTemplate template = documentTemplateCommandRepository.findById(id)
			.orElseThrow(() -> new IllegalArgumentException("존재하지 않는 템플릿입니다."));

		// 버전 증가
		String currentVersion = template.getVersion();
		template.setVersion(incrementVersion(currentVersion));

		// 메타 정보 업데이트
		if (dto.getName() != null) {
			template.setName(dto.getName());
		}
		if (dto.getDescription() != null) {
			template.setDescription(dto.getDescription());
		}

		// 새 파일 업로드 시 처리
		MultipartFile newFile = dto.getFile();
		if (newFile != null && !newFile.isEmpty()) {
			FileUploadEntity newUploaded = fileUploadService.uploadAndSave(newFile, FileUploadType.CONTRACT);

			// PDF 썸네일 생성
			String newFileName = newFile.getOriginalFilename();
			if (newFileName != null && newFileName.toLowerCase().endsWith(".pdf")) {
				byte[] thumbBytes = pdfThumbnailService.generateFirstPageThumbnail(newUploaded.getPath());
				String thumbPath = pdfThumbnailService.uploadThumbnailToS3(newUploaded.getPath(), thumbBytes);
				newUploaded.setThumbnailPath(thumbPath);
				fileUploadRepository.save(newUploaded);
			}

			template.setFileUpload(newUploaded);
		}

		template.setCreatedAt(LocalDateTime.now());
	}

	private String incrementVersion(String version) {
		try {
			if (version == null || !version.startsWith("v1.")) {
				return "v1.1";
			}
			int num = Integer.parseInt(version.substring(3));
			return "v1." + (num + 1);
		} catch (Exception e) {
			return "v1.1";
		}
	}
}
