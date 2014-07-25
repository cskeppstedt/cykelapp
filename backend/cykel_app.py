import webapp2
from hello_handler import HelloHandler
from stations_handler import StationsHandler
from station_handler import StationHandler


class CykelApp:
    instance = None
    def make_app(self):
        if self.instance == None:
            self.instance = webapp2.WSGIApplication([
                (r'/api/stations',       StationsHandler),
                (r'/api/stations/(\d+)', StationHandler)
            ], debug=True)

        return self.instance

application = CykelApp().make_app()
