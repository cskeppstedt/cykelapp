import json
import unittest
import webapp2
import webtest
from google.appengine.api import memcache
from google.appengine.ext import ndb, testbed
from backend.cykel_app import CykelApp
from backend.stations_handler import StationsHandler
from backend.models.station_model import StationModel


class StationsHandlerTests(unittest.TestCase):
    def setUp(self):
        # set up the test app
        app = CykelApp()
        self.testapp = webtest.TestApp(app.make_app())

        # set up the testbed
        self.testbed = testbed.Testbed()
        self.testbed.activate()
        self.testbed.init_datastore_v3_stub()
        self.testbed.init_memcache_stub()

        StationModel(id="1", api_id="1", name="test 1").put()
        StationModel(id="2", api_id="2", name="test 2").put()
        StationModel(id="3", api_id="3", name="test 3").put()

    def tearDown(self):
        self.testbed.deactivate()

    def testGetStations(self):
        response = self.testapp.get('/api/stations')
        self.assertEqual(response.status_int, 200)

        decoded = json.loads(response.body)
        self.assertIsNotNone(decoded)

        stations = decoded['stations']
        self.assertIsNotNone(stations)
        self.assertEqual(len(stations), 3)
