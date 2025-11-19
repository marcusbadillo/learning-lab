import os

import streamlit as st
from bedrock_utils import generate_response, query_knowledge_base, valid_prompt
from dotenv import load_dotenv

# ----------------------------------------------------------
# CONFIGURATION
# ----------------------------------------------------------
load_dotenv()  # loads values from .env into environment

kb_id_output = os.getenv("KB_ID", "")  # fallback to empty string if missing

# ------------------------------------------------------------
# Streamlit application serving as a simple chat UI for AWS
# Bedrock. It interacts with both a Knowledge Base (RDS/S3)
# and a selected LLM model for generating responses.
# ------------------------------------------------------------

# App title
st.title("Bedrock Chat Application")

# ------------------------------------------------------------
# Sidebar configuration
# Allows the user to select the model, KB ID, and sampling params.
# Temperature controls randomness (higher = more creative).
# top_p limits the probability pool used during token sampling.
# ------------------------------------------------------------
st.sidebar.header("Configuration")

model_id = st.sidebar.selectbox(
    "Select LLM Model",
    [
        "anthropic.claude-3-haiku-20240307-v1:0",
        "anthropic.claude-3-5-sonnet-20240620-v1:0",
    ],
)

# ID of the Bedrock Knowledge Base to query
kb_id = st.sidebar.text_input("Knowledge Base ID", kb_id_output)

# If user did NOT enter a KB ID OR your default is empty, show a helper link
if not kb_id or kb_id.strip() == "":
    st.sidebar.markdown(
        "[Find your KB ID](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-bedrock.html#bedrock-console)"
    )
# Sampling parameters for model generation
temperature = st.sidebar.select_slider("Temperature", [i / 10 for i in range(0, 11)], 1)

top_p = st.sidebar.select_slider("Top_P", [i / 1000 for i in range(0, 1001)], 1)

# ------------------------------------------------------------
# Maintain chat history using Streamlit session state
# ------------------------------------------------------------
if "messages" not in st.session_state:
    st.session_state.messages = []

# Render previous messages
for message in st.session_state.messages:
    with st.chat_message(message["role"]):
        st.markdown(message["content"])

# ------------------------------------------------------------
# Main chat input and response flow
# ------------------------------------------------------------
if prompt := st.chat_input("What would you like to know?"):
    # Store and display user message
    st.session_state.messages.append({"role": "user", "content": prompt})
    with st.chat_message("user"):
        st.markdown(prompt)

    # Validate prompt for selected model
    if valid_prompt(prompt, model_id):
        # ------------------------------------------------------------
        # Query the Bedrock Knowledge Base for relevant context
        # ------------------------------------------------------------
        kb_results = query_knowledge_base(prompt, kb_id)

        # Extract text chunks from retrieved results
        context = "\n".join([result["content"]["text"] for result in kb_results])

        # ------------------------------------------------------------
        # Construct final prompt and send to the LLM
        # ------------------------------------------------------------
        full_prompt = f"Context: {context}\n\nUser: {prompt}\n\n"
        response = generate_response(full_prompt, model_id, temperature, top_p)

    else:
        # Fallback response if prompt is invalid for chosen model
        response = "I'm unable to answer this, please try again."

    # ------------------------------------------------------------
    # Display model's response and store it in conversation history
    # ------------------------------------------------------------
    with st.chat_message("assistant"):
        st.markdown(response)

    st.session_state.messages.append({"role": "assistant", "content": response})
