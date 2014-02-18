import json
import webapp2
from google.appengine.api import memcache
from google.appengine.ext import ndb
from models.station_model import StationModel
from webapp.api_request_handler import ApiRequestHandler


class StationsHandler(ApiRequestHandler):
    def get(self):
        models = [m for m in StationModel.query()]
        self.sendModels('stations', models)

