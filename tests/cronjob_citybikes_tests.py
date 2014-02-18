import json
import unittest
import webapp2
import webtest
from google.appengine.api import memcache
from google.appengine.ext import ndb, testbed
from cronjobs.cronjobs_app import CronjobsApp
from webapp.station_handler import StationHandler
from models.station_model import StationModel
from cronjobs.citybikes_handler import CitybikesHandler


class CronjobCitybikesTests(unittest.TestCase):
    def setUp(self):
        # set up the test app
        app = CronjobsApp()
        self.testapp = webtest.TestApp(app.make_app())
        
        # set up the testbed
        self.testbed = testbed.Testbed()
        self.testbed.activate()
        self.testbed.init_datastore_v3_stub()
        self.testbed.init_memcache_stub()

    def tearDown(self):
        self.testbed.deactivate()

    def testGet(self):
        response = self.testapp.get('/citybikes')
        self.assertEqual(response.status_int, 200)

