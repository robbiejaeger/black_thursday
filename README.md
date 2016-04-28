## Black Thursday Sales Analyst

A primitive database system for analyzing business data from CSV files.

### Structure

The database consists of multiple repositories that contain all of the sales data. The repositories and their contents are:
* Item repository - individual items that merchants sell
* Merchant repository - each merchant with a unique id
* Invoice repository - invoices created by a customers, and each invoice contains one or more invoice items
* Invoice Item repository - records of each item bought in an invoice (an invoice contains one or more invoice item)
* Transaction repository - transactions for each invoice (an invoice can have multiple transactions)
* Customer repository - customers who have bought items

![alt text](/black_thursday_structure.jpeg "Class Structure")

### Using the Sales Analyst

To use the analyst, each repository must load the data from each CSV file. There is a CSV file for each repository. Load the CSV files using the Sales Engine class:

```
se = SalesEngine.from_csv({
  :items => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  :invoices => "./data/invoices.csv",
  :invoice_items => "./data/invoice_items.csv",
  :transactions => "./data/transactions.csv",
  :customers => "./data/customers.csv"
})
```

The business analytics are done in the Sales Analyst class. Create a new Sales Analyst class using the instance of the Sales Engine.

```
sa = SalesAnalyst.new(se)
```

The Sales Analyst has many methods to calculate business analytics. For example, you can generate a list of merchant objects who are the top revenue earners using the top_revenue_earners method, where _x_ is the number of merchants you want to return:

```
sa.top_revenue_earners(3)

#=> [merchant, merchant, merchant]
```

Another metric you can generate is the total revenue for a single merchant:

```
sa.revenue_by_merchant(merchant_id)

#=> $$
```

---

The original [project spec is here](https://github.com/turingschool/curriculum/blob/master/source/projects/black_thursday.markdown).
