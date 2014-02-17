from google.appengine.ext import ndb

class StationModel(ndb.Model):
    """Represents a station from the CityBikes API."""
    api_id    = ndb.StringProperty()
    name      = ndb.StringProperty()
    location  = ndb.GeoPtProperty()
    timestamp = ndb.DateTimeProperty()
    bikes     = ndb.IntegerProperty()
    free      = ndb.IntegerProperty()

