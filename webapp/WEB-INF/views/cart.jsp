<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%@ page import="eStoreProduct.utility.ProductStockPrice" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cart</title>
    <style>
        .product-box {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        
        .product-card {
            width: 30%;
            margin-bottom: 20px;
        }
        
        #costdiv {
            text-align: center;
            margin-top: 40px;
        }
    </style>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).on('change', '.qtyinp', function() {
            updateTotalCost();
        });

        function updateTotalCost() {
            var totalCost = 0;

            $('.qtyinp').each(function() {
                var quantity = parseInt($(this).val(), 10);
                var price = parseFloat($(this).closest('.card-body').find('.prodPrice').text());

                if (!isNaN(quantity) && !isNaN(price)) {
                    totalCost += quantity * price;
                }
            });

            $('#cst').text('Total Cost: $' + totalCost.toFixed(2));
        }

        $(document).ready(function() {
            updateTotalCost();
        });

        $(document).on('click', '.buyid', function(event) {
            event.preventDefault();
            buynow();
        });

        function buynow() {
            console.log("buy now");
            window.location.href = "buycartitems";
        }
        function updateQuantity(input) {
            var quantity = input.value;
            var productId = input.getAttribute('data-product-id');
            console.log(quantity);
            console.log("product no=" + productId);
            $.ajax({
                url: 'updateQuantity',
                method: 'POST',
                data: { productId: productId, quantity: quantity },
                success: function(response) {
                    console.log(response);
                    $("#cst").html("Total Cost: $" + response);
                },
                error: function(xhr, status, error) {
                    console.log('AJAX Error: ' + error);
                }
            });
        }
    </script>
</head>
<body>
    <div class="container mt-5">
        <h2>Cart</h2>
        <div class="row mt-4">
            Iterate over the products and render the HTML content
            <%
                List<ProductStockPrice> products = (List<ProductStockPrice>) request.getAttribute("products");
                if(products != null) {
                    double cartcost = 0;
                    int totalitems = 0;
                    int shipch = 0;
                    for (ProductStockPrice product : products) {
                        totalitems++;
            %>
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="card h-100">
                    <img class="card-img-top" src="<%= product.getImage_url() %>" alt="<%= product.getProd_title() %>">
                    <br>
                    
                    <div class="card-body">
                        <label>Quantity<input type="number" align="center" name="Quantity" class="form-control qtyinp" style="width: 50px;" min="1" data-product-id="<%= product.getProd_id() %>" onchange="updateQuantity(this)" value="1"></label>
                    
                        <h5 class="card-title"><%= product.getProd_title() %></h5>
                        <p class="card-text"><%= product.getProd_desc() %></p>
                        <p class="card-text prodPrice"><%= product.getPrice() %></p> 
                        <button class="btn btn-primary removeFromCart" data-product-id="<%= product.getProd_id() %>">Remove from Cart</button>
                        <button class="btn btn-secondary addToWishlistButton" data-product-id="<%= product.getProd_id() %>">Add to Wishlist</button>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>
    </div>
    <div class="container mt-3">
        <div id="cst">
            <p>Total Cost: $${cartcost}</p>
            <button onclick="buynow()">Place Order</button>
        </div>
    </div>
</body>
</html>

<%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.utility.ProductStockPrice" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cart</title>
</head>
<body>
    <div class="container mt-5">
        <h2>Cart</h2>
        <div class="row mt-4">
            Iterate over the products and render the HTML content
            <%
                List<ProductStockPrice> products = (List<ProductStockPrice>) request.getAttribute("products");

                for (ProductStockPrice product : products) {
            %>
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="card h-100">
                    <img class="card-img-top" src="<%= product.getImage_url() %>" alt="<%= product.getProd_title() %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= product.getProd_title() %></h5>
                        <p class="card-text"><%= product.getProd_desc() %></p>
                    <p class="card-text"><%= product.getPrice() %></p>
                    <label>Qty:</label><input type="number" class="btn btn-primary qtyinp input-width" id="qtyinp" value="1" min="1" onchange="updateQuantity(this)" data-product-id="<%= product.getProd_id() %>">
                        <br><br><button class="btn btn-primary removeFromCart" data-product-id="<%= product.getProd_id() %>">Remove from Cart</button>
                        <button class="btn btn-secondary addToWishlistButton" data-product-id="<%= product.getProd_id() %>">Add to Wishlist</button>
                    </div>
                </div>
            </div>
            <%
                }
            %>
            
  
    </div>
    <div align="center" id="cst">
            <p align="center">Total Cost=${cartcost}</p>
            </div>
        <button class="btn btn-primary BuyNow" onclick="buynow()">PlaceOrder</button>
      
        </div>
</body>
</html>
 --%>
 
 
 
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.utility.ProductStockPrice" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cart</title>
    <script>
    function buynow()
    {
  	  console.log("buy now");

  	  	window.location.href="buycartitems";  
  	    }
    function updateQuantity(input) {
        var quantity = input.value;
        var productId = input.getAttribute('data-product-id');
        console.log("qty in updateqty method "+quantity);
        console.log("product no=" + productId);
        $.ajax({
            url: 'updateQuantity',
            method: 'POST',
            data: { productId: productId, quantity: quantity },
            success: function(response) {
                console.log("response of updateqty  "+response);
                $("#cst").html("Total Cost: $" + response);
            },
            error: function(xhr, status, error) {
                console.log('AJAX Error: ' + error);
            }
        });
    }
    </script>
</head>
<body>
    <div class="container mt-5">
        <h2>Cart</h2>
        <div class="row mt-4">
            <%-- Iterate over the products and render the HTML content --%>
            <%
                List<ProductStockPrice> products = (List<ProductStockPrice>) request.getAttribute("products");
            double cartcost=(double)request.getAttribute("cartcost");

                for (ProductStockPrice product : products) {
            %>
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="card h-100">
                    <img class="card-img-top" src="<%= product.getImage_url() %>" alt="<%= product.getProd_title() %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= product.getProd_title() %></h5>
                        <p class="card-text"><%= product.getProd_desc() %></p>
                        <p class="card-text"><%= product.getPrice() %></p>
                        <label>Qty:</label>
                        <input type="number" class="btn btn-primary qtyinp input-width" id="qtyinp" value="1" min="1" onchange="updateQuantity(this)" data-product-id="<%= product.getProd_id() %>">
                        <br><br>
                        <button class="btn btn-primary removeFromCart" data-product-id="<%= product.getProd_id() %>">Remove from Cart</button>
                        <button class="btn btn-secondary addToWishlistButton" data-product-id="<%= product.getProd_id() %>">Add to Wishlist</button>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
    <div align="center" container mt-3">
        <div id="cst">
            <p align="center">Total Cost=${cartcost}</p>
        </div>
        <button class="btn btn-primary BuyNow" onclick="buynow()">Place Order</button>
    </div>
</body>
</html>
 