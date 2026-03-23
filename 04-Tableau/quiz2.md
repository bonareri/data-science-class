# Tableau Practice Challenges  
## Calculated Fields, Sets, Set Actions, Parameters & Parameter Actions

### Objective
Apply the concepts learned in class to build **interactive and dynamic visualizations** using:

- Calculated Fields
- Sets
- Set Actions
- Parameters
- Parameter Actions

Dataset: **Sample Superstore**

---

# Challenge 1: Calculated Field – Profit Category

## Task
Create a calculated field called **Profit Category** that classifies orders into:

- High Profit
- Low Profit
- Loss

### Visualization
Create a **Bar Chart**

Fields:
- Profit Category → Columns
- Sales → Rows

### Questions
1. Which profit category contributes the most sales?
2. How many orders fall under **Loss**?

---

# Challenge 2: Calculated Field – Profit Ratio

## Task
Create a calculated field called **Profit Ratio** that calculates profit relative to sales.

### Visualization
Create a **Bar Chart**

Fields:
- Category → Columns
- Profit Ratio → Rows

### Questions
1. Which **Category** has the highest profit ratio?
2. Which category has the lowest?

---

# Challenge 3: Sets – Top Sub-Categories

## Task
Create a **Set** that identifies the **Top 5 Sub-Categories by Sales**.

### Visualization
Create a **Bar Chart**

Fields:
- Sub-Category → Rows
- Sales → Columns
- Top Sub-Category Set → Color

### Questions
1. Which sub-categories appear in the **Top 5**?
2. How much sales do they contribute compared to the others?

---

# Challenge 4: Set Action Interaction

## Task
Create an interactive dashboard using **Set Actions**.

### Visualization 1
Bar Chart:
- Sub-Category → Rows
- Sales → Columns

### Visualization 2
Bar Chart:
- Category → Rows
- Profit → Columns

### Steps
1. Create a **Sub-Category Set**.
2. Add both charts to a **Dashboard**.
3. Add a **Set Action** that updates the set when users click on a sub-category.

### Question
How does the second chart change when different sub-categories are selected?

---

# Challenge 5: Parameter – Category Selector

## Task
Create a **Parameter** that allows users to select a category.

Parameter options:
- Furniture
- Technology
- Office Supplies

Create a calculated field that highlights the selected category.

### Visualization
Create a **Bar Chart**

Fields:
- Sub-Category → Rows
- Sales → Columns

### Question
Which sub-category performs best within the selected category?

---

# Challenge 6: Parameter Action

## Task
Create a **Parameter Action** that updates a parameter based on user selection.

### Visualization 1
Bar Chart:
- Category → Columns
- Sales → Rows

### Visualization 2
Line Chart:
- Order Date → Columns
- Sales → Rows

### Steps
1. Create a **Category Parameter**.
2. Add a **Parameter Action** to update the parameter when a category is clicked.
3. Use the parameter in the line chart.

### Question
How does the sales trend change when different categories are selected?

---

# Challenge 7: Sales Target Parameter

## Task
Create a **Sales Target Parameter**.

Example values:
- 500
- 1000
- 5000
- 10000

Create a calculated field that classifies sub-categories as:

- Above Target
- Below Target

### Visualization
Bar Chart:
- Sub-Category → Rows
- Sales → Columns
- Target Status → Color

### Questions
1. Which sub-categories exceed the selected target?
2. How does changing the parameter affect the visualization?

---

# Bonus Challenge: Interactive Dashboard

Build a dashboard that includes:

- At least **2 calculated fields**
- **1 set**
- **1 set action**
- **1 parameter**
- **1 parameter action**

Your dashboard should allow users to:

- Select categories
- Highlight sub-categories
- Compare sales and profit dynamically

---

# Deliverables

Students should submit:

- Screenshots of all visualizations
- The calculated fields they created
- The sets created
- The parameters created
- A screenshot of the final dashboard