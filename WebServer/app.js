const express = require('express');
const morgan = require('morgan');
const cors = require('cors');
const crypto = require('crypto');
const pg = require('pg'); // Explicitly import pg for Vercel serverless bundler

const app = express();

const PORT =4000;
app.use(morgan('tiny'));
app.use(express.json());
app.use(cors()); // Enable CORS

const { Sequelize } = require('sequelize');

const databaseUrl = process.env.DATABASE_URL || 'postgres://postgres:67512kings@localhost:5432/SupplierManagementDB';

const sequelize = new Sequelize(databaseUrl, {
    dialect: 'postgres',
    dialectOptions: databaseUrl.includes('localhost') ? {} : {
        ssl: {
            require: true,
            rejectUnauthorized: false
        }
    }
});
async function connectionDB() {
    try {
        await sequelize.authenticate();
        console.log('Connection has been established successfully.');
        
        await sequelize.query(`
            CREATE TABLE IF NOT EXISTS app_users (
                id SERIAL PRIMARY KEY,
                username VARCHAR(100) UNIQUE NOT NULL,
                email VARCHAR(255) UNIQUE NOT NULL,
                password VARCHAR(255) NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
        `);
        console.log('User table initialized.');
    } catch (error) {
        console.error('Unable to connect to the database:', error);
    }
}

connectionDB();

//Supplier routes


    //brand table working
    app.get('/brands', async (req, res) => {
    try {
        const [results, metadata] = await sequelize.query('SELECT * FROM brandDetail');
        console.log('Brands:', results);
        res.json(results);
    } catch (error) {
        console.error('Error executing query', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
    });
    app.post('/linkedbrand', async (req, res) => {
    try {
        // Extract the data from the request body
        const { sId, bname, bcity } = req.body;
  
        // Check if a record with the same bname and bcity already exists
        const existingRecord = await sequelize.query(
            'SELECT * FROM linkedbrand WHERE sId = ? AND bName = ? AND bCity = ?',
            {
                replacements: [sId, bname, bcity],
                type: sequelize.QueryTypes.SELECT
            }
        );
        
        if (existingRecord.length > 0) {
            return res.status(409).json({ message: 'Record already exists' });
          }
        // Insert the data into the database
        const result = await sequelize.query(
            'INSERT INTO linkedbrand (sId, bName, bCity) VALUES (?, ?, ?)',
            {
                replacements: [sId, bname, bcity],
                type: sequelize.QueryTypes.INSERT
            }
        );
  
        console.log('Data inserted successfully:', result);
        
        // Send a success response
        res.status(200).json({ message: 'Data inserted successfully' });
    } catch (error) {
        console.error('Error inserting data:', error);
        // Send an error response
        res.status(500).json({ error: 'Internal Server Error' });
    }
    });



    //linkedbrand table working
    app.get('/linkedBrand/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const results = await sequelize.query('SELECT * FROM linkedBrandView WHERE sID = ?', {
            replacements: [id],
            type: sequelize.QueryTypes.SELECT
        });
        console.log('LinkedBrands:', results);
        res.json(results);
    } catch (error) {
        console.error('Error executing query', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
    });
    app.delete('/linkedBrand/:sid/:bname/:bcity', async (req, res) => {
    const { sid, bname, bcity } = req.params;
    try {
        // Execute the raw SQL query to delete the linked brand from the database
        const result = await sequelize.query(
            'DELETE FROM linkedbrand WHERE sID = ? AND bName = ? AND bCity = ?',
            {
                replacements: [sid, bname, bcity],
                type: sequelize.QueryTypes.DELETE
            }
        );
          res.sendStatus(200); // Send a success response if data was deleted
    } catch (error) {
        console.error('Error removing brand:', error);
        res.status(500).send('Internal Server Error'); // Send an error response if something goes wrong
    }
    });



    //customer table Working
    app.get('/customer/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const results = await sequelize.query('SELECT * FROM customerView WHERE sID = ?', {
            replacements: [id],
            type: sequelize.QueryTypes.SELECT
        });
        console.log('Customer:', results);
        res.json(results);
    } catch (error) {
        console.error('Error executing query', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
    });
    app.post('/customer', async (req, res) => {
    const { cname, cemail, caddress, sID } = req.body;
  
    // Validate required fields
    if (!cname || !cemail || !caddress || !sID) {
      return res.status(400).json({ error: 'All fields are required' });
    }
  
    try {
      // Insert new customer record into the database using raw SQL
      const insertQuery = `
        INSERT INTO customer (cname, cemail, caddress, sID) 
        VALUES (?, ?, ?, ?)
      `;
      const [insertedCustomer] = await sequelize.query(insertQuery, {
        replacements: [cname, cemail, caddress, sID],
        type: sequelize.QueryTypes.INSERT,
      });
  
      // Send back the newly created customer object as response
      res.status(201).json({
        cid: insertedCustomer,
        cname,
        cemail,
        caddress,
        sID
      });
    } catch (error) {
      console.error('Error adding customer:', error);
      res.status(500).json({ error: 'Failed to add customer' });
    }
    });
    app.delete('/customer/:id', async (req, res) => {
    const { id } = req.params;
    try {
        // Execute the query to delete the customer from the database
        await sequelize.query('DELETE FROM customer WHERE cid = ?', {
            replacements: [id],
            type: sequelize.QueryTypes.DELETE
        });
  
        // Assuming no error was thrown, we can assume the customer was successfully deleted
        res.status(200).json({ message: 'Customer deleted successfully' });
    } catch (error) {
        console.error('Error removing customer:', error);
        // Send an error response with a 500 status code
        res.status(500).json({ error: 'Internal Server Error' });
    }
    });



   //BrandStock table Working
    app.get('/brandStock', async (req, res) => {
    const { id } = req.params;
    try {
        const results = await sequelize.query('SELECT * FROM BrandStockView');
        console.log('Brand Stock:', results);
        res.json(results);
    } catch (error) {
        console.error('Error executing query', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
    });
    app.post('/brandStock', async (req, res) => {
    try {
        // Extract the data from the request body
        const { id, bname, bcity, item, quantity } = req.body;
  
        // Check if a record with the same bname and bcity already exists
        const existingRecord = await sequelize.query(
            'SELECT * FROM supplierStock WHERE siD = ? AND bName = ? AND bCity = ? AND iTem = ?',
            {
                replacements: [id, bname, bcity, item],
                type: sequelize.QueryTypes.SELECT
            }
        );
        if (existingRecord.length > 0) {
          return res.status(409).json({ message: 'Record already exists' });
        }
  
        // Insert the data into the database
        const result = await sequelize.query(
            'INSERT INTO supplierStock (sID, bName, bCity, iTem, Quantity) VALUES (?, ?, ?, ?, ?)',
            {
                replacements: [id, bname, bcity, item, quantity],
                type: sequelize.QueryTypes.INSERT
            }
        );
  
        console.log('Data inserted successfully:', result);
        
        // Send a success response
        res.status(201).json({ message: 'Product added successfully' });
    } catch (error) {
        console.error('Error adding product:', error);
        // Send an error response
        res.status(500).json({ error: 'Internal Server Error' });
    }
    });



    //SupplierStock table working
    app.get('/supplierStock/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const results = await sequelize.query('SELECT * FROM Supplier_Stock_Info WHERE SID = ?', {
            replacements: [id],
            type: sequelize.QueryTypes.SELECT
        });
        console.log('Supplier Stock:', results);
        res.json(results);
    } catch (error) {
        console.error('Error executing query', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
    });
    app.delete('/supplierStock/:id/:bname/:bcity/:item', async (req, res) => {
        const { id, bname, bcity, item } = req.params;
        try {
            // Perform the deletion operation using a DELETE query
            const result = await sequelize.query('DELETE FROM supplierStock WHERE sid = :id AND bname = :bname AND bcity = :bcity AND item = :item', {
                replacements: { id: id, bname: bname, bcity: bcity, item: item },
                type: sequelize.QueryTypes.DELETE
            });
    
            // Check if any rows were affected
            if (result[1] > 0) {
                // If at least one row was deleted successfully, send a success response
                res.status(200).json({ message: 'Product removed successfully' });
            } else {
                // If no rows were deleted (product not found), send a not found response
                res.status(404).json({ message: 'Product not found' });
            }
        } catch (error) {
            console.error('Error removing product:', error);
            // Send an error response with a 500 status code
            res.status(500).json({ error: 'Internal Server Error' });
        }
    });



    //Purchasing table Working
    app.get('/purchaseOrder/:id', async (req, res) => {
        const { id } = req.params;
        try {
            const results = await sequelize.query('SELECT v.* FROM purchasingView v JOIN customer c ON v.cid = c.cid WHERE c.sid = ?', {
                replacements: [id],
                type: sequelize.QueryTypes.SELECT
            });
            res.json(results);
        } catch (error) {
            console.error('Error executing query', error);
            res.status(500).json({ error: 'Internal Server Error' });
        }
    });
     
    app.post('/purchaseOrder', async (req, res) => {
        try {
            const { cname, bname, bcity, item, quantity } = req.body;
            
            // Find customer id by name
            const customer = await sequelize.query(
                'SELECT cid FROM customer WHERE cname = ? LIMIT 1',
                {
                    replacements: [cname],
                    type: sequelize.QueryTypes.SELECT
                }
            );

            if (!customer || customer.length === 0) {
                return res.status(400).json({ error: 'Customer not found' });
            }

            const cid = customer[0].cid;

            // Insert into purchasing
            await sequelize.query(
                'INSERT INTO purchasing (cid, bname, bcity, item, quantity, pstatus) VALUES (?, ?, ?, ?, ?, ?)',
                {
                    replacements: [cid, bname, bcity, item, quantity, 'pending'],
                    type: sequelize.QueryTypes.INSERT
                }
            );

            res.status(201).json({ message: 'Purchase order added successfully' });
        } catch (error) {
            console.error('Error inserting purchase order:', error);
            res.status(500).json({ error: 'Internal Server Error' });
        }
    });
    app.delete('/purchaseOrder/:cid/:bname/:bcity/:item', async (req, res) => {
        const { cid, bname, bcity, item } = req.params;
        try {
            await sequelize.query(
                'DELETE FROM purchasing WHERE cid = ? AND bname = ? AND bcity = ? AND item = ?',
                {
                    replacements: [cid, bname, bcity, item],
                    type: sequelize.QueryTypes.DELETE
                }
            );
            res.status(200).json({ message: 'Purchase order deleted successfully' });
        } catch (error) {
            console.error('Error removing purchase order:', error);
            res.status(500).json({ error: 'Internal Server Error' });
        }
    });
    app.patch('/purchaseOrder/:cid/:bname/:bcity/:item', async (req, res) => {
        const { cid, bname, bcity, item } = req.params;
        try {
            await sequelize.query(
                "UPDATE purchasing SET pstatus = 'completed' WHERE cid = ? AND bname = ? AND bcity = ? AND item = ?",
                {
                    replacements: [cid, bname, bcity, item],
                    type: sequelize.QueryTypes.UPDATE
                }
            );
            res.status(200).json({ message: 'Purchase order marked as completed successfully' });
        } catch (error) {
            console.error('Error marking order as completed:', error);
            res.status(500).json({ error: 'Internal Server Error' });
        }
    });

        // Fetch customer names
        // Fetch customer names
        app.get('/customerList/:id', async (req, res) => {
            try {
                const { id } = req.params;
                const results = await sequelize.query('SELECT cname FROM customerView WHERE sID = ?', {
                    replacements: [id],
                    type: sequelize.QueryTypes.SELECT
                });
                const customerNames = results.map(result => result.cname);
                console.log('Customers:', customerNames);
                res.json(customerNames);
            } catch (error) {
                console.error('Error fetching customers:', error);
                res.status(500).json({ error: 'Internal Server Error' });
            }
        });
        // Fetch brands
        app.get('/brandsList/:id', async (req, res) => {
            try {
                const { id } = req.params;
                // Query the database to fetch brands that exist in supplier stock
                const [results, metadata] = await sequelize.query('SELECT DISTINCT bname FROM supplierstock WHERE sid = ?', {
                    replacements: [id]
                });
                const brandNames = results.map(result => result.bname);
                console.log('BrandsName:', brandNames);
                res.json(brandNames);
            } catch (error) {
                console.error('Error fetching brands:', error);
                res.status(500).json({ error: 'Internal Server Error' });
            }
        });
        // Fetch cities
        app.get('/citiesList', async (req, res) => {
            try {
                const selectedBrand = req.query.brand; // Use req.query to get query parameters
                console.log('Value: ',selectedBrand);
                // Execute the query using Sequelize
                const results = await sequelize.query(`SELECT DISTINCT bcity FROM SupplierStock WHERE bname LIKE :brand`, {
                    replacements: { brand: `%${selectedBrand}%` }, // Use :brand as a placeholder
                    type: sequelize.QueryTypes.SELECT
                });
                    const city = results.map(result => result.bcity);
                    console.log('Cities:', city);
                    res.json(city);
            } catch (error) {
                console.error('Error fetching cities:', error);
                res.status(500).json({ error: 'Internal Server Error' });
            }
        });
        // Fetch items
        app.get('/items', async (req, res) => {
            try {
                const selectedBrand = req.query.brand; // Use req.query to get query parameters
                
                // Execute the query using Sequelize
                const results = await sequelize.query(`SELECT * FROM supplierstock WHERE bname LIKE :brand`, {
                    replacements: { brand: `%${selectedBrand}%` }, // Use :brand as a placeholder
                    type: sequelize.QueryTypes.SELECT
                });
                const itemNames = results.map(result => result.item);
                console.log('Items:', itemNames);
                res.json(itemNames);
            } catch (error) {
                console.error('Error fetching items:', error);
                res.status(500).json({ error: 'Internal Server Error' });
            }
        });
        // Fetch categories
        app.get('/categoryList', async (req, res) => {    
            try {
                const selectedItem = req.query.item; // Use req.query to get query parameters
                
                // Execute the query using Sequelize
                const results = await sequelize.query(`SELECT * FROM brandstock WHERE item LIKE :item`, {
                    replacements: { item: `%${selectedItem}%` }, // Use :brand as a placeholder
                    type: sequelize.QueryTypes.SELECT
                });
                const categoryNames = results.map(result => result.category);
                console.log('Category:', categoryNames);
                res.json(categoryNames);
            } catch (error) {
                console.error('Error fetching items:', error);
                res.status(500).json({ error: 'Internal Server Error' });
            }
        });
        // Fetch price
        app.get('/priceData', async (req, res) => {    
            try {
                const selectedItem = req.query.item; // Use req.query to get query parameters
                
                // Execute the query using Sequelize
                const results = await sequelize.query(`SELECT * FROM brandstock WHERE item LIKE :item`, {
                    replacements: { item: `%${selectedItem}%` }, // Use :brand as a placeholder
                    type: sequelize.QueryTypes.SELECT
                });
                const priceValue = results.map(result => result.price);
                console.log('Price:', priceValue);
                res.json(priceValue);
            } catch (error) {
                console.error('Error fetching items:', error);
                res.status(500).json({ error: 'Internal Server Error' });
            }
        });
        
            





// User registration endpoint
app.post('/api/signup', async (req, res) => {
    try {
        const { username, email, password } = req.body;

        if (!username || !email || !password) {
            return res.status(400).json({ error: 'All fields are required' });
        }

        // Check if user already exists
        const existingUser = await sequelize.query(
            'SELECT username, email FROM app_users WHERE username = ? OR email = ? LIMIT 1',
            {
                replacements: [username, email],
                type: sequelize.QueryTypes.SELECT
            }
        );

        if (existingUser.length > 0) {
            if (existingUser[0].username === username) {
                return res.status(409).json({ error: 'Username is already taken' });
            } else {
                return res.status(409).json({ error: 'Email is already registered' });
            }
        }

        // Hash the password using SHA-256
        const passwordHash = crypto.createHash('sha256').update(password).digest('hex');

        // Insert new user and get ID
        const [insertResults] = await sequelize.query(
            'INSERT INTO app_users (username, email, password) VALUES (?, ?, ?) RETURNING id',
            {
                replacements: [username, email, passwordHash],
                type: sequelize.QueryTypes.INSERT
            }
        );
        const userId = insertResults[0].id;

        // Auto-create a corresponding supplier profile linked to this user
        await sequelize.query(
            'INSERT INTO supplier (sname, semail, stel, ssalary, user_id) VALUES (?, ?, ?, ?, ?)',
            {
                replacements: [`${username}'s Supplies`, email, '', 100000.00, userId],
                type: sequelize.QueryTypes.INSERT
            }
        );

        res.status(201).json({ message: 'User registered successfully' });
    } catch (error) {
        console.error('Error during registration:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

// User login endpoint
app.post('/api/login', async (req, res) => {
    try {
        const { username, password } = req.body;

        if (!username || !password) {
            return res.status(400).json({ error: 'Username and password are required' });
        }

        // Retrieve user
        const userResult = await sequelize.query(
            'SELECT * FROM app_users WHERE username = ? LIMIT 1',
            {
                replacements: [username],
                type: sequelize.QueryTypes.SELECT
            }
        );

        if (userResult.length === 0) {
            return res.status(401).json({ error: 'Invalid username or password' });
        }

        const user = userResult[0];

        // Hash incoming password and compare
        const incomingHash = crypto.createHash('sha256').update(password).digest('hex');

        if (incomingHash !== user.password) {
            return res.status(401).json({ error: 'Invalid username or password' });
        }

        // Retrieve the linked supplier sID
        const supplierResult = await sequelize.query(
            'SELECT sid FROM supplier WHERE user_id = ? LIMIT 1',
            {
                replacements: [user.id],
                type: sequelize.QueryTypes.SELECT
            }
        );
        const sID = supplierResult.length > 0 ? supplierResult[0].sid : 1;

        res.json({ message: 'Login successful', username: user.username, sID: sID });
    } catch (error) {
        console.error('Error during login:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

if (!process.env.VERCEL) {
    app.listen(PORT, () => {
        console.log(`Server listening on port ${PORT}`);
    });
}

module.exports = app;
