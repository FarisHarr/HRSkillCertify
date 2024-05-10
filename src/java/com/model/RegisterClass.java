/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

import java.util.*;
import org.apache.tomcat.jni.Time;

/**
 *
 * @author FarisHarr
 */
public class RegisterClass {
    
    private String cert_Type;
    private Date date;
    private Time start_Time;
    private Time end_Time;

    public String getCert_Type() {
        return cert_Type;
    }

    public void setCert_Type(String cert_Type) {
        this.cert_Type = cert_Type;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Time getStart_Time() {
        return start_Time;
    }

    public void setStart_Time(Time start_Time) {
        this.start_Time = start_Time;
    }

    public Time getEnd_Time() {
        return end_Time;
    }

    public void setEnd_Time(Time end_Time) {
        this.end_Time = end_Time;
    }
    
    
}
