import webapp2
from hello_handler import HelloHandler


class CykelApp:
    def make_app(self):
        return webapp2.WSGIApplication([
            ('/hello/', HelloHandler)
        ], debug=True)

cykel_app = CykelApp()
application = cykel_app.make_app()
