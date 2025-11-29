/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
/**
 *
 * @author anh
 */
public class Customer {
    private int id;          
    private String name;    
    private String email;    
    private String tel;      
    private String address;  
    private String password;
    private String role;


    public Customer(int id, String name, String email, String tel, String address, String password, String role) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.tel = tel;
        this.address = address;
        this.password = password;
        this.role = role;
    }

 
    public Customer(String name, String email, String tel, String address, String password, String role) {
        this.name = name;
        this.email = email;
        this.tel = tel;
        this.address = address;
        this.password = password;
        this.role = role;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getPassword(){
        return password;
    }
    
    public void setPassword(String password){
        this.password = password;
    }
    
    public String getRole() { 
        return role; 
    }   
    
    public void setRole(String role) { 
        this.role = role; 
    }

    /**
     *
     * @return
     */
    @Override
    public String toString() {
        return "Customer: " + id +
               ", Name=" + name +
               ", Email=" + email +
               ", Tel=" + tel +
               ", Address=" + address +
                ", Role=" + role;
    }
}
