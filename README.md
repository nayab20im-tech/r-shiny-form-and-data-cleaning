# R Shiny Form & Data Cleaning Applications

Two professional **R Shiny applications** demonstrating interactive form handling and CSV data cleaning.  
This project is submitted as an academic assignment and structured following industry-style GitHub practices.

---

## 📌 Project Overview

This repository contains **Assignment 01** by **Nayab Nasir (Roll No: 231980059)**.  
It includes two independent Shiny applications:

- **Task 1:** User Information Form Application  
- **Task 2:** CSV Data Cleaning Tool  

---

## 📁 Project Structure

r-shiny-form-and-data-cleaning/
│
├── task1_user_form.R # Shiny app for collecting user information
├── task2_data_cleaning_app.R # Shiny app for cleaning CSV data
├── README.md # Project documentation


---

## 🚀 Task 1: User Information Form

### 🔹 Description
An interactive Shiny form that collects user information using multiple input controls. The submitted data is validated and displayed in a clean tabular format.

### 🔹 Key Features
- Text, numeric, date, slider, checkbox, and file inputs  
- Password input for sensitive data  
- Age validation (18–55)  
- Submit, Cancel, and Home actions  
- Modal confirmation dialogs  
- Output rendered as a structured table  

### 🔹 File

task1_user_form.R
---

## 🧹 Task 2: CSV Data Cleaning Tool

### 🔹 Description
A Shiny-based data preprocessing tool that allows users to upload CSV files, apply cleaning operations, preview results, and download cleaned datasets.

### 🔹 Key Features
- Upload CSV files with custom delimiter support  
- Preview raw and cleaned data  
- Convert column names to snake_case  
- Remove constant-value columns  
- Drop rows containing missing values (NA)  
- Download cleaned CSV file  

### 🔹 File

task2_data_cleaning_app.R


---

## ▶️ How to Run the Applications

### 1️⃣ Install Required Packages

```r
install.packages(c("shiny", "dplyr", "janitor", "readr"))

2️⃣ Run the Apps

shiny::runApp("task1_user_form.R")
shiny::runApp("task2_data_cleaning_app.R")



