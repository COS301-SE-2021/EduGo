from swagger_server.db.sqlalchemy import db, ma
from datetime import datetime


class Lesson(db.Model):
    lesson_id = db.Column(db.Integer, primary_key=True)
    lesson_description = db.Column(db.Text, nullable=False, default='N/A')
    # nullable false because it's required
    subject_id = db.Column(db.Integer, nullable=False, nullable=False)
    # define relationship, backref is a way to declare a new property  in Question class, lazy means load data from db
    questions = db.relationship('Question', backref='lesson', lazy=True)
    date = db.Column(db.DateTime.date, nullable=False, default=datetime.utcnow)
    start_time = db.Column(
        db.DateTime.time, nullable=False, default=datetime.utcnow)
    end_time = db.Column(db.DateTime.time, nullable=False,
                         default=datetime.utcnow)

    def repr(self):  # print out every time we create lesson
        return 'Lesson' + str(self.lessonId) + ' created'
