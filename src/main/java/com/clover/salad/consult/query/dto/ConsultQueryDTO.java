package com.clover.salad.consult.query.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ConsultQueryDTO {
    private int id;

    @JsonProperty("consultAt")
    private String consultAt;

    private String content;

    @JsonProperty("isDeleted")
    private boolean isDeleted;

    private String etc;

    @JsonProperty("feedbackScore")
    private Double feedbackScore;

    @JsonProperty("employeeId")
    private int employeeId;

    @JsonProperty("customerId")
    private int customerId;

    @JsonProperty("customerName")
    private String customerName;

    private String employeeName;

    private String employeeLevelLabel;

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public String getEmployeeLevelLabel() {
        return employeeLevelLabel;
    }

    public void setEmployeeLevelLabel(String employeeLevelLabel) {
        this.employeeLevelLabel = employeeLevelLabel;
    }
}
