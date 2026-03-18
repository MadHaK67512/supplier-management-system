window.onload = async function () {
  try {
    const response = await fetch(`${API_BASE}/customer/1`);
    if (!response.ok) {
      throw new Error("Failed to fetch data");
    }
    const data = await response.json(); // Array of customer objects
    console.log("Customers:", data);

    const tbody = document.querySelector("tbody");
    tbody.innerHTML = ""; // Clear existing rows

    // Iterate over each customer object and populate table rows
    data.forEach((customer) => {
      const row = document.createElement("tr");
      row.innerHTML = `
                <td>${customer.cid}</td>
                <td>${customer.cname}</td>
                <td>${customer.cemail}</td>
                <td>${customer.caddress}</td>
                <td><button class="button" onclick="removeCustomer('${customer.cid}')">Remove</button></td>
            `;
      tbody.appendChild(row);
    });
  } catch (error) {
    console.error("Error fetching data:", error);
  }
};

// Function to remove a customer from the table and database
async function removeCustomer(customerID) {
  try {
    const response = await fetch(
      `${API_BASE}/customer/${customerID}`,
      {
        method: "DELETE",
      }
    );

    if (!response.ok) {
      throw new alert("Failed to remove customer");
    }

    // Display alert when customer is successfully removed
    alert("Customer removed successfully!");
    location.reload();
  } catch (error) {
    console.alert("Error removing customer:", error);
  }
}

document.addEventListener("DOMContentLoaded", function () {
  // Function to open the modal when the "Add" button is clicked
  document.getElementById("addButton").addEventListener("click", function () {
    document.getElementById("modal").style.display = "block"; // Display the modal
  });

  // Function to close the modal when clicking outside of it
  window.onclick = function (event) {
    const modal = document.getElementById("modal");
    if (event.target == modal) {
      modal.style.display = "none"; // Hide the modal
    }
  };

  // Add event listener for form submission
  document
    .getElementById("customerForm")
    .addEventListener("submit", function (event) {
      event.preventDefault(); // Prevent default form submission
      console.log("Submit button clicked");

      // Get form data
      const customerName = document.getElementById("customerName").value;
      const email = document.getElementById("email").value;
      const address = document.getElementById("address").value;

      // Create customer object
      const customer = {
        cname: customerName,
        cemail: email,
        caddress: address,
      };

      // Send data to the server
      fetch(`${API_BASE}/customer`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(customer),
      })
        .then((response) => {
          if (!response.ok) {
            throw new Error("Failed to add customer");
          }
          alert("Customer added successfully!");
          document.getElementById("modal").style.display = "none"; // Close the modal
          location.reload(); // Reload the page to update the customer list
        })
        .catch((error) => {
          console.error("Error adding customer:", error);
        });
    });
});
