# Snowflake Cortex Analyst - LLM Based Text-to-SQL 

This repository contains the setup code and a simple Streamlit-based UI for Snowflake Cortex Analyst. It allows users to interact with a large language model (LLM) to generate SQL queries based on text input, tightly integrated with the Snowflake data ecosystem.

![Cortex Analyst Demo](https://github.com/sarathi-aiml/Cortex-Analyst/blob/main/cortex-overview-2.gif)]

## Features

- **Setup Script**: SQL code to create roles, stages, schemas, and tables in Snowflake for Cortex Analyst.
- **Streamlit UI**: A lightweight, user-friendly interface built with Streamlit to interact with the LLM-based SQL query generation.

## Getting Started

### Prerequisites

- **Snowflake Account**: Ensure you have access to a Snowflake instance with sufficient privileges.
- **Streamlit**: Streamlit in Snowflake.

### Setup

1. Run the SQL setup code (`Cortex-Analyst-Setup.sql`) in your Snowflake account to create the necessary stages, roles, schemas, and tables.
2. Upload the required data (`book_model.yaml` and `Medical_books_clean.csv`) to the stage created during the setup.
Snowflake Cortex Analyst Semantic Model (yaml) Generator:
https://github.com/Snowflake-Labs/semantic-model-generator
3. Configure your Snowflake instance to enable Cortex integration across regions.

### Running the UI

1. Clone this repository.
2. Run the Streamlit UI 

