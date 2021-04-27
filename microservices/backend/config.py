import os

from flask import current_app

basedir = os.path.abspath(os.path.dirname(__file__))


class Config:
    SECRET_KEY = os.environ.get("SECRET_KEY")
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    @staticmethod
    def init_app(app):
        pass


class DevelopmentConfig(Config):
    DEBUG = True
    SQLALCHEMY_DATABASE_URI = os.environ.get(
        "DEV_DATABASE_URL"
    ) or "sqlite:///" + os.path.join(basedir, "dev.sqlite")


class TestingConfig(Config):
    TESTING = True
    # Disable CSRF protection in the testing configuration
    WTF_CSRF_ENABLED = False


class StagingConfig(Config):
    SQLALCHEMY_DATABASE_URI = os.environ.get("STAGE_DATABASE_URL")


class ProductionConfig(Config):
    DEBUG = False


env_config = {
    "development": DevelopmentConfig,
    "testing": TestingConfig,
    "production": ProductionConfig,
    "staging": StagingConfig,
}