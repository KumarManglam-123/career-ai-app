from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    openai_api_key: str
    mongodb_uri: str

    model_config = SettingsConfigDict(
        env_file=".env",
        env_prefix=""
    )


settings = Settings()
