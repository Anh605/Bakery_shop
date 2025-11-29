/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author anh
 */

public class Booking {
    private int id; 
    private Customer customer;  
    private Banh banh;          
    private int quantity;       
    private String note; 
    private Timestamp orderTime;  
    private String status;

    public Booking() {
    }

    // Lay du lieu tu db
    public Booking(int id, Customer customer, Banh banh, int quantity, String note, Timestamp orderTime, String status) { 
        this.id = id;
        this.customer = customer;
        this.banh = banh;
        this.quantity = quantity;
        this.note = note;
        this.orderTime = orderTime;
        this.status = status;
    }

    // them booking moi
    public Booking(Customer customer, Banh banh, int quantity, String note, Timestamp orderTime, String status) {
        this.customer = customer;
        this.banh = banh;
        this.quantity = quantity;
        this.note = note;
        this.orderTime = orderTime;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Customer getCustomer() {
        return customer;
    }
    public void setCustomer(Customer customer) { 
        this.customer = customer; 
    }
    public Banh getBanh() {
        return banh;
    }
    public void setBanh(Banh banh) { 
        this.banh = banh; 
    }
    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
    public float getTotalPrice() {
        return banh.getFinalPrice() * quantity;
    }
    
    public Timestamp getOrderTime() { 
        return orderTime; 
    }
    
    public void setOrderTime(Timestamp orderTime) { 
        this.orderTime = orderTime; 
    }
    
    public String getStatus() { 
        return status; 
    }
    
    public void setStatus(String status) { 
        this.status = status; 
    }
    
    /**
     *
     * @return
     */
    @Override
    public String toString() {
        return "Booking: ID=" + id +
               ", Customer=" + customer.getName() +
               ", Banh=" + banh.getName() +
               ", Quantity=" + quantity +
               ", Note=" + note;
    }
}
 
