from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

app = Flask(__name__)
# load the configuration of choice
app.config['SQLALCHEMY_DATABASE_URI'] = ''
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)


class Lesson(db.Model):
    __tablename__ = "lesson"
    id = db.Column(db.Integer, primary_key=True)
    subject_id = db.Column(db.Integer)
    descrption = db.Column(db.String(120), nullable=False)
    title = db.Column(db.String(120), nullable=False)
    date = db.Column(db.DateTime, nullable=False)


class Subject(db.Model):
    __tablename__ = "subject"
    id = db.Column(db.Integer, primary_key=True)
    descrption = db.Column(db.String(120), nullable=False)
    title = db.Column(db.String(120), nullable=False)


class virtualEntity(db.Model):
    __tablename__ = "virtualEntity"
    id = db.Column(db.Integer, primary_key=True)
    descrption = db.Column(db.String(120), nullable=False)
    title = db.Column(db.String(120), nullable=False)
    ObjectModelId = db.Column(db.Integer)
    quizId = db.Column(db.Integer)


class Quiz(db.Model):
    __tablename__ = "quiz"
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(120), nullable=False)


class Question(db.Model):
    __tablename__ = "question"
    id = db.Column(db.Integer, primary_key=True)
    question = db.Column(db.String(120), nullable=False)
    correctAmswer = db.Column(db.String(120), nullable=False)


class ObjectModel(db.Model):
    __tablename__ = "objectModel"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(120), nullable=False)


db.create_all()
