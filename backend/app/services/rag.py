from langchain_community.vectorstores import FAISS
from langchain_openai import OpenAIEmbeddings
from langchain.chains import RetrievalQA


from langchain_openai import ChatOpenAI
from ..config import settings

def chat_with_document(chunks):
    db = FAISS.from_texts(chunks, OpenAIEmbeddings(openai_api_key=settings.openai_api_key))
    qa = RetrievalQA.from_chain_type(
        llm=ChatOpenAI(openai_api_key=settings.openai_api_key),
        retriever=db.as_retriever()
    )
    return qa

def get_chat_response(query, doc_id):
    # Placeholder: assume chunks are provided or loaded
    chunks = ["Sample resume text chunk 1", "Sample resume text chunk 2"]  # Replace with actual loading
    qa = chat_with_document(chunks)
    return qa.run(query)