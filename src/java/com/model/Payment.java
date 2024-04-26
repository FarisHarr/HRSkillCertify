/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

import java.util.Date;

/**
 *
 * @author FarisHarr
 */
public class Payment {
    
    private String price;
    private Date date;
    private String reciept;
    private String status;
    private String cand_ID;
    private String certType;

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }


    public String getReciept() {
        return reciept;
    }

    public void setReciept(String reciept) {
        this.reciept = reciept;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCand_ID() {
        return cand_ID;
    }

    public void setCand_ID(String cand_ID) {
        this.cand_ID = cand_ID;
    }

    public String getCertType() {
        return certType;
    }

    public void setCertType(String CertType) {
        this.certType = certType;
    }


    
    
    
}
