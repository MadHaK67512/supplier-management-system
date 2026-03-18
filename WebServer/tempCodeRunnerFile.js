app.post('/purchaseOrder', (req, res) => {
        const newOrder = req.body;
        sequelize.query('INSERT INTO Purchasing SET ?', newOrder, (error, results, fields) => {
            if (error) {
                console.error('Error inserting purchase order:', error);
                res.status(500).json({ message: 'Internal server error' });
            } else {
                res.status(201).json({ message: 'Purchase order added successfully' });
            }
        });
    });