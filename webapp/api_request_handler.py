import calendar, datetime
import json
import webapp2
from google.appengine.api import memcache
from google.appengine.ext import ndb


class JsonHandler:
    def handler(self, obj):
        if isinstance(obj, datetime.datetime) or isinstance(obj, datetime.date):
            return obj.isoformat()
        elif isinstance(obj, ndb.GeoPt):
            return {"lat": obj.lat, "lon": obj.lon}
        else:
            return None


class ApiRequestHandler(webapp2.RequestHandler):
    """
    A common request handler that sends JSON data.
    Expects model (or models) to be derived from ndb.Model.
    """
    json_handler = JsonHandler()
    def sendModel(self, json_prop_name, model):
        if model is None:
            self.send404()
        else:
            self.sendJsonDict({ json_prop_name : model.to_dict() })

    def sendModels(self, json_prop_name, models):
        if models is None:
            self.send404()
        else:
            model_dicts = [m.to_dict() for m in models]
            self.sendJsonDict({ json_prop_name : model_dicts })

    def sendJsonDict(self, json_dict):
        dump = json.dumps(json_dict, default=self.json_handler.handler)
        self.response.headers['Content-Type'] = 'application/json'
        self.response.write(dump)

    def send404(self):
        self.response.status = '404 Not Found'


