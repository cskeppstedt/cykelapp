import webapp2


class HelloHandler(webapp2.RequestHandler):
    def get(self):
        self.response.headers['Content-Type'] = 'text/plain'
        self.response.write('Hello, World!')

class CykelApp:
    def make_app(self):
        return webapp2.WSGIApplication([
            ('/hello/', HelloHandler)
        ], debug=True)

cykel_app = CykelApp()
application = cykel_app.make_app()
