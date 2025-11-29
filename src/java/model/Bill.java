/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
/**
 *
 * @author anh
 */
public class Bill {
    private int id;             
    private Booking booking;    
    private float totalPrice;   


    public Bill(int id, Booking booking, float totalPrice) {
        this.id = id;
        this.booking = booking;
        this.totalPrice = totalPrice;
    }


    public Bill(Booking booking, float totalPrice) {
        this.booking = booking;
        this.totalPrice = totalPrice;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Booking getBooking() {
        return booking;
    }

    public void setBooking(Booking booking) {
        this.booking = booking;
    }

    public float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }


    public String toString() {
        return "Bill ID=" + id +
               ", BookingID=" + (booking != null ? booking.getId() : "null") +
               ", TotalPrice=" + totalPrice;
    }
}
