package com.example.myhompage.shoppingCart;

public class ShoppingCart {
    Long id;
    String memberId;
    Long productId;
    Integer amount;

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    @Override
    public String toString() {
        return "ShoppingCart{" +
                "id=" + id +
                ", memberId='" + memberId + '\'' +
                ", productId=" + productId +
                '}';
    }
}
