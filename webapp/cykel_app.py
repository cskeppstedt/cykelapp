import webapp2
from hello_handler import HelloHandler
from stations_handler import StationsHandler
from station_handler import StationHandler


class CykelApp:
    def make_app(self):
        return webapp2.WSGIApplication([
            (r'/hello',          HelloHandler),
            (r'/stations',       StationsHandler),
            (r'/stations/(\d+)', StationHandler)
        ], debug=True)

cykel_app = CykelApp()
application = cykel_app.make_app()
