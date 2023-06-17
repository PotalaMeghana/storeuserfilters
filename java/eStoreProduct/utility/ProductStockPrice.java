package eStoreProduct.utility;

import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import eStoreProduct.DAO.ProdStockDAO;

@Component
public class ProductStockPrice implements Comparable<ProductStockPrice>{

    private int prod_id;
    private String prod_title;
    private String prod_brand;
    private String image_url;
    private String prod_desc;
    private double price;

    private ProdStockDAO productStockDAO;

    @Autowired
    public ProductStockPrice(ProdStockDAO productStockDAO) {
        this.productStockDAO = productStockDAO;
    }

    @Override
    public int compareTo(ProductStockPrice other) {
        return Double.compare(this.price, other.price);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ProductStockPrice that = (ProductStockPrice) o;
        return prod_id == that.prod_id && Double.compare(that.price, price) == 0 && Objects.equals(prod_title, that.prod_title) && Objects.equals(prod_brand, that.prod_brand) && Objects.equals(image_url, that.image_url) && Objects.equals(prod_desc, that.prod_desc);
    }

    @Override
    public int hashCode() {
        return Objects.hash(prod_id, prod_title, prod_brand, image_url, prod_desc, price);
    }
    public int getProd_id() {
        return prod_id;
    }

    public void setProd_id(int prod_id) {
        this.prod_id = prod_id;
    }

    public String getProd_title() {
        return prod_title;
    }

    public void setProd_title(String prod_title) {
        this.prod_title = prod_title;
    }

    public String getProd_brand() {
        return prod_brand;
    }

    public void setProd_brand(String prod_brand) {
        this.prod_brand = prod_brand;
    }

    public String getImage_url() {
        return image_url;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }

    public String getProd_desc() {
        return prod_desc;
    }

    public void setProd_desc(String prod_desc) {
        this.prod_desc = prod_desc;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice() {
        //System.out.println("In setting price " + productStockDAO.getProdMrpById(prod_id)+"  for pid   "+prod_id);
        price = productStockDAO.getProdMrpById(prod_id);
    }
}
