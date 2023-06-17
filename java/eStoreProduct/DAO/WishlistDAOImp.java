package eStoreProduct.DAO;

import java.util.Collections;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import eStoreProduct.utility.ProductStockPrice;

@Component
public class WishlistDAOImp implements WishlistDAO {

	JdbcTemplate jdbcTemplate;
	private ProdStockDAO prodStockDAO;
	@Autowired
	public WishlistDAOImp(DataSource dataSource, ProdStockDAO prodStockDAO) {
		jdbcTemplate = new JdbcTemplate(dataSource);
		 this.prodStockDAO = prodStockDAO;
	}
	private String insert_slam_wishlist = "INSERT INTO slam_wishlist (c_id,p_id) VALUES (?, ?)";
	private String delete_slam_wishlist = "DELETE FROM slam_wishlist WHERE c_id=? AND p_id=?";
	private String select_slam_wishlist = "SELECT pd.* FROM slam_Products pd, slam_wishlist sc WHERE sc.c_id = ? AND sc.p_id = pd.prod_id";

	public int addToWishlist(int productId, int customerId) {
		int r = jdbcTemplate.update(insert_slam_wishlist, customerId, productId);
		if (r > 0) {
			System.out.println("inserted into cart");
			return productId;

		} else {
			return -1;
		}
	}

	public int removeFromWishlist(int productId, int customerId) {
		int r = jdbcTemplate.update(delete_slam_wishlist, customerId, productId);
		if (r > 0) {
			System.out.println("deleted from  cart");
			return productId;
		} else {
			return -1;
		}
	}

	public List<ProductStockPrice> getWishlistProds(int cust_id) {
		try {
			List<ProductStockPrice> cproducts = jdbcTemplate.query(select_slam_wishlist, new CartProductRowMapper(prodStockDAO), cust_id);
			System.out.println(cproducts.toString());
			return cproducts;
		} catch (Exception e) {
			e.printStackTrace();
			return Collections.emptyList(); // or throw an exception if required
		}}
}