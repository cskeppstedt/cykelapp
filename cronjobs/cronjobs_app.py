import webapp2
from citybikes_handler import CitybikesHandler


class CronjobsApp:
    instance = None
    def make_app(self):
        if self.instance == None:
            self.instance = webapp2.WSGIApplication([
                (r'/cronjobs/citybikes', CitybikesHandler),
            ], debug=True)

        return self.instance

application = CronjobsApp().make_app()
