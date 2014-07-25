import json
import sys
import datetime
import logging
import urllib2
import webapp2
from hashlib import md5
from google.appengine.api import memcache
from google.appengine.ext import ndb
from backend.models.station_model import StationModel


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
            s = self.format_station(s)
            model = StationModel.get_or_insert(s['id'])
            if not self.station_has_changed(s, model):
                continue

            model.api_id = s['id']
            model.name = s['name']
            model.bikes = s['bikes']
            model.free = s['free']
            model.location = s['location']
            model.timestamp = s['timestamp']
            model.put()

    def format_station(self, station):
        lat = float(station['lat']) / 1000000.0
        lon = float(station['lng']) / 1000000.0


        station['name'] = station['name'].strip().title()
        station['id'] = str(station['id'])
        station['bikes'] = int(station['bikes'])
        station['free']= int(station['free'])
        station['location'] = ndb.GeoPt(lat,lon)
        station['timestamp'] = self.parse_date(station['timestamp'])
        return station

    def parse_date(self, date_str):
        try:
            fmt = '%Y-%m-%dT%H:%M:%S.%fZ'
            return datetime.datetime.strptime(date_str, fmt)
        except ValueError:
            fmt = '%Y-%m-%dT%H:%M:%SZ'
            return datetime.datetime.strptime(date_str, fmt)

    def station_has_changed(self, station, model):
        if model.api_id == None or model.api_id == "":
            logging.info('Updating %s: this is a new entry', station['id'])
            return True
        if station['name'] != model.name:
            logging.info('Updating %s: name changed from %s to %s', station['id'], model.name or '', station['name'])
            return True
        if station['bikes'] != model.bikes:
            logging.info('Updating %s: bikes changed from %d to %d', station['id'], model.bikes or 0, station['bikes'])
            return True
        if station['free'] != model.free:
            logging.info('Updating %s: free changed from %d to %d', station['id'], model.free or 0, station['free'])
            return True
        if station['location'] != model.location and model.location != None:
            logging.info('Updating %s: location changed from (%s) to (%s)', station['id'], str(model.location), str(station['location']))
            return True

        return False
