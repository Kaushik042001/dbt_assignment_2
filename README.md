# Welcome to my new dbt project!

## Using the starter project

## Resources:

- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

# Airbnb Analytics DBT Project

## 📖 Overview

This project uses DBT to transform Airbnb data for analytics. It processes listings, hosts, reviews, and booking data.

## 🚀 Getting Started

# Setup Instructions

## 🚀 **Step 1: Load Airbnb Dataset into Snowflake**

### 📥 **1.1 Download the Dataset**

- Download Airbnb data from **[Inside Airbnb](http://insideairbnb.com/get-the-data.html)**.
- Choose a dataset for a specific city or region.
- Ensure the dataset is in **CSV format**.

---

### 🏗 **1.2 Set Up Snowflake Environment**

#### **1.2.1 Create a Snowflake Account**

If you don’t already have a Snowflake account, sign up for a **free trial** at [Snowflake](https://signup.snowflake.com/).

## **Step 2: Python, Virtualenv Setup, and DBT Installation**

### **2.1: Python Installation**

Download and install **Python 3.10.7** (recommended) from the following link:

🔗 [Python 3.10.7 Installer (64-bit)](https://www.python.org/ftp/python/3.10.7/python-3.10.7-amd64.exe)

> **Note:** Ensure you are using **Python 3.11** or lower, as newer versions may not be compatible with some `dbt` packages.

---

### **2.2: Virtualenv Setup & DBT Installation - Windows**

### **1️⃣ Create a Virtual Environment**

Open windows command prompt and run the following commands to create virtual environment:

```sh
cd Desktop
mkdir course
cd course

virtualenv venv
venv\Scripts\activate
```

### **2️⃣ dbt installation**

```sh
cd course
virtualenv venv
. venv/bin/activate
pip install dbt-snowflake==1.9.0 # adjust accordind to compatibility
```

### \*\*3️⃣ dbt setup

Initialize the dbt profiles folder on Windows:

```sh
# create directory to store profiles
mkdir %userprofile%\.dbt

# Create a dbt project (all platforms):
dbt init dbtlearn
```

## **Step 3: Setting up Github Integration**

Follow these steps to set up GitHub in your dbt project:

```sh
# Navigate to your dbt project directory
cd path/to/your/dbt_project

# Initialize a new Git repository
git init

# Make an initial commit
git add .
git commit -m "initial commit"

# Add a remote repository (replace with your actual GitHub repo URL)
git remote add origin https://github.com/your-username/your-dbt-repo.git

# Push the changes to remote repository,
git push -u origin main

# Create branch development which will be used by developer
git branch development

# Always use development branch to for development
git checkout development
```

> **Note:** I used `main` branch as my production branch for deployment.

After this the project setup is complete and then we can start the development.

# 📘 Airbnb dbt Models Documentation

# Source Models Documentation

This document explains the source models used in the dbt project for Airbnb data processing. The models extract and transform raw data from the `assignment_2` dataset.

## Source Models

### **1️⃣ `raw_hosts`**

This model extracts and transforms the hosts' data from the `hosts` source table.

#### **Columns:**

- **`host_id`**: Unique identifier for each host.
- **`host_name`**: Name of the host.
- **`is_superhost`**: Indicates whether the host is a superhost (`t/f/unknown`).
- **`created_at`**: Timestamp indicating when the host joined the platform.
- **`updated_at`**: Timestamp indicating when the host information was last scraped.

---

### **2️⃣ `raw_listings`**

This model extracts and transforms the listings' data from the `listings` source table.

#### **Columns:**

- **`listing_id`**: Unique identifier for each listing.
- **`listing_url`**: URL link to the Airbnb listing.
- **`listing_name`**: Name of the Airbnb listing.
- **`room_type`**: Type of room (Private room, Entire home/apt, Shared room, Hotel room).
- **`minimum_nights`**: Minimum number of nights required for booking.
- **`host_id`**: Foreign key linking to the host.
- **`price_str`**: Price per night for the listing.
- **`created_at`**: Timestamp when the listing was created.
- **`updated_at`**: Timestamp when the listing information was last updated.

---

### **3️⃣ `raw_reviews`**

This model extracts and transforms the reviews' data from the `reviews` source table.

#### **Columns:**

- **`listing_id`**: Unique identifier for the listing being reviewed.
- **`review_date`**: Date when the review was posted.
- **`reviewer_name`**: Name of the reviewer (derived from `neighbourhood_cleansed`).
- **`review_text`**: Review content (derived from `neighborhood_overview`).
- **`review_sentiment`**: Sentiment rating of the review, extracted from `review_scores_rating`.

---

## 📌 **Dimension Models**

### 1️⃣ `dim_hosts_cleansed`

- **Description:** Cleaned and transformed hosts data.
- **Key Columns:**
  - `host_id`: Unique identifier for each host.
  - `host_name`: Name of the host.
  - `is_superhost`: Indicates if the host is a superhost (`t`, `f`, `unknown`).
  - `created_at`: Timestamp when the host was created.
  - `updated_at`: Timestamp when the host data was last updated.

### 2️⃣ `ranked_hosts`

- **Description:** Retrieves the latest record for each host based on the most recent `created_at` timestamp.
- **Key Columns:**
  - `host_id`: Unique identifier for the host.
  - `rn`: Row number assigned based on the latest `created_at` timestamp per host (only `1` is selected).

### 3️⃣ `dim_listings_cleansed`

- **Description:** Cleaned and transformed Airbnb listings data.
- **Key Columns:**
  - `listing_id`: Unique identifier for each listing.
  - `listing_name`: Name of the listing.
  - `room_type`: Type of room (e.g., Private room, Entire home/apt, etc.).
  - `price`: Price per night.
  - `host_id`: Foreign key referencing `dim_hosts_cleansed`.

### 4️⃣ `dim_reviews_cleansed`

- **Description:** Cleaned and transformed reviews data.
- **Key Columns:**
  - `listing_id`: Identifier for the listing being reviewed.
  - `review_date`: Date of the review.
  - `reviewer_name`: Name of the reviewer.
  - `review_sentiment`: Sentiment score of the review (rounded integer).

## 📊 **Fact Models**

### 5️⃣ `count_hosts_by_month_year`

- **Description:** Tracks the number of hosts created per month for each year.
- **Key Columns:**
  - `month_name`: Name of the month (e.g., Jan, Feb, etc.).
  - `year`: Year corresponding to the data.
  - `host_count`: Total number of hosts created in the given month.

### 6️⃣ `price_metrics`

- **Description:** Displays price-related metrics grouped by listing name.
- **Key Columns:**
  - `listing_name`: Name of the listing.
  - `avg_price`: Average price of the listing.
  - `total_price`: Total price calculated for the listing.

### 7️⃣ `review_aggregates`

- **Description:** Aggregated review metrics, including total reviews, average sentiment, and latest review date.
- **Key Columns:**
  - `listing_id`: Unique identifier for the listing.
  - `total_reviews`: Total number of reviews.
  - `avg_review_sentiment`: Average sentiment score of reviews.
  - `latest_review_date`: Most recent review date.

## 🔥 **Final Model**

### 8️⃣ `final_airbnb_listings`

- **Description:** Consolidated Airbnb listings combining listings, hosts, and reviews.
- **Key Columns:**
  - `listing_id`, `listing_url`, `listing_name`, `room_type`, `price`, `host_id`, `host_name`, `is_superhost`
  - `review_date`, `reviewer_name`, `review_text`, `review_sentiment`

### 9️⃣ `average_nightly_rate`

- **Description:** Calculates the average nightly rate for Airbnb listings.
- **Key Columns:**
  - `listing_id`: Unique identifier for the listing.
  - `listing_count`: Total number of listings available.
  - `total_price`: Total price accumulated for the listing.
  - `available_nights`: Number of nights the listing is available.
  - `average_nightly_rate`: Computed as `total_price / available_nights` (NULL if `available_nights` is zero).

---

# Macros

## 1. `calculate_price_metrics(group_by_column)`

### Purpose:

This macro calculates price-related metrics for Airbnb listings by grouping data based on the specified column. It provides insights into the number of listings, average price, total price, and the total available nights.

### SQL Logic:

- Groups listings by the specified column (e.g., `listing_name`).
- Counts the number of listings (`listing_count`).
- Calculates the average price of listings (`avg_price`).
- Computes the total accumulated price (`total_price`).
- Sums up the `minimum_nights` to get available nights (`available_nights`).
- Filters out listings where `price` is NULL.

### Use Case:

## This macro is useful for generating aggregated price reports based on different groupings, such as by listing name, host, or room type.

## 2. `count_hosts_by_month(year)`

### Purpose:

This macro calculates the number of hosts who joined the platform in each month for a given year.

### SQL Logic:

- Extracts the month from the `created_at` timestamp.
- Formats the month name to a three-letter format (e.g., "Jan", "Feb").
- Counts the number of unique hosts who joined in each month.
- Filters data based on the provided `year` argument.
- Groups by month and orders the results in chronological order.

### Use Case:

## This macro helps in understanding the seasonality of host sign-ups, allowing businesses to analyze trends over time.

## 3. `get_years_from_created_at()`

### Purpose:

This macro dynamically retrieves the distinct years from the `created_at` column in the `dim_hosts_cleansed` model.

### SQL Logic:

- Runs a query to extract unique years from the `created_at` column.
- Sorts the years in ascending order.
- Uses Jinja's `run_query` function to execute the query at runtime.
- Returns the retrieved years as a list.
- Handles execution context to ensure it runs only during query execution.

### Use Case:

## This macro is particularly useful when iterating over different years in dbt models or reports, allowing dynamic and flexible queries without hardcoding year values.

# dbt Snapshots for Airbnb Data

## Overview

This document explains the dbt snapshots created for tracking changes in Airbnb host and listing data over time. Snapshots enable us to capture historical changes in records, ensuring we maintain a history of updates to important attributes.

## Purpose of Snapshots

Snapshots allow us to:

- Track changes in key attributes of hosts and listings.
- Maintain historical records of changes over time.
- Ensure we have accurate insights into when data was modified.
- Support audit requirements and historical trend analysis.

## Snapshot: `raw_hosts_snapshot`

### Definition

The `raw_hosts_snapshot` tracks changes in host details using a timestamp-based strategy.

### Configuration:

- `target_schema='dev'` - Stores snapshots in the `dev` schema.
- `unique_key='unique_id'` - Uniquely identifies each record using a surrogate key.
- `strategy='timestamp'` - Uses the `updated_at` timestamp to track changes.
- `updated_at='updated_at'` - Defines which column indicates an update.
- `invalidate_hard_deletes=True` - Marks deleted records as invalidated instead of removing them.

### Columns Tracked:

- `host_id` - Unique identifier for the host.
- `host_name` - Name of the host.
- `is_superhost` - Indicates if the host is a superhost.
- `created_at` - Timestamp when the host joined.
- `updated_at` - Last update timestamp.

### Unique Identifier:

A surrogate key is generated using:

```sql
{{ dbt_utils.generate_surrogate_key(['host_id', 'host_name', 'is_superhost', 'created_at', 'updated_at']) }}
```

This ensures uniqueness even if individual fields change over time.

## Snapshot: `raw_listings_snapshot`

### Definition

The `raw_listings_snapshot` captures changes in listing details, tracking modifications in pricing, availability, and metadata.

### Configuration:

- `target_schema='dev'` - Stores snapshots in the `dev` schema.
- `unique_key='listing_id'` - Uses `listing_id` as the primary key.
- `strategy='timestamp'` - Uses `updated_at` to track modifications.
- `updated_at='updated_at'` - Specifies the update timestamp column.
- `invalidate_hard_deletes=True` - Ensures deleted records are marked invalid.

### Columns Tracked:

- `listing_id` - Unique identifier for the listing.
- `listing_url` - URL of the Airbnb listing.
- `listing_name` - Name of the listing.
- `room_type` - Type of room (e.g., Private room, Entire home, etc.).
- `minimum_nights` - Minimum number of nights required for booking.
- `host_id` - Foreign key referencing the host.
- `price_str` - Price per night for the listing.
- `created_at` - Timestamp when the listing was created.
- `updated_at` - Last update timestamp.

# **DBT Incremental Model: `dim_listings_cleansed`**

## **📌 Overview**

This model processes raw Airbnb listings data from the `src_listings` table and performs:  
✔ Data Cleaning (handling nulls, standardizing values)  
✔ Price Transformation (removing non-numeric characters)  
✔ Incremental Processing (loading only new/updated records)

---

## ** Incremental Strategy**

This model is **incremental**, meaning:

- The first run **loads all data**.
- Subsequent runs **only process new/updated records** (based on `updated_at`).

### ** Incremental Logic:**

```sql
{% if is_incremental() %}
AND updated_at > (SELECT MAX(updated_at) FROM {{ this }})
{% endif %}
```

# **📊 DBT Exposure: Average Nightly Rate Report**

## **📌 Overview**

This DBT **exposure** documents the downstream usage of the `average_nightly_rate` model in a **Looker Studio dashboard**.

---

## **🔹 Exposure Details**

| Attribute         | Value                                                                                                  |
| ----------------- | ------------------------------------------------------------------------------------------------------ |
| **Name**          | `average_nightly_rate_report`                                                                          |
| **Label**         | Average Nightly Rate Report                                                                            |
| **Type**          | Dashboard                                                                                              |
| **Maturity**      | High                                                                                                   |
| **Dashboard URL** | [Looker Studio Report](https://lookerstudio.google.com/reporting/8b2cf0ba-74f6-4db5-abb7-d35575650112) |
| **Description**   | This dashboard tracks the **average nightly rate** for Airbnb listings.                                |
| **Depends On**    | [`average_nightly_rate`](models/analytics/average_nightly_rate.sql)                                    |
| **Owner**         | Data Team                                                                                              |
| **Contact**       | 📧 [data-team@yourcompany.com](mailto:data-team@yourcompany.com)                                       |

---

## **📌 Why Use DBT Exposures?**

✅ **Better Documentation:** Clearly maps the link between transformed data and its **downstream usage**.  
✅ **Data Lineage:** Shows dependencies between **DBT models** and external tools (**e.g., dashboards**).  
✅ **Improved Collaboration:** Helps **BI teams** understand where their data originates.

---

## **📌 How to Add More Exposures?**

To document additional dashboards or reports, add new entries to your **`schema.yml`** under the `exposures` section:

```yaml
exposures:
  - name: <exposure_name>
    label: "<Descriptive Label>"
    type: dashboard
    maturity: <low/medium/high>
    url: "<dashboard_url>"
    description: "<What this dashboard/report does>"
    depends_on:
      - ref('<dbt_model_name>')
    owner:
      name: "<Team or Owner>"
      email: "<Contact Email>"
```

# **🚀 DBT Automation with GitHub Actions**

This repository contains **GitHub Actions workflows** for automating **DBT (Data Build Tool) execution**.  
The workflows ensure **continuous integration (CI/CD), scheduled daily execution, and weekly execution** for DBT models.

---

# **DBT CI/CD Pipeline**

## **Overview**

This GitHub Actions workflow automates the Continuous Integration (CI) process for a dbt project using Snowflake as the data warehouse. The workflow runs on every push and pull request to the `main` branch, ensuring that dbt models, tests, and builds are validated before deployment.

## **Workflow Trigger**

- **Push to `main` branch**: Runs when new commits are pushed to the main branch.
- **Pull requests to `main`**: Runs when a pull request is created or updated.

## **Jobs**

### **1. Checkout Code**

```yaml
- name: Checkout code
  uses: actions/checkout@v3
```

This step pulls the latest version of the repository so that the workflow has access to the dbt project files.

### **2. Create `profiles.yml`**

```yaml
- name: Create profiles.yml
  run: |
    mkdir -p ~/.dbt
    cat > ~/.dbt/profiles.yml <<EOL
    dbt_assignment_2:
      outputs:
        dev:
          type: snowflake
          account: "${{ secrets.DBT_ACCOUNT }}"
          user: "${{ secrets.DBT_USER }}"
          password: "${{ secrets.DBT_PASSWORD }}"
          role: "${{ secrets.DBT_ROLE }}"
          warehouse: "${{ secrets.DBT_WAREHOUSE }}"
          database: "${{ secrets.DBT_DATABASE }}"
          schema: "${{ secrets.DBT_SCHEMA }}"
          threads: 4
      target: dev
    EOL
```

This step generates the `profiles.yml` configuration file required for dbt to connect to Snowflake. It uses GitHub Secrets to securely store credentials.

### **3. Set Up Python**

```yaml
- name: Set up Python
  uses: actions/setup-python@v4
  with:
    python-version: "3.10"
```

This step installs Python 3.10, which is required to run dbt.

### **4. Install dbt**

```yaml
- name: Install dbt
  run: |
  python -m pip install --upgrade pip
  pip install dbt-core==1.9.2 dbt-snowflake==1.9.1
```

This step installs dbt and the Snowflake adapter (`dbt-snowflake`).

### **5. Run dbt Commands**

```yaml
- name: Run dbt commands
  run: |
    dbt debug
    dbt deps
    dbt compile
```

This step executes the following dbt commands:

- `dbt debug`: Ensures the connection to Snowflake is working.
- `dbt deps`: Installs package dependencies.
- `dbt compile`: Prepares SQL queries for execution.
- `dbt run`: Executes the dbt models.

### **6. Run dbt build**

```yaml
- name: Run dbt build
  run: |
    dbt build
```

This step runs dbt tests to validate the data quality and integrity.

### **7. Run dbt Build**

```yaml
- name: Run dbt build
  run: |
    dbt build
```

This step runs `dbt build`, which executes models, tests, snapshots, and seeds in a single command.

---

# **Daily DBT Job**

## **Overview**

This **Daily DBT Job** is a GitHub Actions workflow designed to run **dbt (Data Build Tool)** processes every day at **5 AM UTC**. It automates data transformations, ensuring that data models remain up to date.

## **Trigger Conditions**

This job is triggered by:

- A **scheduled cron job** that runs **daily at 5 AM UTC**.
- A **manual trigger** via GitHub's workflow dispatch feature.

## **Workflow Steps**

### **1. Checkout Code**

```yaml
- name: Checkout code
  uses: actions/checkout@v3
```

Clones the repository.

### **2. Run dbt Commands**

```yaml
- name: Run dbt commands
  run: |
    dbt debug
    dbt deps
    dbt compile
    dbt build
    dbt snapshot
```

Executes dbt commands, including `dbt snapshot` to capture historical changes.

---

# **Weekly DBT Job**

## **Overview**

This GitHub Actions workflow executes a **dbt pipeline** on a **weekly schedule** and allows manual execution when needed.

## **Workflow Triggers**

- **Scheduled Execution:** Runs **every Sunday at 4 AM UTC** (`cron: "0 4 * * 0"`).
- **Manual Execution:** Can be triggered manually (`workflow_dispatch`).

## **Job Steps**

### **1. Checkout Code**

```yaml
- name: Checkout code
  uses: actions/checkout@v3
```

Clones the repository.

### **2. Run dbt Commands**

```yaml
- name: Run dbt commands
  run: |
    dbt debug
    dbt deps
    dbt compile
    dbt build
    dbt run --full-refresh
```

Executes `dbt build` and `dbt run --full-refresh` to completely refresh models weekly.

## **Summary**

This **Weekly DBT Job** ensures **weekly execution** of the dbt pipeline and allows manual execution when needed. It automates the setup, configuration, and execution of dbt models using **Snowflake** as the data warehouse.
