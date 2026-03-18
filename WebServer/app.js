require("dotenv").config();

const express = require("express");
const morgan = require("morgan");
const cors = require("cors");

const app = express();

app.use(morgan("tiny"));
app.use(express.json());
app.use(cors()); // Enable CORS

const { Sequelize } = require("sequelize");

// DATABASE_URL is set as an environment variable on Render.
// Locally it falls back to your .env file (see .env.example).
const sequelize = new Sequelize(
  process.env.DATABASE_URL ||
    "postgres://postgres:Rfvg%4067512@localhost:5432/SupplierManagementDB",
  {
    dialect: "postgres",
    protocol: "postgres",
    dialectOptions: {
      ssl: process.env.DATABASE_URL
        ? { require: true, rejectUnauthorized: false }
        : false,
    },
    logging: false,
  }
);

async function connectionDB() {
  try {
    await sequelize.authenticate();
    console.log("Connection has been established successfully.");
  } catch (error) {
    console.error("Unable to connect to the database:", error);
  }
}

connectionDB();

//Supplier routes

//brand table working
app.get("/brands", async (req, res) => {
  try {
    const [results, metadata] = await sequelize.query("SELECT * FROM brand");
    console.log("Brands:", results);
    res.json(results);
  } catch (error) {
    console.error("Error executing query", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});
app.post("/linkedbrand", async (req, res) => {
  try {
    // Extract the data from the request body
    const { sId, bname, bcity } = req.body;

    // Check if a record with the same bname and bcity already exists
    const existingRecord = await sequelize.query(
      "SELECT * FROM linkedbrand WHERE sId = 1 AND bName = ? AND bCity = ?",
      {
        replacements: [bname, bcity],
        type: sequelize.QueryTypes.SELECT,
      }
    );

    if (existingRecord.length > 0) {
      return res.status(409).json({ message: "Record already exists" });
    }
    // Insert the data into the database
    const result = await sequelize.query(
      "INSERT INTO linkedbrand (sId, bName, bCity) VALUES (1, ?, ?)",
      {
        replacements: [bname, bcity],
        type: sequelize.QueryTypes.INSERT,
      }
    );

    console.log("Data inserted successfully:", result);

    // Send a success response
    res.status(200).json({ message: "Data inserted successfully" });
  } catch (error) {
    console.error("Error inserting data:", error);
    // Send an error response
    res.status(500).json({ error: "Internal Server Error" });
  }
});

//linkedbrand table working
app.get("/linkedBrand/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const results = await sequelize.query(
      "SELECT * FROM linkedBrandView WHERE sID = 1",
      {
        replacements: [id],
        type: sequelize.QueryTypes.SELECT,
      }
    );
    console.log("LinkedBrands:", results);
    res.json(results);
  } catch (error) {
    console.error("Error executing query", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});
app.delete("/linkedBrand/:sid/:bname/:bcity", async (req, res) => {
  const { sid, bname, bcity } = req.params;
  try {
    // Execute the raw SQL query to delete the linked brand from the database
    const result = await sequelize.query(
      "DELETE FROM linkedbrand WHERE sID = 1 AND bName = ? AND bCity = ?",
      {
        replacements: [bname, bcity],
        type: sequelize.QueryTypes.DELETE,
      }
    );
    res.sendStatus(200); // Send a success response if data was deleted
  } catch (error) {
    console.error("Error removing brand:", error);
    res.status(500).send("Internal Server Error"); // Send an error response if something goes wrong
  }
});

//customer table Working
app.get("/customer/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const results = await sequelize.query(
      "SELECT * FROM customerView WHERE sID = 1",
      {
        replacements: [id],
        type: sequelize.QueryTypes.SELECT,
      }
    );
    console.log("Customer:", results);
    res.json(results);
  } catch (error) {
    console.error("Error executing query", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});
app.post("/customer", async (req, res) => {
  const { cname, cemail, caddress } = req.body;

  // Validate required fields
  if (!cname || !cemail || !caddress) {
    return res.status(400).json({ error: "All fields are required" });
  }

  try {
    // Insert new customer record into the database using raw SQL
    const insertQuery = `
        INSERT INTO customer (cname, cemail, caddress,sID) 
        VALUES (?, ?, ?,1)
      `;
    const [insertedCustomer] = await sequelize.query(insertQuery, {
      replacements: [cname, cemail, caddress],
      type: sequelize.QueryTypes.INSERT,
    });

    // Send back the newly created customer object as response
    res.status(201).json({
      cid: insertedCustomer,
      cname,
      cemail,
      caddress,
    });
  } catch (error) {
    console.error("Error adding customer:", error);
    res.status(500).json({ error: "Failed to add customer" });
  }
});
app.delete("/customer/:id", async (req, res) => {
  const { id } = req.params;
  try {
    // Execute the query to delete the customer from the database
    await sequelize.query("DELETE FROM customer WHERE cid = ?", {
      replacements: [id],
      type: sequelize.QueryTypes.DELETE,
    });

    // Assuming no error was thrown, we can assume the customer was successfully deleted
    res.status(200).json({ message: "Customer deleted successfully" });
  } catch (error) {
    console.error("Error removing customer:", error);
    // Send an error response with a 500 status code
    res.status(500).json({ error: "Internal Server Error" });
  }
});

//BrandStock table Working
app.get("/brandStock", async (req, res) => {
  const { id } = req.params;
  try {
    const results = await sequelize.query("SELECT * FROM BrandStockView");
    console.log("Brand Stock:", results);
    res.json(results);
  } catch (error) {
    console.error("Error executing query", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});
app.post("/brandStock", async (req, res) => {
  try {
    // Extract the data from the request body
    const { id, bname, bcity, item, quantity } = req.body;

    // Check if a record with the same bname and bcity already exists
    const existingRecord = await sequelize.query(
      "SELECT * FROM supplierStock WHERE siD = 1 AND bName = ? AND bCity = ? AND iTem = ?",
      {
        replacements: [bname, bcity, item],
        type: sequelize.QueryTypes.SELECT,
      }
    );
    if (existingRecord.length > 0) {
      return res.status(409).json({ message: "Record already exists" });
    }

    // Insert the data into the database
    const result = await sequelize.query(
      "INSERT INTO supplierStock (sID, bName, bCity, iTem, Quantity) VALUES (1, ?, ?, ?, ?)",
      {
        replacements: [bname, bcity, item, quantity],
        type: sequelize.QueryTypes.INSERT,
      }
    );

    console.log("Data inserted successfully:", result);

    // Send a success response
    res.status(201).json({ message: "Product added successfully" });
  } catch (error) {
    console.error("Error adding product:", error);
    // Send an error response
    res.status(500).json({ error: "Internal Server Error" });
  }
});

//SupplierStock table working
app.get("/supplierStock", async (req, res) => {
  const { id } = req.params;
  try {
    const results = await sequelize.query(
      "SELECT * FROM Supplier_Stock_Info WHERE SID = 1"
    );
    console.log("Supplier Stock:", results);
    res.json(results);
  } catch (error) {
    console.error("Error executing query", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});
app.delete("/supplierStock/:id/:bname/:bcity/:item", async (req, res) => {
  const { id, bname, bcity, item } = req.params;
  try {
    // Perform the deletion operation using a DELETE query
    const result = await sequelize.query(
      "DELETE FROM supplierStock WHERE sid = :id AND bname = :bname AND bcity = :bcity AND item = :item",
      {
        replacements: { id: id, bname: bname, bcity: bcity, item: item },
        type: sequelize.QueryTypes.DELETE,
      }
    );

    // Check if any rows were affected
    if (result[1] > 0) {
      // If at least one row was deleted successfully, send a success response
      res.status(200).json({ message: "Product removed successfully" });
    } else {
      // If no rows were deleted (product not found), send a not found response
      res.status(404).json({ message: "Product not found" });
    }
  } catch (error) {
    console.error("Error removing product:", error);
    // Send an error response with a 500 status code
    res.status(500).json({ error: "Internal Server Error" });
  }
});

//Purchasing table Working
app.get("/purchaseOrder", async (req, res) => {
  const { id } = req.params;
  try {
    const results = await sequelize.query("SELECT * FROM purchasingView");
    //console.log('Purchase Order:', results);
    res.json(results);
  } catch (error) {
    console.error("Error executing query", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

app.post("/purchaseOrder", (req, res) => {
  const newOrder = req.body;
  sequelize.query(
    "INSERT INTO Purchasing SET ?",
    newOrder,
    (error, results, fields) => {
      if (error) {
        console.error("Error inserting purchase order:", error);
        res.status(500).json({ message: "Internal server error" });
      } else {
        res.status(201).json({ message: "Purchase order added successfully" });
      }
    }
  );
});
app.delete("/purchaseOrder/:id", async (req, res) => {
  const { id } = req.params;

  try {
    // Execute a raw SQL update query to update the pstatus of the purchasing record
    const [updatedCount] = await sequelize.query(
      `Delete from purchasing WHERE cID = :id`,
      {
        replacements: { id: id },
        type: sequelize.QueryTypes.UPDATE,
      }
    );

    if (updatedCount > 0) {
      // If at least one record was updated, send a success response
      res
        .status(200)
        .json({ message: "Purchase order marked as completed successfully" });
    } else {
      // If no record was updated, send a 404 response
      res.status(404).json({ error: "Purchase order not found" });
    }
  } catch (error) {
    console.error("Error marking order as completed:", error);
    // Send an error response with a 500 status code
    res.status(500).json({ error: "Internal Server Error" });
  }
});
app.patch("/purchaseOrder/:id", async (req, res) => {
  const { id } = req.params;

  try {
    // Execute a raw SQL update query to update the pstatus of the purchasing record
    const [updatedCount] = await sequelize.query(
      `UPDATE purchasing SET pstatus = 'completed' WHERE cID = :id`,
      {
        replacements: { id: id },
        type: sequelize.QueryTypes.UPDATE,
      }
    );

    if (updatedCount > 0) {
      // If at least one record was updated, send a success response
      res
        .status(200)
        .json({ message: "Purchase order marked as completed successfully" });
    } else {
      // If no record was updated, send a 404 response
      res.status(404).json({ error: "Purchase order not found" });
    }
  } catch (error) {
    console.error("Error marking order as completed:", error);
    // Send an error response with a 500 status code
    res.status(500).json({ error: "Internal Server Error" });
  }
});

// Fetch customer names
app.get("/customerList", async (req, res) => {
  try {
    const results = await sequelize.query(
      "SELECT cname FROM customerView WHERE sID = 1",
      {
        type: sequelize.QueryTypes.SELECT,
      }
    );
    const customerNames = results.map((result) => result.cname);
    console.log("Customers:", customerNames);
    res.json(customerNames);
  } catch (error) {
    console.error("Error fetching customers:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});
// Fetch brands
app.get("/brandsList", async (req, res) => {
  try {
    // Query the database to fetch brands
    const [results, metadata] = await sequelize.query(
      "SELECT * FROM brandDetail"
    );
    const brandNames = results.map((result) => result.bname);
    console.log("BrandsName:", brandNames);
    res.json(brandNames);
  } catch (error) {
    console.error("Error fetching brands:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});
// Fetch cities
app.get("/citiesList", async (req, res) => {
  try {
    const selectedBrand = req.query.brand; // Use req.query to get query parameters
    console.log("Value: ", selectedBrand);
    // Execute the query using Sequelize
    const results = await sequelize.query(
      `SELECT DISTINCT bcity FROM SupplierStock WHERE bname LIKE :brand`,
      {
        replacements: { brand: `%${selectedBrand}%` }, // Use :brand as a placeholder
        type: sequelize.QueryTypes.SELECT,
      }
    );
    const city = results.map((result) => result.bcity);
    console.log("Cities:", city);
    res.json(city);
  } catch (error) {
    console.error("Error fetching cities:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});
// Fetch items
app.get("/items", async (req, res) => {
  try {
    const selectedBrand = req.query.brand; // Use req.query to get query parameters

    // Execute the query using Sequelize
    const results = await sequelize.query(
      `SELECT * FROM supplierstock WHERE bname LIKE :brand`,
      {
        replacements: { brand: `%${selectedBrand}%` }, // Use :brand as a placeholder
        type: sequelize.QueryTypes.SELECT,
      }
    );
    const itemNames = results.map((result) => result.item);
    console.log("Items:", itemNames);
    res.json(itemNames);
  } catch (error) {
    console.error("Error fetching items:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});
// Fetch categories
app.get("/categoryList", async (req, res) => {
  try {
    const selectedItem = req.query.item; // Use req.query to get query parameters

    // Execute the query using Sequelize
    const results = await sequelize.query(
      `SELECT * FROM brandstock WHERE item LIKE :item`,
      {
        replacements: { item: `%${selectedItem}%` }, // Use :brand as a placeholder
        type: sequelize.QueryTypes.SELECT,
      }
    );
    const categoryNames = results.map((result) => result.category);
    console.log("Category:", categoryNames);
    res.json(categoryNames);
  } catch (error) {
    console.error("Error fetching items:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});
// Fetch price
app.get("/priceData", async (req, res) => {
  try {
    const selectedItem = req.query.item; // Use req.query to get query parameters

    // Execute the query using Sequelize
    const results = await sequelize.query(
      `SELECT * FROM brandstock WHERE item LIKE :item`,
      {
        replacements: { item: `%${selectedItem}%` }, // Use :brand as a placeholder
        type: sequelize.QueryTypes.SELECT,
      }
    );
    const priceValue = results.map((result) => result.price);
    console.log("Price:", priceValue);
    res.json(priceValue);
  } catch (error) {
    console.error("Error fetching items:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

// Root route for testing
app.get("/", (req, res) => {
  res.send("<h1>Supplier Management API is running!</h1><p>Try <a href='/brands'>/brands</a></p>");
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});

// IMPORTANT FOR VERCEL: Export the app
module.exports = app;
