import webapp2
from citybikes_handler import CitybikesHandler


class CronjobsApp:
    def make_app(self):
        return webapp2.WSGIApplication([
            (r'/cronjobs/citybikes', CitybikesHandler),
        ], debug=True)

application = CronjobsApp().make_app()
