import importlib
import helpers
importlib.reload(helpers)

import helpers as h
print(h.mean([1, 2, 3]))
print(h.random_int(10, 20))
print(h.timestamp())

# Flight Route Data Analysis & Exploration

# This notebook provides a structured, end‑to‑end exploratory data analysis (EDA)
# of the US Airline Flight Routes dataset. The goal is to understand route
# patterns, airport connectivity, carrier behavior, and key operational trends.

# We combine clear narrative storytelling with reproducible code to make the
# analysis easy to follow and extend.
## Project Overview

# Airline route data contains rich information about airports, carriers, distances,
# and flight frequencies. To extract meaningful insights, we follow a structured
# workflow:

# 1. Load and inspect the dataset  
# 2. Clean and standardize columns  
# 3. Explore distributions and correlations  
# 4. Visualize route patterns  
# 5. Summarize findings and propose next steps  

# Each section includes narrative context explaining *why* the step matters.
## Step 1 — Load the Dataset

# We begin by loading the raw dataset and performing an initial inspection.
# This helps us understand the shape, column types, and potential issues such
# as missing values or inconsistent formatting.

# create a p