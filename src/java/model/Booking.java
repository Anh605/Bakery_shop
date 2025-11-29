/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
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

    // Lay du lieu tu db
    public Booking(int id, Customer customer, Banh banh, int quantity, String note) { 
        this.id = id;
        this.customer = customer;
        this.banh = banh;
        this.quantity = quantity;
        this.note = note;
    }

    // them booking moi
    public Booking(Customer customer, Banh banh, int quantity, String note) {
        this.customer = customer;
        this.banh = banh;
        this.quantity = quantity;
        this.note = note;
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
    public String toString() {
        return "Booking: ID=" + id +
               ", Customer=" + customer.getName() +
               ", Banh=" + banh.getName() +
               ", Quantity=" + quantity +
               ", Note=" + note;
    }
}
 
