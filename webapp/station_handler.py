import json
import webapp2
from google.appengine.api import memcache
from google.appengine.ext import ndb
from cykelapp.models.station_model import StationModel
from cykelapp.webapp.api_request_handler import ApiRequestHandler


class StationHandler(ApiRequestHandler):
    def get(self, station_id):
        model = StationModel.query(StationModel.api_id==station_id).get()
        self.sendModel('station', model)
