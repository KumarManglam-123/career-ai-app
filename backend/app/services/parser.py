from langchain_openai import ChatOpenAI
from langchain.prompts import PromptTemplate
from ..config import settings
import json

PROMPT = """
Extract the following fields from the offer letter text.
Return JSON only.

Fields:
- candidate_name
- company_name
- position
- joining_date
- compensation

Text:
{text}
"""

def parse_offer_letter(text: str):
    llm = ChatOpenAI(temperature=0, openai_api_key=settings.openai_api_key)
    prompt = PromptTemplate(
        input_variables=["text"],
        template=PROMPT
    )
    response = llm.predict(prompt.format(text=text))
    return json.loads(response)