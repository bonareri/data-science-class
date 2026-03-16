# Tableau Visualizations Guide

## 1. Table Calculations

### Running Total
**Visualization:** Line Chart  
- Columns: Order Date  
- Rows: Sales  
- Table Calculation: Running Total

### Percent of Total
**Visualization:** Pie Chart  
- Dimension: Category  
- Measure: Profit  
- Table Calculation: Percent of Total

### Difference
**Visualization:** Highlight Table  
- Dimensions: Category, Order Date, Sub-Category  
- Measure: Sales  
- Table Calculation: Difference

---

## 2. Calculated Fields

### Profitable Field
Create a calculated field to identify profitable records.

Logic:
- If Profit is greater than 0 → Profitable  
- Otherwise → Not Profitable

Example:

```tableau
IF [Profit] > 0 THEN "Profitable"
ELSE "Not Profitable"
END
```

---

## 3. Sets

### Excluding a Sub-Category
**Visualization:** Bar Chart  

Fields:
- Dimension: Sub-Category  
- Measure: Sales  

Steps:
1. Create a **Sub-Category Set**.
2. Exclude **Chairs** from the set.

---

### Customer Profit Analysis

**Visualization:** Bar Chart  

Fields:
- Dimension: Customer Name  
- Measure: Profit

---

## 4. Set Actions

### Sub-Category Interaction

Fields:
- Sub-Category  
- Sales

Steps:
1. Create a **Sub-Category Set**.
2. Go to **Worksheet → Actions → Add Action → Change Set Values**.

---

### Combining Sets and Calculated Fields

Fields:
- Category  
- Sub-Category  
- Profit

Steps:
1. Create a **Hierarchy**: Category → Sub-Category.
2. Create a **Sub-Category Set**.
3. Create a calculated field for **Asymmetric Drill Down**.

Logic:
- If Category Set is selected → Show Sub-Category  
- Otherwise → Show blank

Example 

```tableau
IF [Category Set] THEN [Sub-Category]
ELSE ""
END
```
---

## 5. Parameters

### Category Parameter

Fields:
- Category → Detail
- Order Date → Columns
- Sales → Rows

Steps:
1. Create a **Category Parameter**.
2. Create a calculated field to compare the parameter with Category.

```tableau
[Category Parameter] = [Category]
```

3. Use the calculated field to **Highlight the selected Category**.
4. Sort values **Descending**.
5. Adjust sizes and **reverse the axis if necessary**.

---

### Date Granularity Parameter

Steps:

1. Create **Custom Dates**:
   - Order Date (Year)
   - Order Date (Month)
   - Order Date (Day)

2. Create a **Parameter** with the following options:
   - Year
   - Month
   - Day

3. Create a calculated field that switches between the three date levels.

```tableau
CASE [Date Granularity]

WHEN 'Year' THEN [Order Date (Years)]
WHEN 'Month' THEN [Order Date (Months)]
WHEN 'Day' THEN [Order Date (Days)]

END
```

4. Convert the date field to **Continuous**.

5. Drag the date field to **Columns** and set it to **Exact Date**.

---

## 6. Dynamic Parameters

Example scenario:
- The original dataset has **no Technology category**.
- New data is added later.

Steps:
1. Edit the Parameter.
2. Change it from **Fixed values** to **Update when workbook opens**.

This ensures parameter values automatically update when new data appears.

---

## 7. Parameter Actions

Steps:
1. Go to **Worksheet → Actions**.
2. Add a **Parameter Action**.
3. Set the trigger to **On Hover**.

---

## 8. Tooltips and Viz in Tooltip

### Tooltip Setup

Visualization:
- Category
- Sales (Bar Chart)

Steps:
1. Open the **Tooltip Editor**.
2. Uncheck **Include Command Buttons**.
3. Insert:
   - Data Source Name
   - Data Update Time

---

### Viz in Tooltip

Create a secondary visualization with:
- Category → Detail
- Sales → Rows
- Order Date → Columns

Steps:
1. Return to the main worksheet.
2. Edit the Tooltip.
3. Click **Insert → Sheets → Viz in Tooltip**.
4. Set **Maximum Width = 600**.