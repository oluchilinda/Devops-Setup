from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.exc import IntegrityError, SQLAlchemyError

from datetime import datetime

db = SQLAlchemy()




class BaseModel(db.Model):
    """Define the base model for all other models."""

    __abstract__ = True
    id = db.Column(db.Integer(), primary_key=True)
    created_on = db.Column(db.DateTime(), server_default=db.func.now(), nullable=False)
    updated_on = db.Column(db.DateTime(),nullable=False,
                           server_default=db.func.now(),
                           onupdate=db.func.now())
    def save(self):
        """Save an instance of the model from the database."""
        try:
            db.session.add(self)
            db.session.commit()     
        except IntegrityError:
            db.session.rollback()
        except SQLAlchemyError:
            db.session.rollback()

    def update(self):
        """Update an instance of the model from the database."""
        return db.session.commit()


    def delete(self):
        """Delete an instance of the model from the database."""
        try:
            db.session.delete(self)
            db.session.commit()
        except SQLAlchemyError:
            db.session.rollback()
            
    




class Note(BaseModel):
    __tablename__ = 'note'

    title = db.Column(db.String(100), nullable=False)
    notes = db.Column(db.String(1000))
    
    def data(self):
        return {
            'id': self.id,
            'title': self.title,
            'notes': self.notes,
            'created_at':self.created_on.strftime('%Y-%m-%d %H:%M:%S')

        }

    







