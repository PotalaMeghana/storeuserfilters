<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.utility.ProductStockPrice" %>
<%@ page import="eStoreProduct.model.custCredModel" %>
<%@ page import="eStoreProduct.DAO.ProdStockDAO" %>
<%@ page import="eStoreProduct.DAO.ProdStockDAOImp" %>
<%@ page import="eStoreProduct.model.productqty" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<div id="id1">
<div class="container mt-5">
    <div class="row mt-4">
        <%
        custCredModel cust1 = (custCredModel) session.getAttribute("customer");
        List<ProductStockPrice> products = (List<ProductStockPrice>) request.getAttribute("products");
        List<productqty> prqty=(List<productqty>)request.getAttribute("prqty");

        double total=0;
        for (ProductStockPrice product : products) {
        	for(productqty p:prqty)
        	{
        		if(product.getProd_id()==p.getPid()){
        			total=p.getQty()*product.getPrice();
        %>
        <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
              <img class="card-img-top" src="<%= product.getImage_url() %>" alt="<%= product.getProd_title() %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= product.getProd_title() %></h5>
                        <p class="card-text"><%= product.getProd_desc() %></p>
                    <p class="card-text"><%= product.getPrice() %></p>
                    <p class="card-text">Quantity:<%=p.getQty()%></p>
                    
                </div>
            </div>
        </div>
        <%
        		}
        	}
        }
        %>
    </div>
</div>
 <div align="center" cont">
    <form id="shipment-form">
        <table>
            <tr>
                <td>Shipment Address</td>
            </tr>
            <tr>
                <td>Name:</td>
                <td><input type="text" class="shipname" id="name" value="<%=cust1.getCustName()%>" readonly></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><input type="email" class="email" id="email" value="<%=cust1.getCustEmail()%>" readonly></td>
            </tr>
            <tr>
                <td>Mobile:</td>
                <td><input type="text" class="mobile" id="mobile" value="<%=cust1.getCustMobile()%>" readonly></td>
            </tr>
            <tr>
                <td>Address:</td>
                <td><input type="text" class="ship" id="custSAddress" value="<%=cust1.getCustSAddress()%>"></td>
            </tr>
            <tr>
                <td>Pincode:</td>
                <td><input type="text" class="shippincode" id="shippincode" value="<%=cust1.getCustPincode()%>"></td>
            </tr>
            <tr><td><input type="submit" value="Save"></td></tr>
        </table>
    </form>
    <div>
    <button class="btn btn-primary back">Back</button>
    <button class="btn btn-primary continue" onclick="continuenext()"><%= total %></button>
</div>
</div>
<div>
</div>
</div>

<script>

function continuenext()
{  //console.log("hiiiiiiiii");
  	window.location.href="paymentoptions";
	
	}
    $(document).on('click', '.back', function(event) {
        event.preventDefault();
        //console.log("Back");
        history.back();
    });
    $(document).ready(function() {
        $('#shipment-form').submit(function(e) {
            e.preventDefault(); 
            var submitButton = $(this).find('input[type="submit"]');

    console.log("shipment address");
            
           var name=$("#name").val();
           var add=$("#custSAddress").val();
           var pin=$("#shippincode").val();
           console.log(name); 

            $.ajax({
                type: 'POST', 
                url: 'confirmShipmentAddress',
                data:{name:name,custSAddress:add,shippincode:pin},
                success: function(response) {
                    console.log(response); 
                    submitButton.val("Saved");
                },
                error: function(error) {
                    console.error(error);
                }
            });
        });
    });
</script>
</body>
</html>
