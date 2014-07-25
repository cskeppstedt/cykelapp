import json
import unittest
import webapp2
import webtest
from google.appengine.api import memcache
from google.appengine.ext import ndb, testbed
from backend.station_handler import StationHandler
from backend.models.station_model import StationModel
from backend.cronjobs.cronjobs_app import CronjobsApp
from backend.cronjobs.citybikes_handler import CitybikesHandler


class CitybikesTestApi:
    def get_station_objects(self):
        f = open('backend/tests/goeteborg.json', 'r')
        stations = json.load(f)
        f.close()
        return stations

class CronjobCitybikesTests(unittest.TestCase):
    def setUp(self):
        # set up the test app
        app = CronjobsApp()
        self.testapp = webtest.TestApp(app.make_app())
        CitybikesHandler.api_service = CitybikesTestApi()

        # set up the testbed
        self.testbed = testbed.Testbed()
        self.testbed.activate()
        self.testbed.init_datastore_v3_stub()
        self.testbed.init_memcache_stub()

    def tearDown(self):
        self.testbed.deactivate()

    def testGet(self):
        json_count = CitybikesHandler.api_service.get_station_objects()
        # repeat to see that models are added once only
        response = self.testapp.get('/cronjobs/citybikes')
        response = self.testapp.get('/cronjobs/citybikes')
        self.assertEqual(response.status_int, 200)
        models = [m for m in StationModel.query()]
        self.assertEqual(len(json_count), len(models))

