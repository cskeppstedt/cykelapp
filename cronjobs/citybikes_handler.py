import json
import sys
import datetime
import urllib2
import webapp2
from google.appengine.api import memcache
from google.appengine.ext import ndb
from models.station_model import StationModel


class CitybikesApi:
    def get_station_objects(self):
        response = urllib2.urlopen('http://api.citybik.es/goeteborg.json')
        body = response.read()

        try:
            data = json.loads(body)
        except Exception, e:
            raise Exception, 'Failed to load the json: '+body, e

        if not data:
            raise Exception, 'Failed to decode the json: '+body, None

        return data


class CitybikesHandler(webapp2.RequestHandler):
    api_service = CitybikesApi()
    
    def get(self):
        stations = self.api_service.get_station_objects()
        for s in stations:
            s_id = str(s['id'])
            s_lat = float(s['lat']) / 1000000.0
            s_lng = float(s['lng']) / 1000000.0
            model = StationModel.get_or_insert(s_id)
            model.api_id = s_id
            model.name = s['name'].strip().title()
            model.bikes = int(s['bikes'])
            model.free = int(s['free'])
            model.location = ndb.GeoPt(s_lat, s_lng)
            model.timestamp = datetime.datetime.strptime(s['timestamp'], '%Y-%m-%dT%H:%M:%S.%fZ')
            model.put()

