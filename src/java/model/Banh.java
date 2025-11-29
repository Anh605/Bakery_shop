/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.util.ArrayList;
/**
 *
 * @author anh
 */
public class Banh {

    private int banhId;                       
    private String name;            
    private String description;          
    private float price;            
    private float sale;             
    private ArrayList<String> images;   

    public Banh(int banhId, String name, float price,
                float sale, ArrayList<String> images,
                String description) { 

        this.banhId = banhId;
        this.name = name;
        this.price = price;
        this.sale = sale;
        this.images = images;
        this.description = description;
    }
    public int getId() {
        return banhId;
    }
    public void setId(int id) {
        this.banhId = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    // Chuyen gia ve dang gia chuan .000 VND
    public String getFormattedPrice() {
        String res = "";
        String s = "" + (int) this.price;
        int cnt = 1;
        for (int i = s.length() - 1; i >= 0; i--) {
            res = s.charAt(i) + res;
            if (cnt % 3 == 0 && i != 0) res = "." + res;
            cnt++;
        }
        return res;
    }
    public float getRawPrice() {
        return price;
    }
    public void setPrice(float price) {
        this.price = price;
    }
    public float getSale() {
        return sale;
    }
    public void setSale(float sale) {
        this.sale = sale;
    }
    public float getFinalPrice() {
        return price * (1 - sale / 100);
    }
    public String getMainImage() {
        return (images != null && images.size() > 0) ? images.get(0) : "";
    }
    public ArrayList<String> getImages() {
        return images;
    }
    public void setImages(ArrayList<String> images) {
        this.images = images;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
}
