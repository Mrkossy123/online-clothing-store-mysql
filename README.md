# Online Clothing Store Database (MySQL)

This repository contains the SQL implementation of a university database assignment for an **online clothing store**. The project focuses on modeling products, customers, shopping carts, product variants (size/color), availability, and integrity constraints using **MySQL**.

## Project Overview

The goal of the assignment is to design and implement the relational database part of a system that supports:

- clothing items sold online,
- customers and their contact information,
- shopping carts created by customers,
- product availability per **size-color combination**,
- integrity constraints such as:
  - primary keys,
  - foreign keys,
  - composite keys,
  - referential actions,
  - example insertions that violate constraints.

The SQL script included in this repository contains:

1. **DDL definitions** for all required tables,
2. **sample data inserts**,
3. **queries to inspect table contents**,
4. **examples of integrity constraint violations**,
5. **examples of update/delete operations** involving foreign keys.

## Assignment Scope

This repository corresponds to the **SQL implementation section** of the assignment (the part starting from question **(γ)**). The ER model and the paper-based relational design are not included here unless added separately.

## Technologies Used

- **MySQL**
- SQL DDL / DML

Recommended version:

- **MySQL 8.0+**

## Repository Structure

```text
.
├── ask5apo_set1_palio_commented.sql   # Main SQL script with improved comments
└── README.md                          # Project documentation
```

## Database Structure

The current implementation includes the following tables:

### 1. `rouxo`
Stores the main clothing items.

**Attributes:**
- `kwdikos` - clothing code
- `perigrafh` - short description
- `timh` - price

### 2. `xarakthristika`
Stores the available **size-color combinations** for each clothing item, along with stock availability.

**Attributes:**
- `kwd` - clothing code
- `xrwma` - color
- `megethos` - size
- `diathesimothta` - number of available pieces

### 3. `pelaths`
Stores customer information.

**Attributes:**
- `kwdikos` - customer code
- `onoma` - name
- `fysikh_diefthynsh` - physical address
- `hlektronikh_diefthynsh` - email address

### 4. `kalathi`
Stores shopping carts created by customers.

**Attributes:**
- `kwdikos_p` - customer code
- `kwdikos_k` - cart code
- `hmeromhnia` - cart creation date

### 5. `afora`
Associates carts with clothing items in a specific size and color.

**Attributes:**
- `kwdikos_pel` - customer code
- `kwdikos_kal` - cart code
- `kwd_rouxou` - clothing code
- `xrwma_rouxou` - color
- `megethos_rouxou` - size

## Integrity Constraints Implemented

The SQL script includes:

- **Primary keys** for entity uniqueness,
- **Composite primary keys** where needed,
- **Foreign keys** for referential integrity,
- **`ON UPDATE CASCADE`** and **`ON DELETE CASCADE`** on selected foreign-key relationships.

## What the Script Demonstrates

The script is organized so that it demonstrates all major parts required in the SQL implementation:

### A. Table creation
Using `CREATE TABLE` statements with:
- suitable data types,
- primary keys,
- foreign keys,
- referential actions.

### B. Data insertion
Using `INSERT INTO` statements to add **three tuples per table**.

### C. Viewing current contents
Using:

```sql
SELECT * FROM table_name;
```

### D. Violating integrity constraints
The script also includes example `INSERT` statements that intentionally violate:
- primary key constraints,
- foreign key constraints.

These are included for testing and educational purposes.

### E. Foreign key behavior on update/delete
The script contains examples showing what happens when parent rows are updated or deleted while child rows reference them.

Because the current schema uses cascading referential actions in several places, related child rows are automatically updated or deleted instead of producing a referential-integrity error.

## How to Run

### Option 1: MySQL Command Line

Run the script with:

```bash
mysql -u your_username -p < ask5apo_set1_palio_commented.sql
```

### Option 2: MySQL Workbench

1. Open MySQL Workbench.
2. Connect to your MySQL server.
3. Open the SQL script file.
4. Execute the script.

## Suggested Execution Flow

To avoid confusion while testing, execute the script in sections:

1. Drop/create the database if needed.
2. Run all `CREATE TABLE` statements.
3. Run valid `INSERT` statements.
4. Run the `SELECT *` queries.
5. Run the invalid `INSERT` statements one by one to inspect the DBMS errors.
6. Run the `UPDATE` / `DELETE` examples and observe cascading behavior.

## Example Learning Outcomes

This project is useful for practicing:

- relational schema implementation,
- mapping conceptual structures into SQL tables,
- composite keys,
- referential integrity,
- constraint violation testing,
- cascading updates and deletes in MySQL.

## Notes

- This repository reflects the **current coursework implementation** of the assignment.
- Some modeling choices in academic exercises can vary depending on the interpretation of the specification.
- The script is intended primarily for **educational purposes**, not as a production-ready e-commerce database.

## Possible Future Improvements

If this repository is extended, useful next steps would be:

- normalize certain design choices further,
- add `NOT NULL` and `CHECK` constraints where appropriate,
- use `DECIMAL` for monetary values,
- add indexes for performance,
- split carts and cart-items in a more production-oriented design,
- include the ER diagram and relational mapping documentation.

## Author
Kossyvakis Konstantinos-Andrianos

University database assignment implementation in MySQL.

---
