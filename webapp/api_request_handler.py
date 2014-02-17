import json
import webapp2
from google.appengine.api import memcache
from google.appengine.ext import ndb


class ApiRequestHandler(webapp2.RequestHandler):
    """
    A common request handler that sends JSON data.
    Expects model (or models) to be derived from ndb.Model.
    """

    def sendModel(self, json_prop_name, model):
        if model is None:
            self.send404()
        else:
            self.sendJsonDict({ json_prop_name : model.to_dict() })

    def sendModels(self, json_prop_name, models):
        if models is None:
            self.send404()
        elif len(models) == 0:
            self.send404()
        else:
            model_dicts = [m.to_dict() for m in models]
            self.sendJsonDict({ json_prop_name : model_dicts })

    def sendJsonDict(self, json_dict):
        self.response.headers['Content-Type'] = 'application/json'
        self.response.write(json.dumps(json_dict))

    def send404(self):
        self.response.status = '404 Not Found'

