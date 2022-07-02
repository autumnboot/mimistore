package com.mimi.pojo.vo;

public class ProductInfoVo {
    //商品名称的条件封装
    private String productName;
    //商品类型的条件封装
    private Integer productType;
    //商品最低价格的条件封装
    private Double lowPrice;
    //商品最高价格的条件封装
    private Double highPrice;
    //设置页码
    private Integer pageNum = 1;

    public ProductInfoVo() {
    }

    public ProductInfoVo(String productName, Integer productType, Double lowPrice, Double highPrice, Integer pageNum) {
        this.productName = productName;
        this.productType = productType;
        this.lowPrice = lowPrice;
        this.highPrice = highPrice;
        this.pageNum = pageNum;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Integer getProductType() {
        return productType;
    }

    public void setProductType(Integer productType) {
        this.productType = productType;
    }

    public Double getLowPrice() {
        return lowPrice;
    }

    public void setLowPrice(Double lowPrice) {
        this.lowPrice = lowPrice;
    }

    public Double getHighPrice() {
        return highPrice;
    }

    public void setHighPrice(Double highPrice) {
        this.highPrice = highPrice;
    }

    public Integer getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

    @Override
    public String toString() {
        return "ProductInfoVo{" +
                "productName='" + productName + '\'' +
                ", productType=" + productType +
                ", lowPrice=" + lowPrice +
                ", highPrice=" + highPrice +
                ", pageNum=" + pageNum +
                '}';
    }
}
