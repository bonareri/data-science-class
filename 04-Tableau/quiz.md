## Tableau Challenge: Date Granularity Parameter

Build a visualization that allows users to switch between **Year, Month and Day views of sales over time**.

### 1. Create Custom Dates

From **Order Date**, create the following fields:

- Order Date (Year)
- Order Date (Month)
- Order Date (Day)

These will be used to switch between different time levels.

### 2. Create a Parameter

Create a parameter called **Date Granularity** with the following options:

- Year
- Month
- Day

### 3. Create a Calculated Field

Create a calculated field that switches between the three date levels based on the parameter.

Logic:

- If the parameter is **Year**, show Order Date (Year)
- If the parameter is **Month**, show Order Date (Month)
- If the parameter is **Day**, show Order Date (Day)

### 4. Create the Visualization

Build a **Line Chart** using the following fields:

- Columns - Date (Calculated Field)
- Rows - Sales

### 5. Format the Date Field

- Convert the **Date field to Continuous**
- Drag the field to **Columns**
- Change it to **Exact Date**

### 6. Show the Parameter

Display the **Date Granularity Parameter** so users can switch between:

- Year view
- Month view
- Day view

Observe how the visualization changes based on the selected level.

### Questions

Answer the following:

1. In which **year** were sales the highest?
2. Which **month** shows the highest sales overall?
3. What patterns do you notice when switching to the **day level**?


