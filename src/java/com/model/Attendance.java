/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

/**
 *
 * @author FarisHarr
 */
public class Attendance {
    private String classID;
    private String candID;
//    private String certType;
    private String attendance;

    public String getClassID() {
        return classID;
    }

    public void setClassID(String classID) {
        this.classID = classID;
    }

    public String getCandID() {
        return candID;
    }

    public void setCandID(String candID) {
        this.candID = candID;
    }

//    public String getCertType() {
//        return certType;
//    }
//
//    public void setCertType(String certType) {
//        this.certType = certType;
//    }

    public String getAttendance() {
        return attendance;
    }

    public void setAttendance(String attendance) {
        this.attendance = attendance;
    }
    
    
    
}
