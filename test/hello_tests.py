import unittest
import webapp2
import webtest
from cykelapp.cykel_app import CykelApp

class HelloTests(unittest.TestCase):
    def setUp(self):
        app = CykelApp()
        self.testapp = webtest.TestApp(app.make_app())
        #self.testbed = testbed.Testbed()
        #self.testbed.activate()

    #def tearDown(self):
        #self.testbed.deactivate()

    def testGetHelloWorld(self):
        response = self.testapp.get('/hello/')
        
        self.assertEqual(response.status_int, 200)
        self.assertEqual(response.normal_body, 'Hello, World!')
