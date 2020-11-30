from flasgger import Swagger
from flask import Flask
from flask_cors import CORS
from flask_migrate import Migrate
from flask_restful import Api
from webargs.flaskparser import abort, parser
from werkzeug import exceptions

import utils
from config import env_config
from models import db
from resources import DefaultResource, NoteListResource

api = Api()


def create_app(config_name):

    import resources

    app = Flask(__name__)

    app.config.from_object(env_config[config_name])

    db.init_app(app)  # Add db session, new code here

    Migrate(app, db)  # new code here
    # register api
    api.init_app(app)
    CORS(app)
    Swagger(app)

    app.register_error_handler(exceptions.NotFound,utils.handle_404_errors)

    app.register_error_handler(
        exceptions.InternalServerError, utils.handle_server_errors
    )

    app.register_error_handler(exceptions.BadRequest,utils.handle_400_errors)

    app.register_error_handler(FileNotFoundError,utils.handle_400_errors)

    app.register_error_handler(TypeError,utils.handle_400_errors)

    app.register_error_handler(KeyError,utils.handle_404_errors)

    app.register_error_handler(AttributeError,utils.handle_400_errors)

    app.register_error_handler(ValueError,utils.handle_400_errors)

    app.register_error_handler(AssertionError,utils.handle_400_errors)

    # new code
    @parser.error_handler
    def handle_request_parsing_error(
        err, req, schema, *, error_status_code, error_headers
    ):
        """webargs error handler that uses Flask-RESTful's abort function to return
        a JSON error response to the client.
        """
        abort(error_status_code, errors=err.messages)

    return app


# register our urls for user module
api.add_resource(NoteListResource, "/v1/notes/", endpoint="notes")

api.add_resource(DefaultResource, "/home/")
