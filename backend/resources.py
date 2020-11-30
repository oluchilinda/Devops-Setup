from http import HTTPStatus

from models import Note
from flask_restful import Resource
from webargs.fields import Bool, Email, Int, Str
from webargs.flaskparser import use_kwargs



from flask_restful import Api, Resource


class DefaultResource(Resource):
    """Handle default route."""

    def get(self):
        """Get request for home page or response."""
        return {
            "status": "success",
            "data": {
                "msg": "Welcome to our diary API, let's get started"
            }
        }



class NoteListResource(Resource):
    def get(self):
        notes = Note.query.all()
        data = [note.data() for note in notes]

        if data:
            return {"data": data}, HTTPStatus.OK
        return {"msg": "no notes available"}, HTTPStatus.BAD_REQUEST

        
    @use_kwargs(
        {
            "title": Str(required=True, location="json"),
            "notes": Str(required=True, location="json"),
        }
    )
    
    def post(self, title, notes):

        note = Note(title=title, notes=notes)
        saved_notes = note.save()
        return (
            {
                "msg": "successfully created notes",
                "data": {
                    "title_of_post": title,
                    "contents_of_post": notes,
                },
            },
            HTTPStatus.CREATED,
        )
