import cx_Oracle

import os
import sqlalchemy as sql
from sqlalchemy import Column, Integer, Text
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

base = declarative_base()


class SomeObject(base):
    __tablename__ = "someobjects"
    sid = Column(Integer, primary_key=True)
    name = Column(Text)


engine = sql.create_engine(
    "oracle://{}:{}@{}:{}/{}".format(os.getenv("UID", "system"), os.getenv("PASSWORD", "oracle"),
                                     os.getenv("HOST", "localhost"), os.getenv("PORT", "1521"),
                                     os.getenv("DATABASE", "xe")))
base.metadata.create_all(engine)
Session = sessionmaker(engine)


def read_db():
    session = Session()


if __name__ == "__main__":
    read_db()
