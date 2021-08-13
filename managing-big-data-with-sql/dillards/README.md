# Project at a glance: Dillards

<img src="https://image.freepik.com/vector-gratis/tienda-ropa-ninos-ropa-infantil-estilo-adolescente-prendas-moda-nina-bolsas-compra-comprador-boutique-moda-infantil-ilustracion-metafora-concepto-aislado-vector_335657-1330.jpg" width="300">

## Business case

In 1938 William T Dillard founded a store in Nashville Arkansas, a southern state of the United States. Today, that store has grown into approximately 300 department stores in 29 states across United States of America, and each one of those stores has the same name, Dillard's. It sells all kinds of merchandise, from clothing, to accessories, to home decor. It has departments targeted towards women, as well as departments targeted towards men. It is a very popular place to shop. Luckily, it is also a store that collects a lot of data.

Like most stores, when you are ready to purchase an item in Dillard's, you bring it to a sales associate working at a cash register. The sales associate will take the item and use the bar code reader to scan the bar code on the tag that took the store attached the item. This information from the bar code is sent to a centralized database where it is stored in a transaction table. When the customer pays for the item, the payment details are also sent to the transaction table. The receipt is printed and the transaction is completed.

Hundreds of millions of purchase transactions are recorded at Dillard's per year. This provides a very good opportunity to use business analytics tools to **learn what factors influence customer purchasing.**

<img src="https://www.pymnts.com/wp-content/uploads/2020/08/department-store-Dillards-earnings.jpg" width="700">

### Data description

The data includes sales transaction data from August 2004 through July 2005. It includes exactly what items were included in each transaction, how much they cost and when and where the purchase was made. Additionally, there are census information about the metropolitan's statistical area surrounding the store in which the purchase was made. This information is spread across six tables ranging from 60 to over 120 million rows and size.

Dataset has been donated by [Dillard's](https://www.dillards.com/) to Walton School of Business at the University of Arkansas, which in turn partnered with Duke University to provide this information via Coursera to its enrolled students. It contains **28 attributes**, distributed into 6 tables which are:

- **`amt`**: Total amount of the transaction charge to the customer (ordinal)
- **`brand`**: The brand name of the stock item (categorical)
- **`city`**: City where the store is located (categorical)
- **`classid`**: Stock Item ClassificationThe color of the stock item (categorical)
- **`color`**: The color of the stock item (categorical)
- **`cost`**: The cost of the stock item (ordinal)
- **`dept`**: Department where the stock item belong (categorical)
- **`deptdesc`**: Description of the department (categorical)
- **`interid`**: Internal ID (categorical)
- **`mic`**: Master Item Code (categorical)
- **`orgprice`**: Original price of the item stock (ordinal)
- **`packsize`**: The quantity of item per pack (ordinal)
- **`quantity`**: Item quantity of the transaction (ordinal)
- **`register`**: Register Number of the current transaction
- **`retail`**: The retail price of the stock item (ordinal)
- **`saledate`**: Sale date of the item stock (ordinal)
- **`seq`**: Sequence number (ordinal)
- **`size`**: The size of the stock item (ordinal)
- **`sku`**: Stock Keeping Unit number of the stock item (categorical)
- **`sprice`**: Sale price of the item stock (ordinal)
- **`state`**: State where the store is located (categorical)
- **`store`**: Store Number (categorical)
- **`style`**: The specific style of the stock item (categorical)
- **`stype`**: Type of the transaction (Return or Purchase) (categorical)
- **`trannum`**: Transaction Code (categorical)
- **`upc`**: Universal Product Code for the stock item (categorical)
- **`vendor`**: The vendor number of the stock item (categorical)
- **`zip`**: ZIP Code (categorical)
