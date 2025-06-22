package com.clover.salad.common.exception;

public class ConsultsException {

    /** 상담 접근 권한이 없을 때 */
    public static class ConsultAccessDeniedException extends RuntimeException {
        public ConsultAccessDeniedException(String message) {
            super(message);
        }
    }

    /** 상담 내역이 존재하지 않을 때 */
    public static class ConsultNotFoundException extends RuntimeException {
        public ConsultNotFoundException(String message) {
            super(message);
        }
    }

    /** 잘못된 상담 요청 데이터일 때 */
    public static class InvalidConsultDataException extends RuntimeException {
        public InvalidConsultDataException(String message) {
            super(message);
        }
    }
}
