/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

import com.mysql.cj.jdbc.Blob;

/**
 *
 * @author FarisHarr
 */
public class RegisterCert {
    
    private String certificate;
    private String workType;
    private String experience;
    private String cand_ID; // Candidate ID attribute
    private String status;
    private Blob receipt;
    

    public String getCertificate() {
        return certificate;
    }

    public void setCertificate(String certificate) {
        this.certificate = certificate;
    }

    public String getWorkType() {
        return workType;
    }

    public void setWorkType(String workType) {
        this.workType = workType;
    }

    public String getExperience() {
        return experience;
    }

    public void setExperience(String experience) {
        this.experience = experience;
    }

    public String getCandidateID() {
        return cand_ID;
    }

    public void setCandidateID(String candidateID) {
        this.cand_ID = candidateID;
    }

    public String getCand_ID() {
        return cand_ID;
    }

    public void setCand_ID(String cand_ID) {
        this.cand_ID = cand_ID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Blob getReciept() {
        return receipt;
    }

    public void setReciept(Blob reciept) {
        this.receipt = reciept;
    }
    
    
}
    

