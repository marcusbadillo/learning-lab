#!/usr/bin/env python3

# todo - network access bug
"""
Connect to Aurora PostgreSQL using psycopg (psycopg3)
and run a simple test query.

This script is safe, minimal, and follows modern Python best practices.
"""

import json
import os

import boto3
import psycopg
from dotenv import load_dotenv

# ----------------------------------------------------------
# CONFIGURATION
# ----------------------------------------------------------
load_dotenv()  # loads values from .env into environment


def get_env(name: str, default=None, required=False):
    """
    Fetch environment variable with optional default.
    If required=True and missing, raises an error.
    """
    value = os.getenv(name, default)
    if required and (value is None or value == ""):
        raise RuntimeError(f"Missing required environment variable: {name}")
    return value


# ----------------------------------------------------------
# Application configuration
# ----------------------------------------------------------

DB_HOST = get_env("DB_HOST", required=True)
DB_PORT = get_env("DB_PORT", required=True)
DB_NAME = get_env("DB_NAME", required=True)
DB_USER = get_env("DB_USER", required=True)
DB_PASSWORD = get_env("DB_PASSWORD", required=True)
AWS_REGION = get_env("AWS_REGION", required=True)  # safe default
AWS_PROFILE = get_env("AWS_PROFILE", required=True)


# ----------------------------------------------------------
# MAIN
# ----------------------------------------------------------


def connect_and_test():
    """Connect to Aurora and run a test query."""
    print("Connecting to Aurora PostgreSQL...")
    secret_arn = os.environ["DB_SECRET_ARN"]
    region_name = os.environ["AWS_REGION"]
    secrets = boto3.client("secretsmanager", region_name=region_name)
    resp = secrets.get_secret_value(SecretId=secret_arn)
    creds = json.loads(resp["SecretString"])

    print(creds)

    # Build connection parameters
    conn_kwargs = {
        "host": creds["host"],
        "port": creds.get("port", 5432),
        # prefer "dbname", but fall back to "db" if needed
        "dbname": creds.get("db"),
        "user": creds["username"],
        "password": creds["password"],
    }
    print(conn_kwargs)

    try:
        # Connect to DB
        with psycopg.connect(**conn_kwargs) as conn:
            print(f"Connected successfully! {conn.info}")
            with conn.cursor() as cur:
                # Test: show Postgres version
                cur.execute("SELECT version();")
                row = cur.fetchone()
                if row is None:
                    print("No rows returned from version() query.")
                else:
                    version = row[0]
                    print("\nPostgreSQL version:")
                    print(version)

            # with conn.cursor() as cur:
            #     # Run a test SQL command
            #     cur.execute("SELECT version();")
            #     version = cur.fetchone()[0]
            #     print("\nPostgreSQL version:")
            #     print(version)

            #     # OPTIONAL: Create a table for your RAG pipeline
            #     cur.execute("""
            #         CREATE TABLE IF NOT EXISTS test_table (
            #             id SERIAL PRIMARY KEY,
            #             message TEXT
            #         );
            #     """)

            #     cur.execute(
            #         "INSERT INTO test_table (message) VALUES (%s) RETURNING id;",
            #         ("Hello from Aurora!",)
            #     )
            #     new_id = cur.fetchone()[0]
            #     print(f"\nInserted test row with ID: {new_id}")

            #     conn.commit()

    except Exception as e:
        print("\n❌ ERROR connecting to database:")
        print(e)


def get_db_credentials_from_secret(secret_arn: str, region: str = "us-west-2"):
    session = boto3.Session(profile_name="udacity-aws-lab-1")
    client = session.client("secretsmanager", region_name=region)

    resp = client.get_secret_value(SecretId=secret_arn)
    secret_str = resp["SecretString"]
    data = json.loads(secret_str)

    return {
        "host": data["host"],
        "port": data.get("port", 5432),
        "dbname": data.get("dbname", "myapp"),
        "user": data["username"],
        "password": data["password"],
    }


if __name__ == "__main__":
    connect_and_test()
    # secret_arn = os.getenv("DB_SECRET_ARN")  # set this once from terraform output
    # if not secret_arn:
    #     raise RuntimeError("DB_SECRET_ARN environment variable is not set.")
    # creds = get_db_credentials_from_secret(secret_arn)
    # print(creds)  # don’t do this in real prod, just for debugging
