def chat_with_document(chunks):
    from langchain_community.vectorstores import FAISS
    from langchain_openai import OpenAIEmbeddings, ChatOpenAI
    from langchain.chains.retrieval_qa.base import RetrievalQA
    from ..config import settings

    db = FAISS.from_texts(
        chunks,
        OpenAIEmbeddings(openai_api_key=settings.openai_api_key)
    )

    qa = RetrievalQA.from_chain_type(
        llm=ChatOpenAI(openai_api_key=settings.openai_api_key),
        retriever=db.as_retriever()
    )

    return qa


def get_chat_response(query, doc_id):
    # TODO: load real chunks using doc_id
    chunks = [
        "Sample resume text chunk 1",
        "Sample resume text chunk 2"
    ]

    qa = chat_with_document(chunks)
    return qa.run(query)
