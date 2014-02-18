import json
import sys
import urllib2
import webapp2
from google.appengine.api import memcache
from google.appengine.ext import ndb
from models.station_model import StationModel


class CitybikesHandler(webapp2.RequestHandler):
    def get(self):
        station_json = self.get_station_json()
        # TODO: insert/update DB
        

    def get_station_json(self):
        response = urllib2.urlopen('http://api.citybik.es/goteborg.json')
        body = response.read()

        try:
            data = json.loads(body)
        except Exception, e:
            raise Exception, 'Failed to load the json: '+body, e

        if not data:
            raise Exception, 'Failed to decode the json: '+json, None

        return data

