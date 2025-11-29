/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
/**
 *
 * @author anh
 */
public class CartItem {
    private Banh banh;
    private int quantity;

    public CartItem(Banh banh, int quantity) {
        this.banh = banh;
        this.quantity = quantity;
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

    public void addQuantity(int amount) {
        this.quantity += amount;
    }
     public float getSumrawPrice(){
        if (banh==null) return 0;
        float priceBeforesale=banh.getRawPrice();
        return priceBeforesale*quantity;
    }
    public float getSumsalePrice(){
        if (banh==null) return 0;
        float priceafsale=banh.getFinalPrice();
        return priceafsale*quantity;
    }
    public float getSubtotal() {
        if (banh == null) return 0;
        float priceAfterSale = banh.getFinalPrice();
        return priceAfterSale * quantity;
    }
}


